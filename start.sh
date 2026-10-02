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
export N8N_VERSION_NOTIFICATIONS_ENABLED="false"
export N8N_HIRING_BANNER_ENABLED="false"

# Détection automatique de l'URL publique (Render, Hugging Face Spaces, Koyeb)
if [ -n "$RENDER_EXTERNAL_URL" ] && [ -z "$WEBHOOK_URL" ]; then
  export WEBHOOK_URL="${RENDER_EXTERNAL_URL%/}/"
  export N8N_EDITOR_BASE_URL="${RENDER_EXTERNAL_URL%/}/"
elif [ -n "$SPACE_HOST" ] && [ -z "$WEBHOOK_URL" ]; then
  export WEBHOOK_URL="https://${SPACE_HOST%/}/"
  export N8N_EDITOR_BASE_URL="https://${SPACE_HOST%/}/"
elif [ -n "$KOYEB_PUBLIC_DOMAIN" ] && [ -z "$WEBHOOK_URL" ]; then
  export WEBHOOK_URL="https://${KOYEB_PUBLIC_DOMAIN%/}/"
  export N8N_EDITOR_BASE_URL="https://${KOYEB_PUBLIC_DOMAIN%/}/"
fi

# Initialisation automatique du compte Owner + Keep-Alive 24/7 en arrière-plan
(
  # Attendre que n8n soit prêt
  for i in $(seq 1 60); do
    if wget -q -O /dev/null "http://127.0.0.1:${N8N_PORT}/healthz" 2>/dev/null; then
      break
    fi
    sleep 2
  done

  # Configurer automatiquement le compte Owner au premier démarrage
  wget -q -O /dev/null \
    --header="Content-Type: application/json" \
    --post-data='{"email":"contact.waktpay@gmail.com","firstName":"Waktwassal","lastName":"WaktPay","password":"WaktPayN8n2026!"}' \
    "http://127.0.0.1:${N8N_PORT}/rest/owner/setup" 2>/dev/null || true

  # Boucle Anti-Veille (toutes les 4 minutes < 15 minutes Render)
  while true; do
    if [ -n "$WEBHOOK_URL" ]; then
      wget --header="User-Agent: WaktPay-KeepAlive/1.0" -q -O /dev/null "${WEBHOOK_URL}healthz" 2>/dev/null || true
      wget --header="User-Agent: WaktPay-KeepAlive/1.0" -q -O /dev/null "${WEBHOOK_URL}webhook/status" 2>/dev/null || true
    fi
    wget -q -O /dev/null "http://127.0.0.1:${N8N_PORT}/healthz" 2>/dev/null || true
    sleep 240
  done
) &

exec n8n start
