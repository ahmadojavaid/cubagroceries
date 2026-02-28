# Cuba Groceries — Progress v0.0.1

> **Phase 1: Foundation & Auth**
> **Started**: February 2026
> **Status**: IN PROGRESS

---

## Pre-Flight Checklist

| # | Task | Status |
|---|------|--------|
| PF-1 | Verify scaffolder completed (backend + mobile folders exist) | ✅ |
| PF-2 | Verify `https://cubagroceries.test` serves Laravel welcome | ✅ |
| PF-3 | Verify PostgreSQL database `cubagroceries` exists in PgAdmin | ✅ |
| PF-4 | Copy docs to `H:\cubagroceries\docs\` | ✅ |
| PF-5 | Update Claude Desktop MCP config (filesystem + postgres) | ✅ |
| PF-6 | Initial git commit | ✅ |

---

## Backend Micro-Phases

### MP-B1: Install & Configure Filament ✅
- ✅ Install Filament 3 via composer
- ✅ Create FilamentPanelProvider with full-width layout, `/admin` path
- ✅ Configure branding (app name: Cuba Groceries)
- ✅ Full-width layout via `maxContentWidth(MaxWidth::Full)`
- ✅ Green primary color, removed FilamentInfoWidget
- **Verify**: `https://cubagroceries.test/admin` loads

### MP-B2: Migrations — Auth Domain ✅
- ✅ Create `portal_users` migration (id, name, email, password, role, remember_token, timestamps)
- ✅ Modify default `users` migration to match schema (identity, email, firstname, lastname, password, date_of_birth, wallet_amount, timestamps)
- ✅ Kept password_reset_tokens, sessions, personal_access_tokens (needed by Sanctum)
- **Terminal**: `php artisan migrate:fresh`

### MP-B3: Migrations — Catalog Domain
- Create `category` migration (id, title, image, parent_id self-ref FK, timestamps)
- Create `unit` migration (id, name, abbreviation, timestamps)
- Create `product` migration (id, name, description, category_id FK, sub_category_id FK, stock, timestamps)
- Create `price` migration (id, product_id FK, unit_id FK, price decimal, timestamps)
- **Terminal**: `php artisan migrate:fresh`

### MP-B4: Migrations — Orders Domain
- Create `orderdetails` migration (id, order_id string unique, user_id FK, status, total_amount, timestamps)
- Create `orderaddress` migration (id, order_id FK, address, city, phone, latitude, longitude, timestamps)
- Create `orderproduct` migration (id, order_id FK, product_id FK, unit_id FK, quantity, price, timestamps)
- **Terminal**: `php artisan migrate:fresh`

### MP-B5: Migrations — Operations & System Domain
- Create `shippingcharge` migration (id, title, amount, timestamps)
- Create `deliveryboy` migration (id, name, phone, payment, timestamps)
- Create `complaint` migration (id, user_id FK, order_id FK nullable, subject, message, status, timestamps)
- Create `addresses` migration (id, user_id FK, label, address, city, phone, latitude, longitude, is_default, timestamps)
- Verify `notifications` table migration exists (Laravel default)
- **Terminal**: `php artisan migrate:fresh`

### MP-B6: Eloquent Models
- Create `PortalUser` model with role constants, guard config
- Modify `User` model (fillable, hidden, casts, HasApiTokens)
- Create `Category` model (parent/children self-ref, products relationship)
- Create `Unit` model
- Create `Product` model (category, subCategory, prices, unit relationships)
- Create `Price` model (product, unit relationships)
- Create `Order` model (user, address, products relationships)
- Create `OrderAddress` model
- Create `Orderproduct` model
- Create `ShippingCharge` model
- Create `DeliveryBoy` model
- Create `Complaint` model
- Create `Address` model

### MP-B7: Database Seeder
- Create `AdminSeeder` — super admin user (role 1) for Filament login
- Create `UnitSeeder` — sample units (kg, piece, dozen, pack, litre)
- Register seeders in `DatabaseSeeder`
- **Terminal**: `php artisan db:seed`

