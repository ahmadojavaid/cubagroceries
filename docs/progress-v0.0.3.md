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

### MP-B2: Filament CustomerResource ✅
- ✅ CustomerResource with list-only (canCreate: false, no edit)
- ✅ Table columns: id, full_name, email, identity (phone), wallet_amount (PKR), created_at
- ✅ Searchable by firstname, lastname, email, identity
- ✅ Infolist/view page: profile details, wallet balance, addresses count, orders count
- ✅ Navigation group: Customers, icon: heroicon-o-users

### MP-B3: API — ProfileController (show & update) ✅
- ✅ `Api\V1\ProfileController` created with ApiResponse trait
- ✅ `GET /api/v1/profile` — returns authenticated user
- ✅ `PUT /api/v1/profile` — updates firstname, lastname, email, date_of_birth
- ✅ Validation: email unique (except self), names required
- ✅ Routes registered in api.php under Sanctum middleware

### MP-B4: API — ProfileController (password change) ✅
- ✅ Added `password` method to ProfileController
- ✅ `PUT /api/v1/profile/password` — verifies current password, updates to new
- ✅ Validation: current_password required + Hash::check, password min:8|confirmed
- ✅ Route registered in api.php

### MP-B5: API — AddressController (full CRUD) ✅
- ✅ `Api\V1\AddressController` created with ApiResponse trait
- ✅ `GET /api/v1/addresses` — lists user's addresses (default first, then newest)
- ✅ `POST /api/v1/addresses` — creates address (auto-sets default if first)
- ✅ `PUT /api/v1/addresses/{id}` — updates address (ownership via relationship query)
- ✅ `DELETE /api/v1/addresses/{id}` — deletes address (reassigns default to most recent)
- ✅ Validation: address required, label/city/phone/lat/lng optional
- ✅ Routes registered

### MP-B6: API — Address set default + Wallet balance ✅
- ✅ `PUT /api/v1/addresses/{id}/default` — unsets all defaults, sets chosen one
- ✅ `Api\V1\WalletController` created with ApiResponse trait
- ✅ `GET /api/v1/wallet` — returns wallet_amount for authenticated user
- ✅ Routes registered

---

## Mobile Micro-Phases

### MP-M1: Profile Data Layer ✅
- ✅ `UserModel` with fromJson, toJson, copyWith, fullName getter
- ✅ `ProfileProvider` (StateNotifier) — fetchProfile, updateProfile, clearError
- ✅ Wired to `GET /profile` and `PUT /profile` via ApiClient

### MP-M2: Address Data Layer ✅
- ✅ `AddressModel` with fromJson, toJson, displayName getter
- ✅ `AddressProvider` (StateNotifier) — fetchAddresses, addAddress, updateAddress, deleteAddress, setDefault
- ✅ Wired to all `/addresses` endpoints via ApiClient

### MP-M3: Profile Screen (view & edit) ✅
- ✅ ProfileScreen with user info (name, email, phone, DOB)
- ✅ Wallet balance card at top with styled display
- ✅ Edit mode: toggle to inline form with save, cancel
- ✅ Wired to ProfileProvider (fetch, update, error handling)
- ✅ Profile tab in NavigationShell replaces placeholder
- ✅ Menu links to Addresses and Settings screens

### MP-M4: Address List Screen ✅
- ✅ AddressListScreen with address cards (label, address, city, phone)
- ✅ Default badge, highlighted border on default address
- ✅ Actions: Set Default, Edit, Delete with confirmation dialog
- ✅ FAB to add new address, navigates to /addresses/add
- ✅ Edit navigates to /addresses/:id/edit with address as extra
- ✅ Wired to AddressProvider with refresh and error handling

### MP-M5: Address Add/Edit Form ✅
- ✅ AddressFormScreen reused for add (null address) and edit (address passed via extra)
- ✅ Fields: label, address (required), city, phone with icons and hints
- ✅ Form validation, loading spinner on save, error snackbar
- ✅ Routes registered: `/addresses/add`, `/addresses/:id/edit`
- ✅ Pops with `true` on success to trigger list refresh

### MP-M6: Wallet Display Widget ✅
- ✅ Extracted `WalletBalanceCard` widget to `profile/widgets/`
- ✅ Shows formatted Rs. balance with wallet icon
- ✅ ProfileScreen refactored to use extracted widget
- ✅ Reusable across checkout and other screens

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
| Backend | 6 | 6 | 0 |
| Mobile | 8 | 6 | 2 |
| **Total** | **14** | **12** | **2** |
