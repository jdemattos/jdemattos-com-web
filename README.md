# jdemattos-com-web
Site for [jdemattos.com](https://jdemattos.com).

# Dependencies
- [caddy](https://caddyserver.com/): web server
- [docker](https://www.docker.com/): container platform
- [abiosoft/caddy](https://hub.docker.com/r/abiosoft/caddy/): caddy docker container

# Usage
## Getting the code
Fetch configs and static web files for serving for the first time.

```bash
cd ~
git clone https://github.com/jdemattos/jdemattos-com-web.git
```

Or update the existing git repo.

```bash
cd ~/jdemattos-com-web
git checkout master
git pull origin master
```

> This README assumes the code lives in `~/jdemattos-com-web`.

## Local development
Run web server locally for development and listen on port `2015`.

```bash
sudo docker run \
    --detach \
    --name jdemattos-com-web-dev \
    --volume $HOME/jdemattos-com-web/caddy/Caddyfile-dev:/etc/Caddyfile \
    --volume $HOME/jdemattos-com-web/www:/srv \
    --publish 2015:2015 \
    abiosoft/caddy
```

Verify that the web server is running. (optional)

```bash
curl http://localhost:2015
```

Stop container and clean up when done. (optional)

```bash
sudo docker stop caddy-jdemattos-com-dev
sudo docker rm --volumes caddy-jdemattos-com-dev
```

## Production deployment
Run web server for production and listen on `https`. (`http` for redirects)

```bash
sudo docker run \
    --detach \
    --name jdemattos-com-web \
    --restart always \
    --volume $HOME/jdemattos-com-web/caddy/Caddyfile:/etc/Caddyfile \
    --volume $HOME/jdemattos-com-web/www:/srv \
    --volume $HOME/.caddy:/root/.caddy \
    --publish 80:80 \
    --publish 443:443 \
    --env ACME_AGREE=true \
    abiosoft/caddy
```