### MP-B8: Filament Auth (Portal Users)
- Configure Filament to authenticate against `portal_users` table
- Create custom `PortalUser` auth guard in `auth.php`
- Configure FilamentPanelProvider to use portal guard
- **Verify**: Admin can log in at `https://cubagroceries.test/admin/login`

### MP-B9: Sanctum API Auth
- Verify Sanctum is installed (scaffolder should have done this)
- Configure Sanctum for `users` table
- Create `Api\V1\AuthController` (register, login, logout, user) matching our schema fields
- Create API routes under `api/v1/auth/*`
- Add rate limiting (5/min on auth routes)
- **Verify**: Test all 4 endpoints with Postman

### MP-B10: API Response Helpers
- Create `ApiResponse` trait or helper class
- Standardize success/error/paginated response format per `api-architecture.md`
- Apply to AuthController

---

## Mobile Micro-Phases

### MP-M1: ProKit Analysis & Screen Mapping
- Audit `prokit-flutter/lib/fullApps/grocery/` screens
- Audit `prokit-flutter/lib/fullApps/shopHop/` for supplementary screens
- Read key screen files to understand structure and dependencies
- Complete `flutter-prokit-mapping.md` with file paths

### MP-M2: Project Structure Setup
- Create feature-first folder structure under `mobile/lib/`
- Folders: `core/api`, `core/theme`, `core/widgets`, `core/router`
- Feature folders: `features/auth`, `features/home`, `features/products`, `features/cart`, `features/orders`, `features/profile`, `features/notifications`
- Each feature: `data/`, `providers/`, `screens/`, `widgets/`

### MP-M3: Core Dependencies
- Add to pubspec.yaml: `flutter_riverpod`, `hive`, `hive_flutter`, `cached_network_image`, `shimmer`, `intl`
- Verify `dio`, `go_router`, `flutter_secure_storage` already added by scaffolder
- **Terminal**: `flutter pub get`

### MP-M4: Theme Extraction from ProKit
- Extract `GroceryColors.dart` → adapt to `core/theme/app_colors.dart`
- Extract typography/text styles → `core/theme/app_text_styles.dart`
- Create `core/theme/app_theme.dart` (ThemeData)
- Apply theme in `main.dart`

### MP-M5: Dio API Client Setup
- Create `core/api/api_client.dart` (Dio instance, base URL, interceptors)
- Create `core/api/api_response.dart` (typed response wrapper)
- Token interceptor reading from flutter_secure_storage
- Error handling interceptor

### MP-M6: Riverpod Foundation
- Wrap app in `ProviderScope`
- Create `core/providers/api_provider.dart` (Dio instance provider)
- Create `features/auth/providers/auth_provider.dart` (auth state)

### MP-M7: Router Setup
- Create `core/router/app_router.dart` with go_router
- Define initial routes: splash, onboarding, login, register, home shell
- Auth redirect logic (logged in → home, not logged in → login)

### MP-M8: Splash Screen
- Extract and adapt `GrocerySplash.dart`
- Wire navigation: check auth state → onboarding (first launch) or home (logged in) or login

### MP-M9: Onboarding Screen
- Extract walkthrough from `shopHop/ShWalkThroughScreen.dart` or build custom
- 2-3 slides introducing the app
- Skip/Done → navigate to login
- Store "onboarding seen" flag in shared prefs

### MP-M10: Login Screen
- Extract and adapt `GrocerySignUp.dart` or build login screen using ProKit widgets
- Wire to `POST /api/v1/auth/login`
- Store token on success, navigate to home
- Error handling and loading states

### MP-M11: Register Screen
- Build register screen matching our API fields (identity, email, firstname, lastname, password, DOB)
- Wire to `POST /api/v1/auth/register`
- Store token on success, navigate to home
- Error handling and loading states

### MP-M12: Navigation Shell
- Build bottom navigation bar (Home, Categories, Cart, Orders, Profile)
- Each tab shows placeholder screen
- Extract nav bar style from ProKit grocery dashboard

---

## Status Summary

| Area | Total | Done | Remaining |
|------|-------|------|-----------|
| Pre-Flight | 6 | 0 | 6 |
| Backend | 10 | 2 | 8 |
| Mobile | 12 | 0 | 12 |
| **Total** | **28** | **2** | **26** |
