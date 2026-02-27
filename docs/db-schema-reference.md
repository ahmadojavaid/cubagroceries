# Cuba Groceries — Database Schema Reference

> **Source**: Reverse-engineered from Asif Groceries (asifgroceries.pk) via Laravel Debugbar exports.
> **Database**: PostgreSQL | **Connection**: `cubagroceries`
> **Last Updated**: February 2026

---

## Overview

The schema consists of 14 tables organized into 5 domains: Authentication, Catalog, Orders, Operations, and System.

---

## Authentication Domain

### `portal_users` — Admin/Staff Accounts

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| `id` | `bigint` | PK, auto-increment | |
| `name` | `varchar(255)` | not null | |
| `email` | `varchar(255)` | not null, unique | |
| `password` | `varchar(255)` | not null | Hashed |
| `role` | `tinyint` | not null, default 3 | 1=Super Admin, 2=Admin, 3=Staff |
| `remember_token` | `varchar(100)` | nullable | |
| `created_at` | `timestamp` | nullable | |
| `updated_at` | `timestamp` | nullable | |

**Auth Guard**: `portal` (session-based)
**Middleware**: `auth:portal`, `allow.portal.role:1`, `allow.portal.role:1,2,3`
**Model**: `App\Models\PortalUser`

**Role Permissions Observed**:
- Role 1 (Super Admin): Access to all pages including Products, Categories, Customers
- Roles 1,2,3: Access to general portal pages (dashboard, orders)

### `users` — Customer Accounts

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| `id` | `bigint` | PK, auto-increment | |
| `identity` | `varchar(255)` | not null | Phone number or unique customer ID |
| `email` | `varchar(255)` | not null, unique | |
| `firstname` | `varchar(255)` | not null | |
| `lastname` | `varchar(255)` | not null | |
| `password` | `varchar(255)` | not null | Hashed |
| `date_of_birth` | `date` | nullable | Used for birthday feature on dashboard |
| `wallet_amount` | `decimal(10,2)` | not null, default 0.00 | Customer wallet/credit balance |
| `created_at` | `timestamp` | nullable | |
| `updated_at` | `timestamp` | nullable | |

**Auth**: Sanctum token-based (API for mobile app)
**Model**: `App\Models\User`
**Observed Count**: 7 customers (at time of analysis)

---

## Catalog Domain

### `category` — Product Categories (Self-Referencing)

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| `id` | `bigint` | PK, auto-increment | |
| `title` | `varchar(255)` | not null | Category display name |
| `image` | `varchar(255)` | nullable | Category image path |
| `parent_id` | `bigint unsigned` | nullable, FK → category.id | null = top-level category |
| `created_at` | `timestamp` | nullable | |
| `updated_at` | `timestamp` | nullable | |

**Model**: `App\Models\Category`
**Relationships**:
- `parent()` → belongsTo Category (self-referencing)
- `children()` → hasMany Category (sub-categories)
- `products()` → hasMany Product

**Observed Data**:
- Top-level category IDs: 21, 22, 23, 29 (4 categories, `parent_id is null`)
- Categories are listed filtered by `where parent_id is null`
- DataTable shows product count per category via `CategoryDataTable.php:28`

### `product` — Product Catalog

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| `id` | `bigint` | PK, auto-increment | |
| `name` | `varchar(255)` | not null | |
| `description` | `text` | nullable | |
| `category_id` | `bigint unsigned` | not null, FK → category.id | Primary category |
| `sub_category_id` | `bigint unsigned` | nullable, FK → category.id | Sub-category (child of category_id) |
| `stock` | `integer` | not null, default 0 | Available stock quantity |
| `created_at` | `timestamp` | nullable | |
| `updated_at` | `timestamp` | nullable | |

**Model**: `App\Models\Product`
**Relationships**:
- `category()` → belongsTo Category
- `subCategory()` → belongsTo Category (sub_category_id)
- `prices()` → hasMany Price
- `unit()` → belongsTo Unit (direct base unit relationship)

