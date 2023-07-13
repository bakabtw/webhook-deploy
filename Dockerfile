FROM almir/webhook
COPY hooks.json /etc/webhook/hooks.json
COPY deploy.sh /usr/local/bin/deploy.sh