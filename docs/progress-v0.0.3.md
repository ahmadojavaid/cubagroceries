# Cuba Groceries — Phase 3 Progress: Customer Profile & Addresses

> **Version**: 0.0.3
> **Phase**: 3 — Customer Profile & Addresses
> **Goal**: Customer management in admin. Profile, address, wallet, and settings in app.
> **Last Updated**: February 2026

---

## Backend Micro-Phases

### MP-B1: Address Model & Migration ✅
- ✅ `addresses` migration exists: `2026_02_28_000011_create_addresses_table.php` (user_id, label, address, city, phone, latitude, longitude, is_default)
- ✅ `Address` Eloquent model with `user()` belongsTo, fillable fields, and casts
- ✅ `User` model has `addresses()` hasMany relationship
- ✅ Migration already ran in Phase 1 (all 14 tables created together)

### MP-B2: Filament CustomerResource
- Create CustomerResource (list only — no create/edit from admin)
- Table columns: id, full name (firstname + lastname), email, identity (phone), wallet_amount, created_at
- Searchable by name, email, phone
- Infolist/view page showing: profile details, wallet balance, addresses count, orders count
- Navigation group: Customers, icon: users

### MP-B3: API — ProfileController (show & update)
- Create `Api\V1\ProfileController`
- `GET /api/v1/profile` — return authenticated user profile
- `PUT /api/v1/profile` — update firstname, lastname, email, date_of_birth
- Validation: email unique (except self), names required
- Register routes in api.php under Sanctum middleware

### MP-B4: API — ProfileController (password change)
- Add `password` method to ProfileController
- `PUT /api/v1/profile/password` — change password
- Validation: current_password required + verified, new password min 8 + confirmed
- Register route

### MP-B5: API — AddressController (full CRUD)
- Create `Api\V1\AddressController`
- `GET /api/v1/addresses` — list user's addresses (default first)
- `POST /api/v1/addresses` — create address (auto-set default if first)
- `PUT /api/v1/addresses/{id}` — update address (ownership check)
- `DELETE /api/v1/addresses/{id}` — delete address (ownership check, reassign default)
- Validation: address required, label/city/phone/lat/lng optional
- Register routes

### MP-B6: API — Address set default + Wallet balance
- Add `PUT /api/v1/addresses/{id}/default` — set as default (unset others)
- Create `Api\V1\WalletController`
- `GET /api/v1/wallet` — return wallet_amount for authenticated user
- Register routes

---

## Mobile Micro-Phases

### MP-M1: Profile Data Layer
- Create `UserModel` (id, identity, email, firstname, lastname, date_of_birth, wallet_amount)
- Create `ProfileProvider` (Riverpod) — fetchProfile, updateProfile
- Wire to `GET /api/v1/profile` and `PUT /api/v1/profile`

### MP-M2: Address Data Layer
- Create `AddressModel` (id, label, address, city, phone, latitude, longitude, is_default)
- Create `AddressProvider` (Riverpod) — fetchAddresses, addAddress, updateAddress, deleteAddress, setDefault
- Wire to all `/api/v1/addresses` endpoints

### MP-M3: Profile Screen (view & edit)
- Build ProfileScreen showing user info (name, email, phone, DOB, wallet balance)
- Edit mode: inline editing with save button
- Wire to ProfileProvider
- Wire Profile tab in NavigationShell (replace placeholder)

### MP-M4: Address List Screen
- Build AddressListScreen showing saved addresses as cards
- Default address badge, edit/delete actions
- Set default button
- Navigate to add/edit form
- Wire to AddressProvider

### MP-M5: Address Add/Edit Form
- Build AddressFormScreen (reused for add and edit)
- Fields: label, address, city, phone
- Validation, loading/success/error states
- Route: `/addresses/add`, `/addresses/:id/edit`

### MP-M6: Wallet Display Widget
- Build wallet balance card widget for profile screen
- Shows formatted balance with currency
- Wire to wallet_amount from ProfileProvider (already in UserModel)

### MP-M7: Settings Screen (password change + logout)
- Build SettingsScreen with change password form (current, new, confirm)
- Logout button with confirmation dialog
- Wire password change to `PUT /api/v1/profile/password`
- Wire logout to existing auth provider
- Route: `/settings`

### MP-M8: Navigation Wiring & Profile Tab
- Add routes: `/profile`, `/addresses`, `/addresses/add`, `/addresses/:id/edit`, `/settings`
- Profile tab in NavigationShell uses ProfileScreen
- Profile screen links to: addresses, settings
- Back navigation works correctly

---

## Status Summary

| Area | Total | Done | Remaining |
|------|-------|------|-----------|
| Backend | 6 | 1 | 5 |
| Mobile | 8 | 0 | 8 |
| **Total** | **14** | **1** | **13** |
