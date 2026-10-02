---
title: Mon N8N WaktPay
emoji: ⚡
colorFrom: red
colorTo: orange
sdk: docker
app_port: 5678
pinned: true
---

# ⚡ Mon n8n (WaktPay) — Serveur Configuré Sans Veille (24/7)

## 🌐 URL Fonctionnelle en Direct

- **Interface Éditeur n8n** : [**https://5678-iskgj1djaxd4dldx1oft3.e2b.app**](https://5678-iskgj1djaxd4dldx1oft3.e2b.app)
- **Webhook API Status (Actif)** : [**https://5678-iskgj1djaxd4dldx1oft3.e2b.app/webhook/status**](https://5678-iskgj1djaxd4dldx1oft3.e2b.app/webhook/status)
- **Endpoint de Santé (`/healthz`)** : [**https://5678-iskgj1djaxd4dldx1oft3.e2b.app/healthz**](https://5678-iskgj1djaxd4dldx1oft3.e2b.app/healthz)

### 🔑 Identifiants Administrateur (Owner)
*(La connexion automatique est déjà activée sur l'URL ci-dessus, vous arrivez directement dans l'éditeur)*
- **Email** : `contact.waktpay@gmail.com`
- **Mot de passe** : `WaktPayN8n2026!`
- **Fuseau horaire** : `Africa/Nouakchott` (UTC+0)

---

## 🛡️ Architecture Anti-Veille (Triple Protection 24/7)

Ce dépôt a été entièrement reconfiguré pour empêcher toute mise en veille :

1. **Workflow interne n8n actif (`workflows/keep-alive-status.json`)** :
   - Déclencheur planifié toutes les **10 minutes** qui interroge `/healthz`.
   - Webhook public `/webhook/status` qui répond en JSON avec l'état opérationnel du serveur.
2. **Démon Keep-Alive intégré au conteneur (`start.sh` & `Dockerfile`)** :
   - Détecte automatiquement l'URL publique (`RENDER_EXTERNAL_URL` sur Render ou `SPACE_HOST` sur Hugging Face Spaces) pour configurer `WEBHOOK_URL` et `N8N_EDITOR_BASE_URL` sans intervention manuelle.
   - Envoie un ping automatique toutes les **5 minutes** vers l'URL publique externe.
3. **GitHub Actions Cron Externe (`.github/workflows/keep-alive.yml`)** :
   - Ping externe toutes les **10 minutes** depuis les serveurs GitHub vers `/healthz` et `/webhook/status` afin que le répartiteur de charge (Render / Hugging Face / Koyeb) ne mette jamais le conteneur en veille.

---

## 🚀 Déploiement Cloud Gratuit en 1 Clic

### Option 1 : Déployer sur Render (Blueprint préconfiguré)
Cliquez sur le bouton ci-dessous pour déployer une nouvelle instance complète :

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=https://github.com/contactwaktpay-wq/mon-n8n)

### Option 2 : Déployer sur Hugging Face Spaces (Gratuit : 2 vCPU, 16 Go RAM, sans expiration 30j)
L'en-tête YAML de ce `README.md` et le `Dockerfile` rendent ce dépôt directement compatible avec **Hugging Face Spaces (SDK Docker)** sur le port `5678` combiné à une base PostgreSQL gratuite permanente (**Supabase** ou **Neon.tech**).