**Observed Data**:
- Product IDs: 86–95 (latest 10, ordered DESC)
- Category IDs referenced: 21, 22, 23

### `price` — Product Price Variants

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| `id` | `bigint` | PK, auto-increment | |
| `product_id` | `bigint unsigned` | not null, FK → product.id | |
| `unit_id` | `bigint unsigned` | not null, FK → unit.id | |
| `price` | `decimal(10,2)` | not null | Price for this product-unit combination |
| `created_at` | `timestamp` | nullable | |
| `updated_at` | `timestamp` | nullable | |

**Model**: `App\Models\Price`
**Relationships**:
- `product()` → belongsTo Product
- `unit()` → belongsTo Unit

**Key Design**: Single product can have multiple prices for different units (e.g., tomatoes: per kg, per crate, per piece).

### `unit` — Measurement Units

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| `id` | `bigint` | PK, auto-increment | |
| `name` | `varchar(255)` | not null | e.g., "kg", "piece", "dozen" |
| `abbreviation` | `varchar(50)` | nullable | Short form |
| `created_at` | `timestamp` | nullable | |
| `updated_at` | `timestamp` | nullable | |

**Model**: `App\Models\Unit`
**Observed Unit IDs**: 1, 4, 5

---

## Orders Domain

### `orderdetails` — Orders

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| `id` | `bigint` | PK, auto-increment | Internal ID (e.g., 308) |
| `order_id` | `varchar(255)` | not null, unique | Display ID pattern: CUBA89162301 |
| `user_id` | `bigint unsigned` | not null, FK → users.id | Customer who placed order |
| `status` | `varchar(50)` | not null | Order status |
| `total_amount` | `decimal(10,2)` | not null | Order total |
| `created_at` | `timestamp` | nullable | |
| `updated_at` | `timestamp` | nullable | |

**Model**: `App\Models\Order`
**Relationships**:
- `user()` → belongsTo User
- `address()` → hasOne OrderAddress
- `products()` → hasMany Orderproduct

**Observed Statuses** (from dashboard): Pending, Delivered, Cancelled
**Order ID Pattern**: "CUBA" prefix + 8 digits (e.g., CUBA89162301)

### `orderaddress` — Order Delivery Addresses (Snapshot)

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| `id` | `bigint` | PK, auto-increment | |
| `order_id` | `bigint unsigned` | not null, FK → orderdetails.id | |
| `address` | `text` | not null | Full delivery address |
| `city` | `varchar(255)` | nullable | |
| `phone` | `varchar(50)` | nullable | |
| `latitude` | `decimal(10,7)` | nullable | |
| `longitude` | `decimal(10,7)` | nullable | |
| `created_at` | `timestamp` | nullable | |
| `updated_at` | `timestamp` | nullable | |

**Model**: `App\Models\OrderAddress`
**Note**: This is a snapshot of the address at order time, not a reference to a saved address.

### `orderproduct` — Order Line Items

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| `id` | `bigint` | PK, auto-increment | |
| `order_id` | `bigint unsigned` | not null, FK → orderdetails.id | |
| `product_id` | `bigint unsigned` | not null, FK → product.id | |
| `unit_id` | `bigint unsigned` | not null, FK → unit.id | |
| `quantity` | `integer` | not null | |
| `price` | `decimal(10,2)` | not null | Price at time of order |
| `created_at` | `timestamp` | nullable | |
| `updated_at` | `timestamp` | nullable | |

**Model**: `App\Models\Orderproduct`

---

## Operations Domain

### `shippingcharge` — Shipping Configuration

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| `id` | `bigint` | PK, auto-increment | |
| `title` | `varchar(255)` | not null | Charge label |
| `amount` | `decimal(10,2)` | not null | Shipping fee |
| `created_at` | `timestamp` | nullable | |
| `updated_at` | `timestamp` | nullable | |

