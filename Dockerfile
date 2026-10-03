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
    N8N_SECURE_COOKIE=true \
    WEBHOOK_URL=https://n8n-service-e8p0.onrender.com/ \
    N8N_EDITOR_BASE_URL=https://n8n-service-e8p0.onrender.com/ \
    GENERIC_TIMEZONE=Africa/Nouakchott \
    TZ=Africa/Nouakchott

EXPOSE 5678

ENTRYPOINT ["/bin/sh", "-c", "(sleep 25; node -e 'fetch(\"http://127.0.0.1:5678/rest/owner/setup\",{method:\"POST\",headers:{\"Content-Type\":\"application/json\"},body:JSON.stringify({email:\"contact.waktpay@gmail.com\",firstName:\"Waktwassal\",lastName:\"WaktPay\",password:\"WaktPayN8n2026!\"})}).catch(()=>{})'; while true; do sleep 240; node -e 'fetch(\"https://n8n-service-e8p0.onrender.com/healthz\").catch(()=>{})'; done) & exec n8n start"]
