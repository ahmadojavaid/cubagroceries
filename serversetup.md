# Cuba Groceries — Server Setup & Deployment

> **Last Updated**: March 2026

---

## Server Details

| Detail | Value |
|--------|-------|
| **Provider** | FastPanel |
| **Server IP** | 46.202.132.220 |
| **OS** | Ubuntu (managed by FastPanel) |
| **SSH User** | zbyte_user |
| **Domain** | cubagroceries.zegobyte.com |
| **DNS** | Cloudflare (grey cloud / DNS only) |
| **SSL** | Let's Encrypt via FastPanel |

---

## Services Running

| Service | Version | Status |
|---------|---------|--------|
| nginx | — | Enabled |
| apache2 | — | Enabled |
| php8.4-fpm | 8.4 | Enabled |
| postgresql-17 | 17 | Enabled |
| mysql | — | Enabled (not used) |

---

## FastPanel Site Configuration

| Setting | Value |
|---------|-------|
| **Site user** | zbyte_user |
| **Root directory** | `/var/www/zbyte_user/data/www/cubagroceries.zegobyte.com` |
| **Backend type** | PHP |
| **Handler** | PHP-FPM |
| **PHP version** | PHP 8.4 |
| **Workers count** | 2 |
| **Working subdirectory** | `backend/public` |
| **Application file** | index.php index.html |

---

## Database

| Setting | Value |
|---------|-------|
| **Engine** | PostgreSQL 17 (localhost) |
| **Database name** | cubagrocerie |
| **Username** | cubagrocerie |
| **Password** | (stored in backend/.env on server) |

---

## Directory Structure on Server

```
/var/www/zbyte_user/data/www/cubagroceries.zegobyte.com/
├── backend/              ← Laravel app
│   ├── public/           ← Web root (nginx points here via working subdirectory)
│   │   ├── storage/      ← Symlink → storage/app/public
│   │   └── index.php     ← Laravel entry point
│   ├── storage/
│   ├── .env              ← Production environment config
│   └── ...
├── mobile/               ← Flutter source (not served)
├── .git/
└── README.md
```

---

## URLs

| Service | URL |
|---------|-----|
| **Website / API** | https://cubagroceries.zegobyte.com |
| **Admin Panel** | https://cubagroceries.zegobyte.com/admin |
| **API Base** | https://cubagroceries.zegobyte.com/api/v1 |

---

## GitHub Repository

| Setting | Value |
|---------|-------|
| **Repo** | github.com/ahmadojavaid/cubagroceries (private) |
| **Branch** | main |
| **Auth** | Fine-grained personal access token (repo: cubagroceries, permission: Contents read-only) |

---

## Initial Deployment Steps (performed March 2026)

```bash
# 1. SSH into server
ssh zbyte_user@46.202.132.220

# 2. Navigate to site root
cd /var/www/zbyte_user/data/www/cubagroceries.zegobyte.com

# 3. Remove default FastPanel file
rm index.php

# 4. Clone repo (use GitHub PAT for auth)
git clone https://ahmadojavaid:TOKEN@github.com/ahmadojavaid/cubagroceries.git .

# 5. Install Laravel dependencies
cd backend
composer install --no-dev --optimize-autoloader

# 6. Create .env and generate app key
cp .env.example .env
php artisan key:generate

# 7. Configure .env (DB, APP_URL, etc.)
# APP_ENV=production, APP_DEBUG=false
# APP_URL=https://cubagroceries.zegobyte.com
# DB_CONNECTION=pgsql, DB_DATABASE=cubagrocerie, DB_USERNAME=cubagrocerie

# 8. Run migrations and seed
php artisan migrate --force
php artisan db:seed --force

# 9. Storage link and cache
php artisan storage:link
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan filament:assets

# 10. In FastPanel: set Working subdirectory to "backend/public"
```

---

## Routine Deployment (after code changes)

**Local (PowerShell):**
```powershell
git push
```

**Server (SSH):**
```bash
cd /var/www/zbyte_user/data/www/cubagroceries.zegobyte.com
git pull
cd backend
composer install --no-dev --optimize-autoloader
php artisan migrate --force
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan filament:assets
```

---

## Mobile App Config

The Flutter app uses `lib/core/config/app_config.dart` to switch between environments:

```dart
class AppConfig {
  static const bool isProduction = false; // Toggle for builds

  static const String _prodBaseUrl = 'https://cubagroceries.zegobyte.com/api/v1';
  static const String _devBaseUrl  = 'https://10.0.2.2/api/v1';
}
```

- **Dev** (`isProduction = false`): Connects to local Herd via emulator proxy, trusts self-signed SSL, sends Host header
- **Prod** (`isProduction = true`): Connects to production server directly, standard SSL

---

## Notes

- FastPanel manages nginx config — do not edit nginx files directly, use the panel
- The `.env` file is NOT in git (production secrets stay on server only)
- `composer.lock` IS in git to ensure consistent dependency versions
- Filament requires `PortalUser` to implement `FilamentUser` interface with `canAccessPanel()` returning true
- Survey seeder uses multi-question schema (SurveySeeder, not SampleDataSeeder's old format)
