FROM docker.io/n8nio/n8n:latest

USER root
COPY start.sh /start.sh
COPY workflows /workflows
RUN chmod +x /start.sh && chown -R node:node /workflows

USER node
EXPOSE 5678 7860

ENTRYPOINT ["/bin/sh", "/start.sh"]
