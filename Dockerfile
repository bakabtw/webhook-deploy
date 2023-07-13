FROM almir/webhook

RUN apk --update add docker && \
     rm -rf /var/cache/apk/*

COPY hooks.json /etc/webhook/hooks.json
COPY deploy.sh /usr/local/bin/deploy.sh