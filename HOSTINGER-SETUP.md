# إعداد Hostinger لحل مشكلة Deployment

## المشكلة:
```
fatal: Need to specify how to reconcile divergent branches.
```

## الحل السريع:

### الطريقة 1: عبر SSH (الأفضل)

1. اتصل بـ Hostinger عبر SSH
2. انتقل إلى مجلد المشروع:
   ```bash
   cd ~/public_html
   # أو
   cd ~/domains/yourdomain.com/public_html
   ```
3. نفّذ هذا الأمر:
   ```bash
   git config pull.rebase false
   ```
4. أو استخدم الـ script:
   ```bash
   chmod +x setup-hostinger.sh
   ./setup-hostinger.sh
   ```

### الطريقة 2: عبر cPanel

1. اذهب إلى **Git Version Control** في cPanel
2. ابحث عن **Settings** أو **Configuration**
3. أضف هذا الإعداد:
   ```
   pull.rebase = false
   ```

### الطريقة 3: Force Reset (إذا لم تكن هناك تغييرات مهمة)

```bash
git fetch origin
git reset --hard origin/main
```

## بعد الإعداد:

سيتم حل المشكلة وسيعمل Auto Deployment تلقائياً عند كل push إلى GitHub.
