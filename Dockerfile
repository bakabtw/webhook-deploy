# Dockerfile for https://github.com/adnanh/webhook
# Credits: https://github.com/almir/docker-webhook/
FROM        golang:alpine AS build
MAINTAINER  Eugene Konstantinov <contact@knst.me>
WORKDIR     /go/src/github.com/adnanh/webhook
ENV         WEBHOOK_VERSION 2.8.1
RUN         apk add --update -t build-deps curl libc-dev gcc libgcc
RUN         curl -L --silent -o webhook.tar.gz https://github.com/adnanh/webhook/archive/${WEBHOOK_VERSION}.tar.gz && \
            tar -xzf webhook.tar.gz --strip 1
RUN         go get -d -v
RUN         CGO_ENABLED=0 go build -ldflags="-s -w" -o /usr/local/bin/webhook

FROM        alpine
COPY        --from=build /usr/local/bin/webhook /usr/local/bin/webhook
WORKDIR     /etc/webhook
VOLUME      ["/etc/webhook"]
EXPOSE      9000
ENTRYPOINT  ["/usr/local/bin/webhook"]

RUN apk add --update git docker docker-compose && \
     rm -rf /var/cache/apk/*

COPY hooks.json /etc/webhook/hooks.json
COPY deploy.sh /usr/local/bin/deploy.sh

CMD ["-verbose", "-hooks=/etc/webhook/hooks.json", "-hotreload"]