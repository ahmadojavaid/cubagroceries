# Cuba Groceries — Project Plan

> **Last Updated**: February 2026
> Detailed task breakdown per phase with dependencies and acceptance criteria.

---

## Pre-Development Setup

| # | Task | Tool | Done |
|---|------|------|------|
| 0.1 | Run scaffolder with options: Mobile+Backend, Laravel, Herd, PostgreSQL, With login system | scaffold.ps1 | [ ] |
| 0.2 | Verify `H:\cubagroceries\backend` and `H:\cubagroceries\mobile` created | — | [ ] |
| 0.3 | Verify `https://cubagroceries.test` serves Laravel welcome page | Browser | [ ] |
| 0.4 | Verify PostgreSQL database `cubagroceries` exists | PgAdmin 4 | [ ] |
| 0.5 | Add cubagroceries paths to Claude Desktop MCP config | Config edit | [ ] |
| 0.6 | Copy documentation files to `H:\cubagroceries\docs\` | — | [ ] |
| 0.7 | Analyze ProKit folder structure and create screen mapping | Claude | [ ] |
| 0.8 | Initial git commit with scaffolded project + docs | Git | [ ] |

---

## Phase 1 — Foundation & Auth

### Backend Tasks

| # | Task | Depends On | Acceptance Criteria |
|---|------|-----------|-------------------|
| 1.1 | Install Filament 3: `composer require filament/filament` and publish | 0.1 | Filament installed |
| 1.2 | Configure FilamentPanelProvider: full-width layout, `/admin` path, branding | 1.1 | Admin panel loads at `/admin` with full viewport width |
| 1.3 | Create all migrations per `db-schema-reference.md` | 0.1 | All 14 tables exist in PostgreSQL |
| 1.4 | Create all Eloquent models with relationships | 1.3 | Models match schema doc, relationships tested |
| 1.5 | Create DatabaseSeeder: admin user (role 1), sample units (kg, piece, dozen) | 1.4 | `php artisan db:seed` creates data |
| 1.6 | Configure Filament auth to use `portal_users` table | 1.2, 1.4 | Admin can log in at `/admin/login` |
| 1.7 | Install Sanctum, configure for `users` table | 1.4 | API token generation works |
| 1.8 | Create `Api\V1\AuthController` (register, login, logout, user) | 1.7 | All 4 endpoints return correct responses |
| 1.9 | Create API routes under `api/v1/auth/*` | 1.8 | Routes registered, tested with Postman |
| 1.10 | Add rate limiting to auth routes (5/min) | 1.9 | Rate limit enforced |

### Mobile Tasks

| # | Task | Depends On | Acceptance Criteria |
|---|------|-----------|-------------------|
| 1.11 | Audit ProKit screens, create `flutter-prokit-mapping.md` | 0.7 | Mapping document complete |
| 1.12 | Extract ProKit theme (colors, typography, spacing) into `core/theme/` | 1.11 | Theme applied to app |
| 1.13 | Extract ProKit common widgets into `core/widgets/` | 1.11 | Reusable widgets available |
| 1.14 | Set up feature-first folder structure | 0.2 | All feature folders created |
| 1.15 | Install and configure Riverpod | 1.14 | Provider scope wraps app |
| 1.16 | Configure Dio with base URL, token interceptor, error handling | 1.14 | API calls work to backend |
| 1.17 | Extract and build Splash screen | 1.12 | Splash shows branding, navigates to onboarding/home |
| 1.18 | Extract and build Onboarding screens | 1.12 | 2-3 slides, skip to login |
| 1.19 | Extract and build Login screen wired to API | 1.16, 1.12 | Login works, token stored |
| 1.20 | Extract and build Register screen wired to API | 1.16, 1.12 | Registration works, token stored |
| 1.21 | Build auth state provider (Riverpod) | 1.15, 1.19 | Auth state persists across app restart |
| 1.22 | Build navigation shell (bottom nav: Home, Categories, Cart, Orders, Profile) | 1.14 | Shell renders with placeholder screens |

---

## Phase 2 — Catalog

### Backend Tasks

| # | Task | Depends On | Acceptance Criteria |
|---|------|-----------|-------------------|
| 2.1 | Filament Resource: UnitResource (CRUD) | 1.6 | Units manageable in admin |
| 2.2 | Filament Resource: CategoryResource (CRUD, image upload, parent/child) | 1.6 | Categories with hierarchy manageable |
| 2.3 | Filament Resource: ProductResource (CRUD, category select, stock) | 2.1, 2.2 | Products manageable with category assignment |
| 2.4 | Product form: dynamic price rows (add/remove price-unit combinations) | 2.3 | Multiple prices per product saved correctly |
| 2.5 | API: `CategoriesController@index` — top-level with nested children | 1.9 | Returns hierarchy with images |
| 2.6 | API: `CategoriesController@products` — paginated products by category | 2.5 | Pagination works, filterable |
| 2.7 | API: `ProductsController@index` — paginated, filterable | 1.9 | Filter by category/sub-category works |
| 2.8 | API: `ProductsController@show` — detail with prices eager loaded | 2.7 | No N+1, all prices/units included |
| 2.9 | API: `ProductsController@search` — search by name | 2.7 | Search returns relevant results |

### Mobile Tasks

| # | Task | Depends On | Acceptance Criteria |
|---|------|-----------|-------------------|
| 2.10 | Create category provider (Riverpod) | 2.5 | Categories fetched and cached |
| 2.11 | Create product provider (Riverpod) with pagination | 2.7 | Products load page by page |
| 2.12 | Extract and build Home screen (category grid, featured products) | 1.22, 2.10 | Home shows live categories |
| 2.13 | Extract and build Category listing screen | 2.10 | Shows categories with sub-categories |
| 2.14 | Extract and build Product listing screen (pagination, pull-to-refresh) | 2.11 | Infinite scroll works |
| 2.15 | Extract and build Product detail screen (multi-price display) | 2.11 | Shows all price variants with unit selection |
| 2.16 | Build search screen with debounced search | 2.9 | Search works with loading states |
| 2.17 | Add shimmer loading states to all list screens | 2.14 | Shimmer shows while loading |
| 2.18 | Add image caching (cached_network_image) | 2.12 | Images cache on device |

---

## Phase 3 — Customer Profile & Addresses

### Backend Tasks

| # | Task | Depends On | Acceptance Criteria |
|---|------|-----------|-------------------|
| 3.1 | Filament Resource: CustomerResource (list, view, wallet display) | 1.6 | Customers visible in admin with wallet |
| 3.2 | API: `ProfileController@show`, `update` | 1.9 | Profile read/update works |
| 3.3 | API: `ProfileController@password` | 1.9 | Password change works |
| 3.4 | API: `AddressController` (full CRUD + set default) | 1.9 | All address operations work |
| 3.5 | API: `WalletController@balance` | 1.9 | Returns wallet_amount |

### Mobile Tasks

| # | Task | Depends On | Acceptance Criteria |
|---|------|-----------|-------------------|
| 3.6 | Extract and build Profile screen (view/edit) | 3.2 | Profile editable, changes persist |
| 3.7 | Extract and build Address list screen | 3.4 | Shows saved addresses |
| 3.8 | Build Address add/edit form | 3.4 | Addresses saveable |
| 3.9 | Build Wallet balance display | 3.5 | Balance shown in profile |
| 3.10 | Build Settings screen (change password, logout) | 3.3 | Password change and logout work |

---

## Phase 4 — Cart, Checkout & Orders

### Backend Tasks

| # | Task | Depends On | Acceptance Criteria |
|---|------|-----------|-------------------|
| 4.1 | Filament Resource: ShippingChargeResource (CRUD) | 1.6 | Shipping charges manageable |
| 4.2 | Build order ID generator (CUBA + 8 random digits, unique) | 1.4 | Generates unique IDs |
| 4.3 | API: `OrderController@store` (validate, calculate, create order + address + items) | 4.2 | Order created with all related records |
| 4.4 | Stock deduction logic on order placement | 4.3 | Stock decreases, out-of-stock rejected |
| 4.5 | API: `OrderController@index` (history, paginated) | 1.9 | Returns user's orders |
| 4.6 | API: `OrderController@show` (by order_number) | 1.9 | Returns full order detail |
| 4.7 | API: `ShippingController@index` | 1.9 | Returns shipping options |
| 4.8 | Filament Resource: OrderResource (list, detail, status change) | 1.6 | Orders viewable and status changeable in admin |

### Mobile Tasks

| # | Task | Depends On | Acceptance Criteria |
|---|------|-----------|-------------------|
| 4.9 | Build Cart provider (Riverpod + Hive persistence) | 1.15 | Cart persists across app restarts |
| 4.10 | Extract and build Cart screen (quantities, unit, subtotals) | 4.9 | Cart functional with +/- buttons |
| 4.11 | Build Checkout flow: address → shipping → review → confirm | 4.3, 3.7, 4.7 | Multi-step checkout works |
| 4.12 | Order placement with loading/success/error states | 4.3 | Order placed, cart cleared on success |
| 4.13 | Extract and build Order history screen | 4.5 | Shows all past orders |
| 4.14 | Extract and build Order detail screen | 4.6 | Shows full order with items and status |

---

## Phase 5 — Delivery & Complaints

### Backend Tasks

| # | Task | Depends On | Acceptance Criteria |
|---|------|-----------|-------------------|
| 5.1 | Filament Resource: DeliveryBoyResource (CRUD, payment tracking) | 1.6 | Delivery boys manageable |
| 5.2 | Order status workflow (enum: pending, confirmed, dispatched, delivered, cancelled) | 4.8 | Status transitions enforced |
| 5.3 | Delivery boy assignment on orders | 5.1, 4.8 | Delivery boy assignable to order |
| 5.4 | Filament Resource: ComplaintResource (list, status management) | 1.6 | Complaints manageable |
| 5.5 | API: `ComplaintController@store` | 1.9 | Complaint submission works |
| 5.6 | API: `ComplaintController@index` | 1.9 | Returns user's complaints |

### Mobile Tasks

| # | Task | Depends On | Acceptance Criteria |
|---|------|-----------|-------------------|
| 5.7 | Build order status timeline visualization | 5.2 | Visual timeline shows current status |
| 5.8 | Build complaint submission screen | 5.5 | Complaint filed against order |
| 5.9 | Build complaints history screen | 5.6 | Past complaints visible |

---

## Phase 6 — Dashboard, Notifications & Polish

### Backend Tasks

| # | Task | Depends On | Acceptance Criteria |
|---|------|-----------|-------------------|
| 6.1 | Filament Dashboard: stats widgets (orders, customers, categories, products, revenue) | All resources | Dashboard shows accurate counts |
| 6.2 | Dashboard: Today's Birthdays widget | 3.1 | Shows customers with today's DOB |
| 6.3 | Dashboard: Recent Orders widget | 4.8 | Shows latest orders |
| 6.4 | Dashboard: Pending Complaints widget | 5.4 | Shows unresolved complaints |
| 6.5 | Notification system: trigger on order status change | 5.2 | Notifications created in DB |
| 6.6 | Firebase Cloud Messaging server integration | 6.5 | Push notifications sent |
| 6.7 | API: NotificationController (list, mark read, mark all read) | 6.5 | Notification endpoints work |
| 6.8 | Wallet management from admin (top-up/deduct) | 3.1 | Admin can modify wallet |

### Mobile Tasks

| # | Task | Depends On | Acceptance Criteria |
|---|------|-----------|-------------------|
| 6.9 | Firebase FCM setup in Flutter | 6.6 | Push notifications received on device |
| 6.10 | Extract and build Notification inbox screen | 6.7 | Notifications listable, markable |
| 6.11 | App polish: error states, empty states, offline handling | All | No unhandled errors |
| 6.12 | Android release build (signing, ProGuard, app icon, splash) | All | Signed APK/AAB generated |
| 6.13 | Play Store listing prep (screenshots, description) | 6.12 | Ready for submission |
