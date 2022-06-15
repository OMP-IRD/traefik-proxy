# traefik-proxy
Use Traefik as a global proxy for a given server

## Run
- Adjust the FQDN in the .env file
- Use secrets-dev as model for a secrets-prod folder (`cp -r secrets-dev secrets-prod`) and change the password (`htpasswd -nb admin mysupersecurepassword` to generate the secured password)
- start the composition `docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d`

## Use traefik-proxy to proxy your apps
In the project's docker-compose:
- add
```
networks:
  traefik-proxy_proxy_network:
    external: true
```
- declare `traefik-proxy_proxy_network` as network for the container you want to expose
- add some labels. e.g.
```
    labels:
    - "traefik.enable=true"
    # Tell traefik which network to look on, since this container is connected to 2 different nets
    - "traefik.docker.network=traefik-proxy_proxy_network"
    # HTTPS router
    - "traefik.http.routers.pg-tileserv-secure.entrypoints=websecure"
    - "traefik.http.routers.pg-tileserv-secure.rule=( Host(`localhost`) || Host(`mgb-hyfaa.pigeo.fr`) || Host(`hyfaa.pigeo.fr`)) && PathPrefix(`/tiles`)"
    - "traefik.http.routers.pg-tileserv-secure.tls=true"
    - "traefik.http.routers.pg-tileserv-secure.tls.certresolver=letsEncrypt"
    - "traefik.http.routers.pg-tileserv-secure.tls.domains[0].main=mgb-hyfaa.pigeo.fr"
    - "traefik.http.routers.pg-tileserv-secure.tls.domains[0].sans=hyfaa.pigeo.fr"
```
