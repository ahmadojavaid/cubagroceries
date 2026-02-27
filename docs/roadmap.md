# Cuba Groceries — Roadmap

> **Last Updated**: February 2026
> Each phase delivers a testable vertical slice across backend and mobile.

---

## Phase 1 — Foundation & Auth

**Goal**: Project scaffold, database, admin login, customer API auth, Flutter app shell.

### Backend (Laravel + Filament)
- [ ] Run scaffolder (Laravel + Flutter + PostgreSQL + Herd)
- [ ] Install and configure Filament 3 with full-width layout
- [ ] Create all database migrations from `db-schema-reference.md`
- [ ] Seed initial data (admin user, sample units)
- [ ] Configure `portal_users` auth with Filament
- [ ] Set up Sanctum for API token auth
- [ ] Build API: `POST /auth/register`, `POST /auth/login`, `POST /auth/logout`, `GET /auth/user`
- [ ] Configure Filament Panel Provider (full-width, branding, navigation)

### Mobile (Flutter)
- [ ] Analyze ProKit and map screens (create `flutter-prokit-mapping.md`)
- [ ] Extract ProKit theme, common widgets, and auth screens
- [ ] Set up project structure (feature-first with Riverpod)
- [ ] Configure Dio API service with Sanctum token interceptor
- [ ] Build: Splash → Onboarding → Login → Register screens
- [ ] Token persistence with flutter_secure_storage
- [ ] Basic navigation shell (bottom nav placeholder)

**Milestone**: Admin can log into Filament. Customer can register/login via app. Token auth works end-to-end.

---

## Phase 2 — Catalog (Categories, Units, Products)

**Goal**: Full product catalog management in admin. Browsable catalog in app.

### Backend
- [ ] Filament Resource: Units (CRUD)
- [ ] Filament Resource: Categories (CRUD with parent/child, image upload)
- [ ] Filament Resource: Products (CRUD with multi-price management)
- [ ] API: `GET /categories` (with nested children)
- [ ] API: `GET /categories/{id}/products` (paginated)
- [ ] API: `GET /products` (paginated, filterable by category)
- [ ] API: `GET /products/{id}` (detail with prices/units, eager loaded)
- [ ] API: `GET /products/search?q=` (search)

### Mobile
- [ ] Extract ProKit: Home screen, category grid, product list, product detail
- [ ] Home screen with category carousel/grid
- [ ] Category → sub-category → products navigation
- [ ] Product listing with pagination and pull-to-refresh
- [ ] Product detail screen (multiple price variants)
- [ ] Search functionality
- [ ] Image caching with cached_network_image
- [ ] Shimmer loading states

**Milestone**: Admin can manage full catalog. Customer can browse categories and products in app.

---

## Phase 3 — Customer Profile & Addresses

**Goal**: Customer management in admin. Profile and address management in app.

### Backend
- [ ] Filament Resource: Customers (listing, view, wallet display)
- [ ] API: `GET/PUT /profile`
- [ ] API: `PUT /profile/password`
- [ ] API: CRUD `/addresses`
- [ ] API: `PUT /addresses/{id}/default`
- [ ] API: `GET /wallet`

### Mobile
- [ ] Extract ProKit: Profile screen, address management, settings
- [ ] Profile view/edit screen
- [ ] Address list, add, edit, delete, set default
- [ ] Wallet balance display
- [ ] Settings screen

**Milestone**: Admin can view customers and wallets. Customer can manage profile and addresses.

---

## Phase 4 — Cart, Checkout & Orders

**Goal**: Order placement and management. Full purchase flow in app.

### Backend
- [ ] Filament Resource: Shipping Charges (CRUD)
- [ ] Filament Resource: Orders (listing, detail view, status management)
- [ ] Order ID generation (CUBA prefix + 8 digits)
- [ ] API: `GET /shipping-charges`
- [ ] API: `POST /orders` (validate stock, calculate total, create order + address snapshot + line items)
- [ ] API: `GET /orders` (history, paginated)
- [ ] API: `GET /orders/{order_number}` (detail)
- [ ] Stock deduction on order placement

### Mobile
- [ ] Cart system (local state with Hive persistence)
- [ ] Extract ProKit: Cart screen, checkout flow, order history, order detail
- [ ] Cart screen (quantities, unit selection, subtotals)
- [ ] Checkout flow: address selection → shipping → review → confirm
- [ ] Order placement with loading/success/error states
- [ ] Order history screen
- [ ] Order detail/tracking screen

**Milestone**: Full purchase flow works end-to-end. Admin can view and manage orders.

---

## Phase 5 — Delivery & Complaints

**Goal**: Delivery assignment, complaint system.

### Backend
- [ ] Filament Resource: Delivery Boys (CRUD, payment tracking)
- [ ] Order status workflow (pending → confirmed → dispatched → delivered → cancelled)
- [ ] Delivery boy assignment to orders
- [ ] Filament Resource: Complaints (listing, status management)
- [ ] API: `POST /complaints`
- [ ] API: `GET /complaints`

### Mobile
- [ ] Order status tracking with visual timeline
- [ ] Complaint submission screen
- [ ] Complaints history

**Milestone**: Orders can be assigned to delivery boys. Customers can file and track complaints.

---

## Phase 6 — Dashboard, Notifications & Polish

**Goal**: Admin dashboard with stats. Push notifications. Production readiness.

### Backend
- [ ] Filament Dashboard widgets:
  - Total Orders, Customers, Categories, Products, Revenue
  - Today's Birthdays
  - Recent Orders
  - Pending / Delivered / Cancelled counts
  - Pending Complaints
- [ ] Notification system (order status changes → push notification)
- [ ] API: `GET /notifications`, `PUT /notifications/{id}/read`, `PUT /notifications/read-all`
- [ ] Firebase Cloud Messaging integration (server-side)
- [ ] Wallet top-up / deduction from admin

### Mobile
- [ ] Firebase FCM setup for push notifications
- [ ] Notification inbox screen
- [ ] Extract ProKit: Notification list screen
- [ ] App polish: error states, empty states, offline handling
- [ ] Android release build (signing, ProGuard)
- [ ] Play Store listing preparation

**Milestone**: System is feature-complete and production-ready for Android launch.

---

## Post-Launch

- [ ] iOS build and App Store submission
- [ ] Delivery boy companion app (separate Flutter module or flavor)
- [ ] Payment gateway integration (JazzCash, Easypaisa)
- [ ] Promotional offers and coupon system
- [ ] Analytics dashboard
- [ ] Customer reviews and ratings
