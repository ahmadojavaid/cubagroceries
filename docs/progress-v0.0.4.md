# Cuba Groceries — Phase 4 Progress: Cart, Checkout & Orders

> **Version**: 0.0.4
> **Phase**: 4 — Cart, Checkout & Orders
> **Goal**: Order placement and management. Full purchase flow in app.
> **Last Updated**: February 2026

---

## Backend Micro-Phases

### MP-B1: Filament ShippingChargeResource ✅
- ✅ Create ShippingChargeResource (CRUD)
- ✅ Table columns: id, title, amount (PKR), created_at
- ✅ Simple form: title (required), amount (required, numeric)
- ✅ Navigation group: Operations, icon: truck

### MP-B2: API — ShippingController ✅
- ✅ Create `Api\V1\ShippingController`
- ✅ `GET /api/v1/shipping-charges` — list all shipping options
- ✅ Register route under Sanctum middleware

### MP-B3: Order ID generator utility ✅
- ✅ Create `App\Services\OrderIdGenerator`
- ✅ Pattern: "CUBA" + 8 random digits (e.g., CUBA89162301)
- ✅ Ensure uniqueness check against `orderdetails` table
- ✅ Unit-testable static method

### MP-B4: API — OrderController@store (place order) ✅
- ✅ Create `Api\V1\OrderController`
- ✅ `POST /api/v1/orders` — validate items, check stock, calculate total
- ✅ Create order + snapshot address into `orderaddress` + create line items in `orderproduct`
- ✅ Use OrderIdGenerator for order_id
- ✅ Register route

### MP-B5: Stock deduction on order placement ✅
- ✅ Deduct stock from `product` table for each ordered item
- ✅ Reject order if any item is out of stock (validate before creating)
- ✅ Wrap in DB transaction (order + address + items + stock all atomic)

### MP-B6: API — OrderController@index (order history) ✅
- ✅ `GET /api/v1/orders` — paginated order history for authenticated user
- ✅ Include: order_id, status, total_amount, products_count, created_at
- ✅ Sorted by newest first
- ✅ Register route

### MP-B7: API — OrderController@show (order detail) ✅
- ✅ `GET /api/v1/orders/{order_number}` — full order detail by order_id string
- ✅ Include: order info, address snapshot, line items with product name + unit + price
- ✅ Ownership check (user can only see own orders)
- ✅ Register route

### MP-B8: Filament OrderResource (list + view + status) ✅
- ✅ Create OrderResource (list + view only, no create/edit)
- ✅ Table: id, order_id, customer name, status (badge), total_amount, items count, created_at
- ✅ Searchable by order_id, customer name
- ✅ Filterable by status
- ✅ View page (infolist): order info, customer, address, line items with RepeatableEntry
- ✅ Status change action (select from: pending, confirmed, dispatched, delivered, cancelled)
- ✅ Navigation group: Orders, icon: shopping-bag

---

## Mobile Micro-Phases

### MP-M1: Cart data model ✅
- ✅ Create `CartItemModel` (productId, productName, unitId, unitName, price, quantity)
- ✅ toJson / fromJson for Hive serialization
- ✅ Computed: lineTotal (price × quantity), cartKey, displayPrice, displayLineTotal

### MP-M2: Cart provider with Hive persistence ✅
- ✅ Create `CartNotifier` (Riverpod StateNotifier)
- ✅ Methods: addItem, removeItem, updateQuantity, incrementQuantity, decrementQuantity, clearCart
- ✅ Persist to Hive box on every change (JSON-encoded)
- ✅ Load from Hive on init
- ✅ Computed: itemCount, totalQuantity, subtotal, isEmpty
- ✅ Helper: isInCart, getQuantity

### MP-M3: Hive initialization ✅
- ✅ hive + hive_flutter already in pubspec
- ✅ Initialize Hive in main.dart before runApp
- ✅ Cart box opened lazily by CartNotifier on first access

### MP-M4: Cart screen ✅
- ✅ Build CartScreen showing list of cart items
- ✅ Each item: product name, unit, price, quantity +/- buttons, line total
- ✅ Subtotal display at bottom with item count
- ✅ "Proceed to Checkout" button (hidden if empty)
- ✅ Empty cart state with icon and message
- ✅ Clear cart action with confirmation dialog
- ✅ Wire Cart tab in NavigationShell (replaced placeholder)

### MP-M5: Shipping data layer ✅
- ✅ Create `ShippingChargeModel` (id, title, amount, displayAmount, amountValue)
- ✅ Create `ShippingNotifier` — fetches `GET /api/v1/shipping-charges`

### MP-M6: Order data models ✅
- ✅ Create `OrderModel` (id, orderId, status, totalAmount, productsCount, createdAt)
- ✅ Create `OrderDetailModel` (full detail with address + line items)
- ✅ Create `OrderItemModel` (productName, unitName, quantity, price)
- ✅ Create `OrderAddressModel` (address, city, phone)

### MP-M7: Order provider ✅
- ✅ Create `OrderListNotifier` — fetchOrders (paginated), loadMore
- ✅ Create `OrderActionNotifier` — placeOrder, fetchOrderDetail
- ✅ placeOrder calls `POST /api/v1/orders`, returns OrderDetailModel
- ✅ fetchOrders calls `GET /api/v1/orders` with pagination + loadMore

### MP-M8: Checkout flow — Address selection step ✅
- ✅ Build CheckoutScreen with Stepper/multi-step UI
- ✅ Step 1: Select delivery address from saved addresses
- ✅ Show address radio cards, default pre-selected
- ✅ "Add New Address" link
- ✅ "Next" button with validation

### MP-M9: Checkout flow — Shipping selection step ✅
- ✅ Step 2: Select shipping option
- ✅ Show shipping charges as radio cards (title + amount)
- ✅ Pre-select first option
- ✅ "Next" button

### MP-M10: Checkout flow — Review & Confirm step ✅
- ✅ Step 3: Order review with address, items, subtotal, shipping, grand total
- ✅ "Place Order" button with loading state
- ✅ On success: clear cart, show success snackbar, navigate to order detail
- ✅ On error: show error snackbar

### MP-M11: Order history screen ✅
- ✅ Build OrderHistoryScreen with paginated list + pull-to-refresh
- ✅ Each order card: order_id, status badge, total, date, items count
- ✅ Tap navigates to order detail
- ✅ Wire Orders tab in NavigationShell (replaced placeholder)
- ✅ Infinite scroll (loadMore on scroll near bottom)

### MP-M12: Order detail screen ✅
- ✅ Build OrderDetailScreen showing full order info
- ✅ Sections: status badge, order info, delivery address, line items, totals
- ✅ Route: `/orders/:orderNumber`
- ✅ Error state with retry

### MP-M13: Navigation wiring & routes ✅
- ✅ Add routes: `/checkout`, `/orders/:orderNumber`
- ✅ Cart tab uses CartScreen with checkout navigation
- ✅ Orders tab uses OrderHistoryScreen
- ✅ Checkout → order detail flow complete

---

## Status Summary

| Area | Total | Done | Remaining |
|------|-------|------|-----------|
| Backend | 8 | 8 | 0 |
| Mobile | 13 | 13 | 0 |
| **Total** | **21** | **21** | **0** |
