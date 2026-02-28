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

### MP-M6: Firebase FCM setup in Flutter ✅
- ✅ Added `firebase_core` and `firebase_messaging` to pubspec.yaml
- ⚠️ Firebase project + `google-services.json` — manual step (see below)
- ✅ `Firebase.initializeApp()` in main.dart
- ✅ Created `FcmService` (core/services/fcm_service.dart) — requests permission, gets token, sends to backend
- ✅ Created `fcmServiceProvider` — injected into AuthNotifier
- ✅ FCM initialized after login, register, and checkAuth
- ✅ Added `google-services` plugin to Android Gradle config

### MP-M7: FCM push notification handling ✅
- ✅ Created `FcmNotificationHandler` (core/services/fcm_notification_handler.dart)
- ✅ Foreground: shows SnackBar with title/body + "View" action for order notifications
- ✅ Background tap: navigates to order detail via `onMessageOpenedApp`
- ✅ Terminated tap: checks `getInitialMessage()` on startup
- ✅ Background handler registered as top-level function
- ✅ Token refresh: `onTokenRefresh` listener re-sends to backend

### MP-M8: Error states & empty states polish ✅
- ✅ `ErrorStateWidget` and `EmptyStateWidget` already existed in core/widgets/shared_widgets.dart
- ✅ Refactored order_history_screen: added missing error state, replaced inline empty with shared widget
- ✅ Refactored complaints_history_screen: replaced inline error/empty with shared widgets
- ✅ Refactored notification_inbox_screen: replaced inline error/empty with shared widgets
- ✅ Home screen already uses shared ErrorStateWidget (verified)

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
| Mobile | 11 | 8 | 3 |
| **Total** | **21** | **18** | **3** |
