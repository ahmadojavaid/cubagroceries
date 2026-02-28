# Cuba Groceries — Progress v0.0.2

> **Phase 2: Catalog (Categories, Units, Products)**
> **Started**: February 2026
> **Status**: IN PROGRESS

---

## Backend Micro-Phases

### MP-B1: Filament UnitResource (CRUD)
- Create `app/Filament/Resources/UnitResource.php`
- Form: name (required), abbreviation (optional)
- Table: id, name, abbreviation, created_at
- Full-width table layout
- **Verify**: Units manageable at `/admin/units`

### MP-B2: Filament CategoryResource (CRUD — Basic)
- Create `app/Filament/Resources/CategoryResource.php`
- Form: title (required), parent_id (select, nullable — top-level categories only), image (file upload)
- Table: id, title, parent category name, image thumbnail, product count, created_at
- Use `withCount('products')` to avoid N+1
- **Verify**: Categories manageable at `/admin/categories`

### MP-B3: Filament CategoryResource — Image Upload Config
- Configure storage disk for category images (`public` disk, `categories/` directory)
- Run `php artisan storage:link` if not done
- Ensure image displays in table and form
- **Verify**: Upload image, see it in table thumbnail

### MP-B4: Filament ProductResource (CRUD — Basic)
- Create `app/Filament/Resources/ProductResource.php`
- Form: name, description (textarea), category_id (select), sub_category_id (dependent select filtered by category), stock (number)
- Table: id, name, category, sub-category, stock, created_at
- Eager load category and subCategory
- **Verify**: Products manageable at `/admin/products`

### MP-B5: Filament ProductResource — Multi-Price Repeater
- Add Filament Repeater field to ProductResource form for prices
- Each row: unit_id (select from units), price (decimal input)
- Save/update/delete prices via Repeater
- Show price count in table column
- **Verify**: Add product with 2+ price-unit combos, verify saved in `price` table

### MP-B6: API — Categories Endpoints
- Create `app/Http/Controllers/Api/V1/CategoriesController.php`
- `GET /api/v1/categories` — top-level categories with nested children, with images
- `GET /api/v1/categories/{id}` — single category with sub-categories
- `GET /api/v1/categories/{id}/products` — paginated products in category
- Register routes in `api.php` (protected by Sanctum)
- Use ApiResponse trait
- **Verify**: Test all 3 endpoints return correct JSON

### MP-B7: API — Products Endpoints
- Create `app/Http/Controllers/Api/V1/ProductsController.php`
- `GET /api/v1/products` — paginated, filterable by category_id/sub_category_id
- `GET /api/v1/products/{id}` — detail with prices and units eager loaded
- `GET /api/v1/products/search?q=` — search by name
- Register routes in `api.php`
- Use ApiResponse trait
- **Verify**: Test all 3 endpoints, confirm no N+1

### MP-B8: Seed Sample Catalog Data
- Create `CatalogSeeder` with 3-4 top-level categories, 2-3 sub-categories each
- Add 10-15 sample products across categories with 1-2 prices each
- Register in `DatabaseSeeder`
- **Terminal**: `php artisan db:seed --class=CatalogSeeder`

---

## Mobile Micro-Phases

### MP-M1: Category Data Layer
- Create `features/categories/data/category_model.dart` (id, title, image, children)
- Create `features/categories/providers/category_provider.dart` (fetch & cache categories)
- Wire to `GET /api/v1/categories`

### MP-M2: Product Data Layer
- Create `features/products/data/product_model.dart` (id, name, description, category, prices, stock)
- Create `features/products/data/price_model.dart` (id, price, unit)
- Create `features/products/providers/product_provider.dart` (paginated fetch, filter by category)
- Wire to `GET /api/v1/products`

### MP-M3: Home Screen — Category Grid
- Build Home screen replacing placeholder tab
- Display category grid (2 columns) with images and titles
- Tap category → navigate to category products screen
- Wire to category provider

### MP-M4: Category Listing Screen
- Build category listing screen showing sub-categories
- Tap sub-category → navigate to product listing filtered by sub-category
- Handle categories with no sub-categories (go directly to products)

### MP-M5: Product Listing Screen (Paginated)
- Build product listing screen with card grid/list
- Infinite scroll pagination via product provider
- Pull-to-refresh
- Show product name, image placeholder, first price
- Tap product → navigate to product detail

### MP-M6: Product Detail Screen
- Build product detail screen
- Show name, description, all price variants with unit selection
- Stock indicator
- Add to cart button (non-functional placeholder for now)

### MP-M7: Search Screen
- Build search screen with debounced text input
- Wire to `GET /api/v1/products/search?q=`
- Show results as product cards
- Loading state while searching, empty state for no results

### MP-M8: Shimmer Loading & Image Caching
- Add shimmer loading placeholders to: home screen, category listing, product listing
- Configure `cached_network_image` for product/category images
- Add error/fallback image widget
- Add empty state widget for lists with no data

### MP-M9: Navigation Wiring
- Add routes to GoRouter: `/categories/:id`, `/products`, `/products/:id`, `/search`
- Wire all navigation: home → category → products → detail
- Wire search from home app bar
- Ensure back navigation works correctly

---

## Status Summary

| Area | Total | Done | Remaining |
|------|-------|------|-----------|
| Backend | 8 | 0 | 8 |
| Mobile | 9 | 0 | 9 |
| **Total** | **17** | **0** | **17** |
