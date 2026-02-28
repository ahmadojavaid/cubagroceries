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

> **Pre-Flight: COMPLETE** ✅

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

### MP-B3: Migrations — Catalog Domain ✅
- ✅ Create `category` migration (id, title, image, parent_id self-ref FK, timestamps)
- ✅ Create `unit` migration (id, name, abbreviation, timestamps)
- ✅ Create `product` migration (id, name, description, category_id FK, sub_category_id FK, stock, timestamps)
- ✅ Create `price` migration (id, product_id FK, unit_id FK, price decimal, timestamps)
- **Terminal**: `php artisan migrate:fresh` (run after MP-B5)

### MP-B4: Migrations — Orders Domain ✅
- ✅ Create `orderdetails` migration (id, order_id string unique, user_id FK, status, total_amount, timestamps)
- ✅ Create `orderaddress` migration (id, order_id FK → orderdetails, address, city, phone, lat/lng, timestamps)
- ✅ Create `orderproduct` migration (id, order_id FK → orderdetails, product_id FK, unit_id FK, quantity, price, timestamps)
- **Terminal**: `php artisan migrate:fresh` (run after MP-B5)

### MP-B5: Migrations — Operations & System Domain ✅
- ✅ Create `shippingcharge` migration (id, title, amount, timestamps)
- ✅ Create `deliveryboy` migration (id, name, phone, payment, timestamps)
- ✅ Create `complaint` migration (id, user_id FK, order_id FK nullable, subject, message, status, timestamps)
- ✅ Create `addresses` migration (id, user_id FK, label, address, city, phone, lat/lng, is_default, timestamps)
- ✅ Create `notifications` migration (uuid PK, polymorphic notifiable, json data, read_at)
- **Terminal**: `php artisan migrate:fresh` ← **RUN NOW**

### MP-B6: Eloquent Models ✅
- ✅ Create `PortalUser` model with role constants (SUPER_ADMIN=1, ADMIN=2, STAFF=3), helpers
- ✅ Modify `User` model (HasApiTokens, fillable matches schema, relationships, fullName accessor)
- ✅ Create `Category` model (parent/children self-ref, products, topLevel scope)
- ✅ Create `Unit` model
- ✅ Create `Product` model (category, subCategory, prices relationships, inStock scope)
- ✅ Create `Price` model (product, unit relationships)
- ✅ Create `Order` model (table: orderdetails, user, address, products relationships)
- ✅ Create `OrderAddress` model
- ✅ Create `Orderproduct` model
- ✅ Create `ShippingCharge` model
- ✅ Create `DeliveryBoy` model
- ✅ Create `Complaint` model
- ✅ Create `Address` model

### MP-B7: Database Seeder ✅
- ✅ Create `AdminSeeder` — super admin (admin@cubagroceries.test / password)
- ✅ Create `UnitSeeder` — 6 units (kg, g, piece, dozen, pack, litre)
- ✅ Register seeders in `DatabaseSeeder`
- **Terminal**: `php artisan migrate:fresh --seed` ← **RUN NOW**

### MP-B8: Filament Auth (Portal Users) ✅
- ✅ Add `portal` guard + `portal_users` provider in `config/auth.php`
- ✅ Configure FilamentPanelProvider with `->authGuard('portal')`
- **Verify**: Log in at `https://cubagroceries.test/admin/login` with `admin@cubagroceries.test` / `password`

### MP-B9: Sanctum API Auth ✅
- ✅ Sanctum already installed by scaffolder
- ✅ Create `Api\V1\AuthController` (register, login, logout, user) with schema fields
- ✅ Routes under `api/v1/auth/*` with proper grouping
- ✅ Rate limiting 5/min on public auth routes (register, login)
- ✅ Deleted old scaffolded Auth\AuthController
- ✅ API exception handling (ValidationException → 422, NotFound → 404)
- **Verify**: Test with Postman: POST `/api/v1/auth/register`, POST `/api/v1/auth/login`, etc.

### MP-B10: API Response Helpers ✅
- ✅ Create `App\Traits\ApiResponse` trait (success, paginated, error methods)
- ✅ Response format matches `api-architecture.md` spec
- ✅ Applied to AuthController

---

## Mobile Micro-Phases

### MP-M1: ProKit Analysis & Screen Mapping ✅
- ✅ Audit `grocery/` — 34 screens, using ~20 (splash, auth, home, catalog, checkout, profile, etc.)
- ✅ Audit `shopHop/` — supplementary: onboarding, cart, address mgmt, order list/detail, settings
- ✅ Audit `food/` — fallback for walkthrough and address forms
- ✅ Complete `flutter-prokit-mapping.md` with all file paths and phase assignments
- ✅ Identified key dependencies: nb_utils, appStore, AppWidget

