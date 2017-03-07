# jdemattos-com-web
Frontend website for [jdemattos.com](https://jdemattos.com).

# Requirements
- [caddy](https://caddyserver.com/): For local development
- [docker](https://www.docker.com/): For deployment
- [docker-compose](https://github.com/docker/compose): For deployment

# Usage
## Local development
The development server will be listening on 0.0.0.0:2015.

```bash
git clone https://github.com/jdemattos/jdemattos-com-web.git
cd jdemattos-com-web
caddy -conf=caddy/Caddyfile-dev -root=www
```

## Deploying staging docker containers
The staging container will be listening on 0.0.0.0:2015.

```bash
docker-compose -f docker-compose.dev.yml up --build
```

## Deploying production docker containers
The production container will be listening on jdemattos.com:443 with TLS and :80 for redirects.

```bash
docker-compose up -d --build
```
