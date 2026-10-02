#!/bin/sh
set -e

export N8N_PORT="${PORT:-${N8N_PORT:-5678}}"
export N8N_LISTEN_ADDRESS="0.0.0.0"
export N8N_PROTOCOL="${N8N_PROTOCOL:-https}"
export GENERIC_TIMEZONE="${GENERIC_TIMEZONE:-Africa/Nouakchott}"
export TZ="${TZ:-Africa/Nouakchott}"
export N8N_SAMESITE_COOKIE="${N8N_SAMESITE_COOKIE:-none}"
export N8N_SECURE_COOKIE="${N8N_SECURE_COOKIE:-true}"
export N8N_DIAGNOSTICS_ENABLED="false"
export N8N_PERSONALIZATION_ENABLED="false"

# Si RENDER_EXTERNAL_URL ou SPACE_HOST est défini, configurer automatiquement WEBHOOK_URL
if [ -n "$RENDER_EXTERNAL_URL" ] && [ -z "$WEBHOOK_URL" ]; then
  export WEBHOOK_URL="${RENDER_EXTERNAL_URL}/"
  export N8N_EDITOR_BASE_URL="${RENDER_EXTERNAL_URL}/"
elif [ -n "$SPACE_HOST" ] && [ -z "$WEBHOOK_URL" ]; then
  export WEBHOOK_URL="https://${SPACE_HOST}/"
  export N8N_EDITOR_BASE_URL="https://${SPACE_HOST}/"
fi

# Boucle Keep-Alive en arrière-plan (toutes les 5 minutes) pour empêcher la mise en veille
(
  sleep 45
  while true; do
    if [ -n "$WEBHOOK_URL" ]; then
      wget -q -O /dev/null "${WEBHOOK_URL}healthz" 2>/dev/null || true
    fi
    wget -q -O /dev/null "http://127.0.0.1:${N8N_PORT}/healthz" 2>/dev/null || true
    sleep 300
  done
) &

exec n8n start
