FROM almir/webhook

RUN  apk --update --upgrade add docker curl bash && \
     rm -rf /var/cache/apk/*

COPY hooks.json /etc/webhook/hooks.json
COPY deploy.sh /usr/local/bin/deploy.sh