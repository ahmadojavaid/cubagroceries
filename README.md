# Cuba Groceries

A comprehensive grocery delivery platform for the Pakistani market featuring a Laravel backend with Filament admin panel and a Flutter Android customer + rider app.

## Tech Stack

- **Backend**: Laravel 11, Filament 3, PostgreSQL, Sanctum API auth
- **Mobile**: Flutter 3, Riverpod, Dio, Hive, Go Router
- **Server**: PHP 8.4, Nginx, PostgreSQL 17

## Project Structure

```
├── backend/    ← Laravel (Filament admin + REST API)
├── mobile/     ← Flutter (Customer & Rider Android app)
└── README.md
```

## Backend

- **Local**: `https://cubagroceries.test` (via Laravel Herd)
- **Production**: `https://cubagroceries.zegobyte.com`
- **Admin Panel**: `/admin`
- **API Base**: `/api/v1`

## Mobile

```bash
cd mobile && flutter run
```

## Deployment

```bash
cd /var/www/zbyte_user/data/www/cubagroceries.zegobyte.com
git pull origin main
cd backend
composer install --no-dev --optimize-autoloader
php artisan migrate --force
php artisan config:cache
php artisan route:cache
php artisan view:cache
```
