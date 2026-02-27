# Cuba Groceries — API Architecture

> **Base URL**: `https://cubagroceries.test/api/v1`
> **Auth**: Laravel Sanctum (Bearer Token)
> **Format**: JSON
> **Last Updated**: February 2026

---

## Authentication

All API endpoints serve the Flutter mobile app. Authentication uses Laravel Sanctum with token-based auth.

**Flow**:
1. Customer registers or logs in → receives a Bearer token
2. Token is stored in Flutter secure storage
3. All subsequent requests include `Authorization: Bearer {token}`
4. Token can be revoked on logout

**Headers (all requests)**:
```
Accept: application/json
Content-Type: application/json
Authorization: Bearer {token}  (protected routes only)
```

---

## Response Format

**Success**:
```json
{
  "success": true,
  "data": { ... },
  "message": "Optional message"
}
```

**Paginated**:
```json
{
  "success": true,
  "data": [ ... ],
  "meta": {
    "current_page": 1,
    "last_page": 5,
    "per_page": 20,
    "total": 100
  }
}
```

**Error**:
```json
{
  "success": false,
  "message": "Error description",
  "errors": {
    "field": ["Validation message"]
  }
}
```

---

## Endpoints

### Auth — Public

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/auth/register` | Register new customer |
| `POST` | `/auth/login` | Login with credentials |

**POST /auth/register**
```json
{
  "identity": "03001234567",
  "email": "customer@example.com",
  "firstname": "Ali",
  "lastname": "Khan",
  "password": "password123",
  "password_confirmation": "password123",
  "date_of_birth": "1995-06-15"
}
```
→ Returns: `{ user, token }`

**POST /auth/login**
```json
{
  "email": "customer@example.com",
  "password": "password123"
}
```
→ Returns: `{ user, token }`

---

### Auth — Protected

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/auth/logout` | Revoke current token |
| `GET` | `/auth/user` | Get authenticated user |

---

### Profile

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/profile` | Get customer profile |
| `PUT` | `/profile` | Update profile (name, email, DOB) |
| `PUT` | `/profile/password` | Change password |

---

### Categories

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/categories` | List top-level categories (parent_id = null) |
| `GET` | `/categories/{id}` | Get category with sub-categories |
| `GET` | `/categories/{id}/products` | List products in a category (paginated) |

**GET /categories** Response:
```json
{
  "success": true,
  "data": [
    {
      "id": 21,
      "title": "Fruits",
      "image": "https://cubagroceries.test/storage/categories/fruits.jpg",
      "children": [
        { "id": 25, "title": "Citrus", "image": "..." },
        { "id": 26, "title": "Tropical", "image": "..." }
      ]
    }
  ]
}
```

---

### Products

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/products` | List all products (paginated, filterable) |
| `GET` | `/products/{id}` | Get product detail with prices and units |
| `GET` | `/products/search?q={query}` | Search products by name |

**Query Params for GET /products**:
- `category_id` — Filter by category
- `sub_category_id` — Filter by sub-category
- `page` — Page number
- `per_page` — Items per page (default 20)

**GET /products/{id}** Response:
```json
{
  "success": true,
  "data": {
    "id": 95,
    "name": "Fresh Tomatoes",
    "description": "Farm fresh tomatoes",
    "category": { "id": 21, "title": "Vegetables" },
    "sub_category": { "id": 25, "title": "Fresh Vegetables" },
    "stock": 100,
    "prices": [
      { "id": 1, "price": "120.00", "unit": { "id": 1, "name": "kg" } },
      { "id": 2, "price": "25.00", "unit": { "id": 4, "name": "piece" } }
    ]
  }
}
```

---

### Addresses

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/addresses` | List customer's saved addresses |
| `POST` | `/addresses` | Add new address |
| `PUT` | `/addresses/{id}` | Update address |
| `DELETE` | `/addresses/{id}` | Delete address |
| `PUT` | `/addresses/{id}/default` | Set as default address |

---

### Orders

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/orders` | Place new order |
| `GET` | `/orders` | Order history (paginated) |
| `GET` | `/orders/{order_number}` | Order detail by order_id string |

**POST /orders**:
```json
{
  "address_id": 3,
  "items": [
    { "product_id": 95, "unit_id": 1, "quantity": 2 },
    { "product_id": 90, "unit_id": 4, "quantity": 5 }
  ],
  "use_wallet": false
}
```
→ Returns: `{ order }` with generated order_id (CUBA prefix + 8 digits)

**GET /orders/{order_number}** Response:
```json
{
  "success": true,
  "data": {
    "id": 308,
    "order_id": "CUBA89162301",
    "status": "pending",
    "total_amount": "450.00",
    "address": { "address": "...", "city": "...", "phone": "..." },
    "items": [
      {
        "product": { "id": 95, "name": "Fresh Tomatoes" },
        "unit": { "id": 1, "name": "kg" },
        "quantity": 2,
        "price": "120.00"
      }
    ],
    "created_at": "2026-02-25T17:00:00Z"
  }
}
```

---

### Wallet

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/wallet` | Get wallet balance |
| `GET` | `/wallet/transactions` | Wallet transaction history |

---

### Shipping

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/shipping-charges` | Get available shipping options/rates |

---

### Complaints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/complaints` | Submit a complaint |
| `GET` | `/complaints` | List customer's complaints |

---

### Notifications

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/notifications` | List notifications (paginated) |
| `PUT` | `/notifications/{id}/read` | Mark as read |
| `PUT` | `/notifications/read-all` | Mark all as read |

---

## Admin Portal API (Internal — Filament)

Filament handles its own CRUD operations internally. No separate admin API endpoints are needed. Filament resources map directly to:

- Portal Users (admin management)
- Categories (CRUD + sub-categories)
- Units (CRUD)
- Products (CRUD + price management)
- Customers (listing + wallet management)
- Orders (listing + status management + detail view)
- Delivery Boys (CRUD + payment tracking)
- Shipping Charges (CRUD)
- Complaints (listing + status updates)
- Notifications (management)
- Dashboard (stats widgets)

---

## Rate Limiting

| Scope | Limit |
|-------|-------|
| Auth endpoints (login/register) | 5 requests/minute |
| General API | 60 requests/minute |

---

## Versioning

API is versioned via URL prefix (`/api/v1/`). Future breaking changes will increment to `/api/v2/` while maintaining v1 for backward compatibility during migration period.