### MP-M2: Project Structure Setup ✅
- ✅ Scaffolder created feature-first structure (core/api, core/theme, core/widgets, core/router, core/constants)
- ✅ Scaffolder created 7 feature folders (auth, home, products, cart, orders, profile, notifications) each with data/providers/screens/widgets
- ✅ Added missing `features/categories` folder with data/providers/screens/widgets subfolders
- ✅ All 8 feature folders ready

### MP-M3: Core Dependencies ✅
- ✅ Verified scaffolder added: `dio`, `go_router`, `flutter_secure_storage`
- ✅ Added: `flutter_riverpod`, `hive`, `hive_flutter`, `cached_network_image`, `shimmer`, `pull_to_refresh`, `intl`
- ✅ Dropped `hive_generator`/`build_runner` (Dart SDK conflict; will use Hive with JSON serialization instead)
- **Terminal**: `cd mobile && flutter pub get`

### MP-M4: Theme Extraction from ProKit ✅
- ✅ Create `app_colors.dart` — full palette (primary green, accent orange, status colors, order status)
- ✅ Create `app_text_styles.dart` — headings, body, labels, button, price styles
- ✅ Create `app_dimens.dart` — spacing, border radius, icon/card sizes
- ✅ Create `app_theme.dart` — Material 3 ThemeData (appBar, cards, buttons, inputs, bottomNav, chips)
- ✅ Apply theme in `main.dart`, rename app to CubaGroceriesApp

### MP-M5: Dio API Client Setup ✅
- ✅ Create `api_client.dart` — Dio with base URL, timeouts, auth interceptor, error interceptor
- ✅ Create `api_response.dart` — typed wrapper with PaginationMeta, firstError helper
- ✅ Create `api_exception.dart` — typed exceptions (isValidation, isUnauthorized, etc.)
- ✅ Token management (save, clear, get, hasToken) via flutter_secure_storage
- ✅ Deleted old scaffolded `services/api_service.dart`

### MP-M6: Riverpod Foundation ✅
- ✅ Wrap app in `ProviderScope` in main.dart
- ✅ Create `core/providers/api_provider.dart` (singleton ApiClient provider)
- ✅ Create `features/auth/providers/auth_provider.dart` (AuthState + AuthNotifier)
- ✅ AuthNotifier: checkAuth, register, login, logout, clearError methods

### MP-M7: Router Setup ✅
- ✅ Create `core/router/app_router.dart` with go_router
- ✅ Routes: /splash, /onboarding, /login, /register, /home
- ✅ Auth redirect (authenticated → /home, unauthenticated → /login)
- ✅ Wire router into main.dart via MaterialApp.router

### MP-M8: Splash Screen ✅
- ✅ Build SplashScreen with green background, icon, branding, loading spinner
- ✅ Calls authProvider.checkAuth() then navigates to /home or /login

### MP-M9: Onboarding Screen ✅
- ✅ 3-slide PageView (Fresh Groceries, Fast Delivery, Easy Payment)
- ✅ Animated dot indicator, Skip button, Next/Get Started button
- ✅ Navigates to /login on completion

### MP-M10: Login Screen ✅
- ✅ Form with email + password, validation, show/hide password toggle
- ✅ Wired to authProvider.login() → POST /api/v1/auth/login
- ✅ Error display, loading state, navigates to /home on success
- ✅ Link to Register screen

### MP-M11: Register Screen ✅
- ✅ Form: phone, first/last name (side by side), email, password, confirm password
- ✅ Wired to authProvider.register() → POST /api/v1/auth/register
- ✅ Error display, loading state, navigates to /home on success
- ✅ Link back to Login screen

### MP-M12: Navigation Shell ✅
- ✅ Bottom nav: Home, Categories, Cart, Orders, Profile
- ✅ IndexedStack for tab persistence
- ✅ Placeholder tabs with icon + "Coming soon" text

---

## Status Summary

| Area | Total | Done | Remaining |
|------|-------|------|-----------|
| Pre-Flight | 6 | 6 | 0 |
| Backend | 10 | 10 | 0 |
| Mobile | 12 | 12 | 0 |
| **Total** | **28** | **28** | **0** |

> **🎉 PHASE 1 COMPLETE — Foundation & Auth delivered**