### `deliveryboy` — Delivery Personnel

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| `id` | `bigint` | PK, auto-increment | |
| `name` | `varchar(255)` | not null | |
| `phone` | `varchar(50)` | not null | |
| `payment` | `decimal(10,2)` | not null, default 0.00 | Total payment/earnings |
| `created_at` | `timestamp` | nullable | |
| `updated_at` | `timestamp` | nullable | |

### `complaint` — Customer Complaints

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| `id` | `bigint` | PK, auto-increment | |
| `user_id` | `bigint unsigned` | not null, FK → users.id | |
| `order_id` | `bigint unsigned` | nullable, FK → orderdetails.id | |
| `subject` | `varchar(255)` | not null | |
| `message` | `text` | not null | |
| `status` | `varchar(50)` | not null, default 'pending' | |
| `created_at` | `timestamp` | nullable | |
| `updated_at` | `timestamp` | nullable | |

---

## System Domain

### `notifications` — System Notifications

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| `id` | `uuid` | PK | |
| `type` | `varchar(255)` | not null | Notification class |
| `notifiable_type` | `varchar(255)` | not null | Polymorphic type |
| `notifiable_id` | `bigint unsigned` | not null | Polymorphic ID |
| `data` | `json` | not null | Notification payload |
| `read_at` | `timestamp` | nullable | null = unread |
| `created_at` | `timestamp` | nullable | |
| `updated_at` | `timestamp` | nullable | |

**Queried in**: `portal.layouts.app:218` — `select * from notifications where read_at is null`

### `addresses` — Customer Saved Addresses (New for Rebuild)

| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| `id` | `bigint` | PK, auto-increment | |
| `user_id` | `bigint unsigned` | not null, FK → users.id | |
| `label` | `varchar(100)` | nullable | e.g., "Home", "Office" |
| `address` | `text` | not null | |
| `city` | `varchar(255)` | nullable | |
| `phone` | `varchar(50)` | nullable | |
| `latitude` | `decimal(10,7)` | nullable | |
| `longitude` | `decimal(10,7)` | nullable | |
| `is_default` | `boolean` | not null, default false | |
| `created_at` | `timestamp` | nullable | |
| `updated_at` | `timestamp` | nullable | |

**Note**: This table was NOT in the original system. Added for the rebuild to support reusable customer addresses in the mobile app. Orders will snapshot from these into `orderaddress`.

---

## Entity Relationship Summary

```
portal_users (admin auth)

users ──────┬──> orderdetails ──┬──> orderaddress
            │                   └──> orderproduct
            ├──> addresses (saved)
            ├──> complaint
            └──> notifications

category ──┬──> category (self: parent_id)
           └──> product ──┬──> price ──> unit
                          └──> orderproduct
```

---

## Source Files Identified

| File | Purpose |
|------|---------|
| `app/Models/PortalUser.php` | Admin user model |
| `app/Models/User.php` | Customer model |
| `app/Models/Category.php` | Category model |
| `app/Models/Product.php` | Product model |
| `app/Models/Price.php` | Price variant model |
| `app/Models/Unit.php` | Unit model |
| `app/Models/Order.php` | Order model |
| `app/Models/OrderAddress.php` | Order address model |
| `app/Models/Orderproduct.php` | Order line item model |
| `app/Http/Controllers/PortalControllers/OrderController.php` | Lines 71-88 |
| `app/Http/Controllers/PortalControllers/ProductController.php` | Lines 25-28 |
| `app/Http/Controllers/PortalControllers/CategoryController.php` | Lines 16-19 |
| `app/Http/Controllers/PortalControllers/UserController.php` | Lines 43-46 |
| `app/DataTables/ProductDataTable.php` | Lines 43, 55, 58 |
| `app/DataTables/CategoryDataTable.php` | Line 28 |

---

## Performance Notes from Original System

- **Products DataTable**: 44 queries for 10 products (N+1 problem). Each product triggers separate queries for category, price, and unit. Should be reduced to ~4 queries with eager loading.
- **Categories DataTable**: N+1 on product count per category. Use `withCount('products')`.
- **Notifications**: Queried on every page load from the layout view. Should be cached or queried once per request.
