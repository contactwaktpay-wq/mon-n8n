FROM docker.io/n8nio/n8n:1.85.4

ENV NODE_OPTIONS="--max-old-space-size=350" \
    PORT=5678 \
    N8N_PORT=5678 \
    N8N_LISTEN_ADDRESS=0.0.0.0 \
    N8N_PROTOCOL=https \
    DB_TYPE=sqlite \
    N8N_RUNNERS_ENABLED=false \
    N8N_DIAGNOSTICS_ENABLED=false \
    N8N_PERSONALIZATION_ENABLED=false \
    N8N_VERSION_NOTIFICATIONS_ENABLED=false \
    N8N_HIRING_BANNER_ENABLED=false \
    EXECUTIONS_DATA_PRUNE=true \
    EXECUTIONS_DATA_MAX_AGE=24 \
    EXECUTIONS_DATA_SAVE_ON_SUCCESS=none \
    N8N_SAMESITE_COOKIE=none \
    N8N_SECURE_COOKIE=true \
    WEBHOOK_URL=https://n8n-service-e8p0.onrender.com/ \
    N8N_EDITOR_BASE_URL=https://n8n-service-e8p0.onrender.com/ \
    GENERIC_TIMEZONE=Africa/Nouakchott \
    TZ=Africa/Nouakchott

EXPOSE 5678
