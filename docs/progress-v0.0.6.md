# Cuba Groceries — Phase 6 Progress: Dashboard, Notifications & Polish

> **Version**: 0.0.6
> **Phase**: 6 — Dashboard, Notifications & Polish
> **Goal**: Admin dashboard with stats. Push notifications. Production readiness.
> **Last Updated**: February 2026

---

## Backend Micro-Phases

### MP-B1: Filament Dashboard — Stats overview widgets ✅
- ✅ Create `Filament\Widgets\StatsOverviewWidget`
- ✅ Cards: Total Orders, Total Customers, Total Categories, Total Products
- ✅ Each card shows count with icon and description
- ✅ Register widget on Filament dashboard (auto-discovered, removed default AccountWidget)

### MP-B2: Filament Dashboard — Revenue stat card ✅
- ✅ Add Revenue card to StatsOverviewWidget (sum of all delivered order totals, formatted as Rs)
- ✅ Add "Today's Orders" count card
- ✅ Add "Pending Orders" count card

### MP-B3: Filament Dashboard — Order status breakdown widget ✅
- ✅ Create `OrderStatusBreakdownWidget` showing all 5 status counts
- ✅ Uses StatsOverviewWidget with grouped query (single DB call)
- ✅ Color-coded per status with matching icons and descriptions

### MP-B4: Filament Dashboard — Today's Birthdays widget ✅
- ✅ Create `TodaysBirthdaysWidget` (table widget)
- ✅ Query users where date_of_birth month+day = today
- ✅ Show name, email, phone, date of birth
- ✅ Show "No birthdays today" empty state with cake icon

### MP-B5: Filament Dashboard — Recent Orders widget ✅
- ✅ Create `RecentOrdersWidget` (table widget)
- ✅ Show last 5 orders: order_id, customer name, status badge, total, date
- ✅ Link to order view page via eye icon action

### MP-B6: Filament Dashboard — Pending Complaints widget ✅
- ✅ Create `PendingComplaintsWidget` (table widget)
- ✅ Show complaints where status = pending (limit 5)
- ✅ Columns: subject, customer name, date
- ✅ Link to complaint view page, empty state with check icon

### MP-B7: Wallet management from admin ✅
- ✅ Add wallet top-up action on CustomerResource (modal: amount, note, with confirmation)
- ✅ Add wallet deduct action on CustomerResource (modal: amount capped to balance, note)
- ✅ Update user wallet_amount via increment/decrement
- ✅ Balance validation on deduct (prevents over-deduction)

### MP-B8: Notification system — Order status change triggers ✅
- ✅ Create `App\Notifications\OrderStatusChanged` notification class
- ✅ Uses Laravel's database notification channel (notifications table already exists)
- ✅ Triggered from OrderResource changeStatus action (captures old + new status)
- ✅ Notification data: order_id, order_number, old_status, new_status, title, message

### MP-B9: API — NotificationController (list, mark read, mark all read) ✅
- ✅ Create `Api\V1\NotificationController`
- ✅ `GET /api/v1/notifications` — paginated, newest first, with meta
- ✅ `PUT /api/v1/notifications/{id}/read` — mark single as read
- ✅ `PUT /api/v1/notifications/read-all` — mark all as read
- ✅ Routes registered under Sanctum middleware

### MP-B10: Firebase Cloud Messaging — Server-side setup ✅
- ✅ Created `FcmService` using FCM legacy HTTP API (lightweight, no heavy packages)
- ✅ FCM push sent from `OrderStatusChanged` notification's `toArray()` when user has token
- ✅ API endpoint: `POST /api/v1/device-token` via `DeviceTokenController`
- ✅ Migration: `add_fcm_token_to_users_table` (varchar 500, nullable)
- ✅ `fcm_token` added to User model fillable + hidden
- ✅ Firebase server_key config in `config/services.php` (reads `FIREBASE_SERVER_KEY` env)

---

## Mobile Micro-Phases

### MP-M1: Notification data model ✅
- ✅ Create `NotificationModel` (id, type, data map, readAt, createdAt)
- ✅ fromJson matching Laravel database notification format
- ✅ Computed: isRead, title, message, orderNumber, newStatus, isOrderStatusChange
- ✅ `markAsRead()` returns copy with readAt set (for optimistic UI)

### MP-M2: Notification provider ✅
- ✅ Create `NotificationListNotifier` (Riverpod StateNotifier)
- ✅ fetchNotifications (paginated), loadMore
- ✅ markAsRead (single, optimistic), markAllAsRead (optimistic)
- ✅ `unreadNotificationCountProvider` (derived provider)

### MP-M3: Notification inbox screen ✅
- ✅ Build NotificationInboxScreen with paginated list + pull-to-refresh
- ✅ Each item: status-colored icon, title, body, time ago, read/unread styling
- ✅ Tap to mark as read + navigate to order detail
- ✅ "Mark all read" button in app bar (visible when unread > 0)
- ✅ Empty state + error state with retry

### MP-M4: Notification badge on bottom nav ✅
- ✅ Added "Alerts" tab with Badge widget showing unread count
- ✅ Fetch unread count on app start (initState in NavigationShell)
- ✅ Badge updates reactively via Riverpod unreadNotificationCountProvider
- ✅ NavigationShell converted to ConsumerStatefulWidget

### MP-M5: Navigation wiring for notifications ✅
- ✅ Added route: `/notifications` in app_router.dart
- ✅ Notifications tab wired in bottom nav (index 4, between Orders and Profile)
- ✅ Tap notification → navigates to order detail via `/orders/{orderNumber}`
- ✅ BottomNavigationBar set to `fixed` type for 6 items

### MP-M6: Firebase FCM setup in Flutter
- Add `firebase_messaging` and `firebase_core` packages
- Create Firebase project and add `google-services.json`
- Initialize Firebase in main.dart
- Request notification permission
- Get FCM token and send to backend via `POST /api/v1/device-token`

### MP-M7: FCM push notification handling
- Handle foreground notifications (show local notification or in-app banner)
- Handle background/terminated notification taps (navigate to order)
- Token refresh handling (re-send to backend)

### MP-M8: Error states & empty states polish
- Audit all screens for missing error states
- Add consistent error widget with retry across: Home, Categories, Products, Orders, Profile, Complaints, Notifications
- Add consistent empty state widget across all list screens
- Create reusable `ErrorStateWidget` and `EmptyStateWidget` in core/widgets/

### MP-M9: Offline handling
- Add connectivity check (connectivity_plus package)
- Show offline banner when no connection
- Graceful degradation: show cached data or clear offline message
- Retry on reconnection

### MP-M10: Android release build preparation
- Configure app signing (keystore generation)
- Set application ID, version name, version code
- Configure ProGuard/R8 rules
- Set app icon (flutter_launcher_icons)
- Set native splash screen (flutter_native_splash)
- Generate signed APK/AAB

### MP-M11: Play Store listing preparation
- Take screenshots on emulator (phone + tablet if applicable)
- Write Play Store description and short description
- Prepare feature graphic
- Privacy policy URL
- Content rating questionnaire notes

---

## Status Summary

| Area | Total | Done | Remaining |
|------|-------|------|-----------|
| Backend | 10 | 10 | 0 |
| Mobile | 11 | 5 | 6 |
| **Total** | **21** | **15** | **6** |
