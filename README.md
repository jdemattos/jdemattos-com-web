# jdemattos-com-web
Site for [jdemattos.com](https://jdemattos.com).

# Dependencies
- [docker](https://www.docker.com/): container platform
  - [caddy (container image)](https://hub.docker.com/_/caddy): caddy container image
    - [caddy](https://caddyserver.com/): web server

# Usage
## Local development
Run caddy-dev instance that listens on `http://:8080` or port of choice.

```bash
docker run --interactive --tty --rm \
  --name caddy-dev \
  --volume ${PWD}/Caddyfile-dev:/srv/Caddyfile:ro \
  --volume ${PWD}/static:/srv/static:ro \
  --publish 8080:80 \
  caddy \
  caddy run

# OPTIONAL: verify that the web server is working
curl http://localhost:8080
```

## Production deployment
Run caddy service that listens on `https` and `http` for redirects with [Let's Encrypt](https://letsencrypt.org/) for TLS.

```bash
# run as service
CADDY_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/caddy"
docker run --detach --restart unless-stopped \
  --name caddy \
  --volume ${PWD}/Caddyfile:/srv/Caddyfile:ro \
  --volume ${PWD}/static:/srv/static:ro \
  --volume ${CADDY_DATA_HOME}/data:/data \
  --volume ${CADDY_DATA_HOME}/config:/config \
  --publish 80:80 \
  --publish 443:443 \
  caddy \
  caddy run

# OPTIONAL: verify that the web server is working
curl https://jdemattos.com --resolve jdemattos.com:443:127.0.0.1

# OPTIONAL: clean up
docker stop caddy
docker rm --volumes caddy
```
