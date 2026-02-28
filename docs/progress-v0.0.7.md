# Cuba Groceries — Phase 7 Progress: Rider Flow

> **Version**: 0.0.7
> **Phase**: 7 — Rider Flow (Same App, Role-Based)
> **Goal**: Delivery boys can log in to the same app, see assigned orders with delivery details, open Google Maps for navigation, and contact customers via WhatsApp.
> **Last Updated**: March 2026

---

## Architecture Decisions

- **Same app, role-based routing**: After login, user role determines which shell loads (customer vs rider)
- **No separate rider registration**: Riders are created in Filament admin, linked to a `users` record
- **Minimal scope**: Order list → Order detail → Google Maps / WhatsApp. No earnings, no status updates from app (for now)
- **DeliveryBoy model gains a `user_id` FK**: Links to `users` table for Sanctum auth
- **Geocoding**: Addresses already have lat/lng columns in `orderaddress`. If null, admin should fill them. No auto-geocoding for now.

---

## Backend Micro-Phases

### MP-B1: Link DeliveryBoy to User for auth ✅
- [x] Create migration: add `user_id` (nullable FK → users.id, unique) to `deliveryboy` table
- [x] Add `role` column to `users` table (enum: `customer`, `rider`, default `customer`)
- [x] Update `User` model: add `role` to fillable/casts, add `deliveryBoy()` hasOne relationship
- [x] Update `DeliveryBoy` model: add `user_id` to fillable, add `user()` belongsTo relationship
- [x] Run migration
- **Commit**: `feat(backend): link delivery boy to user account with role column`

### MP-B2: Update Filament DeliveryBoyResource — user account creation ✅
- [x] Add `user_id` field to DeliveryBoyResource form (Select, searchable, optional)
- [x] OR: Add action "Create Login" on DeliveryBoyResource that auto-creates a `users` record with role=rider, using delivery boy's name/phone as defaults, prompting for email+password
- [x] Show linked user email in table column
- [x] Ensure login response includes `role` field in user data
- **Commit**: `feat(backend): delivery boy user account management in Filament`

### MP-B3: Rider API endpoints ✅
- [x] Create `Api\V1\RiderController`
- [x] `GET /api/v1/rider/orders` — orders assigned to authenticated rider's delivery_boy record, eager load: address, products.product, products.unit, user (for phone/name)
- [x] `GET /api/v1/rider/orders/{order_number}` — single order detail (same eager loads)
- [x] Register routes under Sanctum middleware + custom `rider` middleware that checks role
- [x] Create `EnsureUserIsRider` middleware
- **Commit**: `feat(backend): rider API endpoints for assigned orders`

### MP-B4: Include role in auth responses ✅
- [x] Update `AuthController@login` response to include `role` field in user data
- [x] Update `AuthController@register` — always sets role=customer
- [x] Update `AuthController@user` response to include `role`
- **Commit**: `feat(backend): include user role in auth API responses`

---

## Mobile Micro-Phases

### MP-M1: Auth state — role awareness ✅
- [x] Update `AuthState` to include `role` field (String: 'customer' | 'rider')
- [x] Parse `role` from login/register/checkAuth API responses
- [x] Export role via `userRoleProvider` (derived Riverpod provider)
- **Commit**: `feat(mobile): role-aware auth state`

### MP-M2: Role-based navigation shell ✅
- [x] Create `RiderNavigationShell` with bottom nav: Orders, Profile
- [x] Update `app_router.dart`: add `/rider-home` route pointing to `RiderNavigationShell`
- [x] Update `SplashScreen` (or post-login routing): if role=rider → `/rider-home`, else → `/home`
- [x] Rider shell reuses existing `ProfileScreen` for the Profile tab
- **Commit**: `feat(mobile): rider navigation shell with role-based routing`

### MP-M3: Rider orders provider ✅
- [x] Create `features/rider/providers/rider_orders_provider.dart`
- [x] `RiderOrdersNotifier` — fetches from `GET /rider/orders`, stores list
- [x] Supports pull-to-refresh
- [x] `riderOrderDetailProvider` — family provider fetching single order by order_number
- **Commit**: `feat(mobile): rider orders provider with Riverpod`

### MP-M4: Rider order list screen ✅
- [x] Create `features/rider/screens/rider_orders_screen.dart`
- [x] Shows assigned orders: order number, customer name, status badge, total, date
- [x] Delivery address preview (first line of address + city)
- [x] Pull-to-refresh
- [x] Empty state: "No orders assigned yet"
- [x] Tap → navigates to rider order detail
- **Commit**: `feat(mobile): rider order list screen`

### MP-M5: Rider order detail screen ✅
- [x] Create `features/rider/screens/rider_order_detail_screen.dart`
- [x] Order info section: order #, status, total, date
- [x] Delivery address section: full address, city, phone
- [x] Customer info section: name, phone
- [x] Order items list: product name, quantity, unit, price
- [x] Two action buttons at bottom (prominent):
  - **"Open in Maps"** — launches Google Maps with lat/lng from order address
  - **"WhatsApp Customer"** — opens WhatsApp with customer's phone number
- [x] If lat/lng is null, Maps button shows address as query instead
- **Commit**: `feat(mobile): rider order detail with Maps and WhatsApp`

### MP-M6: Google Maps & WhatsApp launchers ✅
- [x] Add `url_launcher` package (if not already present)
- [x] Create `core/utils/launcher_utils.dart`:
  - `openGoogleMaps(double? lat, double? lng, String? addressFallback)` — launches `google.navigation:q=lat,lng` or `geo:0,0?q=address`
  - `openWhatsApp(String phone, {String? message})` — launches `https://wa.me/92XXXXXXXXXX` (strips leading 0, adds country code)
- [x] Handle launch failures gracefully (show snackbar if Maps/WhatsApp not installed)
- **Commit**: `feat(mobile): Google Maps navigation and WhatsApp launcher utilities`

### MP-M7: Rider routes & final wiring ✅
- [x] Add routes: `/rider/orders`, `/rider/orders/:orderNumber` to app_router
- [x] Wire RiderNavigationShell tabs to correct screens
- [ ] Test full flow: login as rider → see orders → tap order → open Maps → open WhatsApp
- [x] Ensure customer login still routes to customer shell
- **Commit**: `feat(mobile): rider flow routes and integration`

---

## Status Summary

| Area | Total | Done | Remaining |
|------|-------|------|-----------|
| Backend | 4 | 4 | 0 |
| Mobile | 7 | 7 | 0 |
| **Total** | **11** | **11** | **0** |

---

## Seed Data Notes

- Create a test delivery boy in Filament with a linked user account (role=rider)
- Assign a few existing orders to the delivery boy for testing
- Ensure at least one order address has lat/lng populated for Maps testing
