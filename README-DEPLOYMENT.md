# Hostinger Deployment Fix

## المشكلة:
Hostinger يعطي خطأ: "divergent branches"

## الحل:

### الطريقة 1: عبر SSH في Hostinger

اتصل بـ Hostinger عبر SSH ثم نفذ:

```bash
cd ~/public_html  # أو مسار المشروع الخاص بك
git config pull.rebase false
git fetch origin
git reset --hard origin/main
```

### الطريقة 2: عبر cPanel في Hostinger

1. اذهب إلى Git Version Control في cPanel
2. أضف هذا الإعداد: `pull.rebase = false`
3. أو استخدم "Force Pull" من GitHub

### الطريقة 3: استخدام Script

قم برفع ملف `fix-hostinger-deployment.sh` إلى Hostinger ثم نفذ:

```bash
chmod +x fix-hostinger-deployment.sh
./fix-hostinger-deployment.sh
```

## بعد الحل:

سيتم التزامن تلقائياً عند كل push إلى GitHub عبر Webhook.
