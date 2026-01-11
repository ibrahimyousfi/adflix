# Server Configuration Recommendations

This document outlines the server-side headers that should be configured to improve Lighthouse scores and security. These cannot be set via HTML meta tags and must be configured on your web server.

## Required Security Headers

### 1. Content Security Policy (CSP)
**Priority: High**

Set via HTTP header (preferred over meta tag):
```
Content-Security-Policy: default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://cdn.jsdelivr.net https://fast.wistia.com https://connect.facebook.net https://script.google.com; style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://cdnjs.cloudflare.com https://fonts.googleapis.com; font-src 'self' https://cdnjs.cloudflare.com https://fonts.gstatic.com; img-src 'self' data: https:; frame-src 'self' https://fast.wistia.net https://fast.wistia.com; connect-src 'self' https://connect.facebook.net https://script.google.com; object-src 'none'; base-uri 'self'; form-action 'self' https://script.google.com;
```

### 2. HTTP Strict Transport Security (HSTS)
**Priority: High**

```
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
```

**Note:** Start with a shorter max-age (e.g., 86400) and gradually increase. Only use `preload` after thorough testing.

### 3. Cross-Origin Opener Policy (COOP)
**Priority: High**

```
Cross-Origin-Opener-Policy: same-origin
```

### 4. X-Frame-Options
**Priority: High**

```
X-Frame-Options: SAMEORIGIN
```

**Note:** This can also be set via CSP `frame-ancestors` directive, but X-Frame-Options provides better browser compatibility.

### 5. Trusted Types (for DOM-based XSS protection)
**Priority: Medium**

Add to CSP header:
```
require-trusted-types-for 'script'
```

## Performance Headers

### 6. Cache Control
Set appropriate cache headers for static assets:

```
# For HTML files
Cache-Control: public, max-age=3600, must-revalidate

# For CSS/JS files
Cache-Control: public, max-age=31536000, immutable

# For images
Cache-Control: public, max-age=31536000, immutable
```

### 7. Compression
Enable gzip or brotli compression for text-based resources (HTML, CSS, JS).

## Implementation Examples

### Apache (.htaccess)
```apache
<IfModule mod_headers.c>
    # CSP
    Header set Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://cdn.jsdelivr.net https://fast.wistia.com https://connect.facebook.net https://script.google.com; style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://cdnjs.cloudflare.com https://fonts.googleapis.com; font-src 'self' https://cdnjs.cloudflare.com https://fonts.gstatic.com; img-src 'self' data: https:; frame-src 'self' https://fast.wistia.net https://fast.wistia.com; connect-src 'self' https://connect.facebook.net https://script.google.com; object-src 'none'; base-uri 'self'; form-action 'self' https://script.google.com;"
    
    # HSTS (only if using HTTPS)
    Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"
    
    # COOP
    Header set Cross-Origin-Opener-Policy "same-origin"
    
    # X-Frame-Options
    Header set X-Frame-Options "SAMEORIGIN"
    
    # X-Content-Type-Options
    Header set X-Content-Type-Options "nosniff"
    
    # Referrer Policy
    Header set Referrer-Policy "strict-origin-when-cross-origin"
</IfModule>

<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType text/html "access plus 1 hour"
    ExpiresByType text/css "access plus 1 year"
    ExpiresByType application/javascript "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/webp "access plus 1 year"
</IfModule>
```

### Nginx
```nginx
add_header Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://cdn.jsdelivr.net https://fast.wistia.com https://connect.facebook.net https://script.google.com; style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://cdnjs.cloudflare.com https://fonts.googleapis.com; font-src 'self' https://cdnjs.cloudflare.com https://fonts.gstatic.com; img-src 'self' data: https:; frame-src 'self' https://fast.wistia.net https://fast.wistia.com; connect-src 'self' https://connect.facebook.net https://script.google.com; object-src 'none'; base-uri 'self'; form-action 'self' https://script.google.com;" always;
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
add_header Cross-Origin-Opener-Policy "same-origin" always;
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-Content-Type-Options "nosniff" always;
add_header Referrer-Policy "strict-origin-when-cross-origin" always;

# Cache control
location ~* \.(css|js|jpg|jpeg|png|gif|ico|svg|webp)$ {
    expires 1y;
    add_header Cache-Control "public, immutable";
}

location ~* \.(html)$ {
    expires 1h;
    add_header Cache-Control "public, must-revalidate";
}
```

## Testing

After implementing these headers, test using:
- [SecurityHeaders.com](https://securityheaders.com)
- [Mozilla Observatory](https://observatory.mozilla.org)
- Chrome DevTools Network tab (check Response Headers)
- Lighthouse audit

## Notes

- **HSTS**: Only enable if your site is fully HTTPS. Start with a short max-age.
- **CSP**: Test thoroughly as strict CSP can break functionality. Consider using report-only mode first.
- **COOP**: May affect cross-origin communication. Test if you use popups or iframes from other domains.
- **Cache Control**: Adjust max-age values based on your update frequency.

