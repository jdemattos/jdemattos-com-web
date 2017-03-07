# based on abiosoft/caddy-docker

FROM alpine:3.5

ARG features=

RUN apk add --no-cache tar curl
RUN curl --silent --show-error --fail --location --output - \
  --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" \
  "https://caddyserver.com/download/build?os=linux&arch=amd64&features=${features}" \
    | tar --no-same-owner -C /usr/local/bin/ -xz caddy \
  && chmod 0755 /usr/local/bin/caddy \
  && /usr/local/bin/caddy -version

ENV PATH /usr/local/bin:$PATH
ENV CADDYPATH /etc/caddy/certs

VOLUME /etc/caddy/certs
VOLUME /var/log/caddy

ADD ./www /var/www
ADD ./caddy /etc/caddy

WORKDIR /var/www

CMD ["caddy", "-agree", "-quic", "-conf=/etc/caddy/Caddyfile"]
