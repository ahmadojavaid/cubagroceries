# Cuba Groceries — Phase 5 Progress: Delivery & Complaints

> **Version**: 0.0.5
> **Phase**: 5 — Delivery & Complaints
> **Goal**: Delivery assignment, order status workflow, complaint system.
> **Last Updated**: February 2026

---

## Backend Micro-Phases

### MP-B1: Filament DeliveryBoyResource (CRUD) ✅
- ✅ Create DeliveryBoyResource with full CRUD
- ✅ Table columns: id, name, phone, payment (PKR), created_at
- ✅ Form: name (required), phone (required), payment (numeric, default 0)
- ✅ Navigation group: Operations, icon: user-group

### MP-B2: Add delivery_boy_id to orderdetails
- Create migration to add `delivery_boy_id` (nullable FK → deliveryboy.id) to `orderdetails`
- Update Order model: add `deliveryBoy()` belongsTo relationship
- Update DeliveryBoy model: add `orders()` hasMany relationship
- Run migration reminder

### MP-B3: Order status workflow enforcement
- Create `App\Enums\OrderStatus` enum (pending, confirmed, dispatched, delivered, cancelled)
- Define valid transitions map (e.g., pending → confirmed/cancelled, confirmed → dispatched/cancelled, etc.)
- Add `canTransitionTo()` method
- Update Order model to cast status to enum

### MP-B4: Delivery boy assignment on OrderResource
- Add delivery_boy_id select to the existing OrderResource status change action
- Only allow assignment when status is confirmed or dispatched
- Show assigned delivery boy in OrderResource table and view page
- Validate delivery boy exists

### MP-B5: Apply status workflow to OrderResource
- Update OrderResource status change action to use OrderStatus enum
- Validate transitions (only allow valid next statuses)
- Show only valid next statuses in the dropdown
- Display error if invalid transition attempted

### MP-B6: Filament ComplaintResource (list + status management)
- Create ComplaintResource (list + view, no create)
- Table: id, customer name, order_id, subject, status (badge), created_at
- Searchable by subject, customer name
- Filterable by status (pending, in_progress, resolved, closed)
- Status change action on list
- View page: complaint details, customer info, linked order
- Navigation group: Support, icon: chat-bubble-left-ellipsis

### MP-B7: API — ComplaintController@store
- Create `Api\V1\ComplaintController`
- `POST /api/v1/complaints` — submit complaint (subject, message, optional order_id)
- Validate order belongs to user if order_id provided
- Register route under Sanctum middleware

### MP-B8: API — ComplaintController@index
- `GET /api/v1/complaints` — list user's complaints (paginated)
- Include: id, subject, status, order_id, created_at
- Sorted newest first
- Register route

---

## Mobile Micro-Phases

### MP-M1: Complaint data model
- Create `ComplaintModel` (id, subject, message, status, orderId, orderNumber, createdAt)
- fromJson matching API response
- Computed: displayStatus

### MP-M2: Complaint provider
- Create `ComplaintNotifier` (Riverpod StateNotifier)
- Methods: submitComplaint, fetchComplaints (paginated)
- submitComplaint calls `POST /api/v1/complaints`
- fetchComplaints calls `GET /api/v1/complaints`

### MP-M3: Order status timeline widget
- Create `OrderStatusTimeline` reusable widget
- Show all statuses as steps: pending → confirmed → dispatched → delivered
- Highlight current status, dim future steps
- Handle cancelled as special case (red X)
- Use AppColors.status* colors

### MP-M4: Integrate timeline into OrderDetailScreen
- Add OrderStatusTimeline to the top of OrderDetailScreen
- Pass current status from order data
- Visual improvement to order detail

### MP-M5: Complaint submission screen
- Build ComplaintFormScreen
- Fields: subject (required), message (required, multiline)
- Optional: pre-fill order reference if navigated from order detail
- Submit button with loading state
- On success: show snackbar, pop back
- Route: `/complaints/new` (optional query param `?orderId=X`)

### MP-M6: Complaints history screen
- Build ComplaintsHistoryScreen with paginated list
- Each card: subject, status badge, order reference, date
- Empty state
- Accessible from Profile screen

### MP-M7: Navigation wiring
- Add routes: `/complaints`, `/complaints/new`
- Add "File Complaint" action button on OrderDetailScreen
- Add "My Complaints" link on ProfileScreen or SettingsScreen
- Wire all navigation flows

---

## Status Summary

| Area | Total | Done | Remaining |
|------|-------|------|-----------|
| Backend | 8 | 1 | 7 |
| Mobile | 7 | 0 | 7 |
| **Total** | **15** | **1** | **14** |
