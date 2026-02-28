# Cuba Groceries — Progress v0.0.2

> **Phase 2: Catalog (Categories, Units, Products)**
> **Started**: February 2026
> **Status**: IN PROGRESS

---

## Backend Micro-Phases

### MP-B1: Filament UnitResource (CRUD) ✅
- ✅ Create `app/Filament/Resources/UnitResource.php`
- ✅ Form: name (required, unique), abbreviation (optional)
- ✅ Table: id, name, abbreviation, created_at
- ✅ Full-width table layout (via panel provider maxContentWidth)
- ✅ Pages: ListUnits, CreateUnit, EditUnit
- ✅ Navigation group: Catalog, icon: scale
- **Verify**: Units manageable at `/admin/units`

### MP-B2: Filament CategoryResource (CRUD — Basic) ✅
- ✅ Create `app/Filament/Resources/CategoryResource.php`
- ✅ Form: title (required), parent_id (select filtered to top-level, excludes self), image (file upload)
- ✅ Table: id, image (circular), title, parent name, products count, children count, created_at
- ✅ Uses `counts('products')` and `counts('children')` to avoid N+1
- ✅ Filter: top-level vs sub-categories
- ✅ Pages: ListCategories, CreateCategory, EditCategory
- ✅ Navigation group: Catalog, sorted second
- **Verify**: Categories manageable at `/admin/categories`

### MP-B3: Filament CategoryResource — Image Upload Config ✅
- ✅ Image upload configured: `public` disk, `categories/` directory
- ✅ Image resize: 400x400, 1:1 crop, max 2MB
- ✅ Table shows circular image thumbnail with fallback avatar
- ⚠️ Run `php artisan storage:link` if not already done
- **Verify**: Upload image, see it in table thumbnail

### MP-B4: Filament ProductResource (CRUD — Basic) ✅
- ✅ Create `app/Filament/Resources/ProductResource.php`
- ✅ Form: name, stock, category_id (top-level select), sub_category_id (dependent select filtered by category, live), description
- ✅ Table: id, name, category, sub-category, stock (color-coded badge), prices count, price range, created_at
- ✅ Eager load category, subCategory, prices via `getEloquentQuery()`
- ✅ Filters: category, out of stock
- ✅ Pages: ListProducts, CreateProduct, EditProduct
- ✅ Navigation group: Catalog, sorted third
- **Verify**: Products manageable at `/admin/products`

### MP-B5: Filament ProductResource — Multi-Price Repeater ✅
- ✅ Repeater field on `prices` relationship in product form
- ✅ Each row: unit_id (select from units), price (decimal with Rs prefix)
- ✅ Save/update/delete prices via Repeater relationship binding
- ✅ Min 1 price row, add action label "Add price variant"
- ✅ Table shows prices_count and price range summary
- **Verify**: Add product with 2+ price-unit combos, verify saved in `price` table

### MP-B6: API — Categories Endpoints ✅
- ✅ Create `app/Http/Controllers/Api/V1/CategoriesController.php`
- ✅ `GET /api/v1/categories` — top-level with nested children, image URLs via `asset()`
- ✅ `GET /api/v1/categories/{id}` — single category with sub-categories
- ✅ `GET /api/v1/categories/{id}/products` — paginated, includes sub-category products
- ✅ Routes registered in `api.php` (protected by Sanctum)
- ✅ Uses ApiResponse trait
- **Verify**: Test all 3 endpoints return correct JSON

### MP-B7: API — Products Endpoints ✅
- ✅ Create `app/Http/Controllers/Api/V1/ProductsController.php`
- ✅ `GET /api/v1/products` — paginated, filterable by category_id/sub_category_id
- ✅ `GET /api/v1/products/{id}` — detail with prices and units eager loaded
- ✅ `GET /api/v1/products/search?q=` — search by name (PostgreSQL `ilike`)
- ✅ Routes registered in `api.php` (search before show to avoid route conflict)
- ✅ Uses ApiResponse trait
- **Verify**: Test all 3 endpoints, confirm no N+1

### MP-B8: Seed Sample Catalog Data ✅
- ✅ Create `CatalogSeeder` with 4 top-level categories, 2 sub-categories each
- ✅ 15 sample products across categories with 1-2 prices each
- ✅ 5 units: kg, piece, dozen, litre, pack
- ✅ Registered in `DatabaseSeeder`
- ✅ Uses `firstOrCreate` for safe re-runs
- ⚠️ Run: `php artisan db:seed --class=CatalogSeeder`

---

## Mobile Micro-Phases

### MP-M1: Category Data Layer ✅
- ✅ Create `features/categories/data/category_model.dart` (id, title, image, children)
- ✅ Create `features/categories/providers/category_provider.dart` (fetch & cache, findById, getChildren)
- ✅ Wired to `GET /api/v1/categories`
- ✅ Skip re-fetch if already loaded (unless forceRefresh)
- ✅ Follows existing auth provider pattern

### MP-M2: Product Data Layer ✅
- ✅ Create `features/products/data/product_model.dart` (id, name, description, category, prices, stock)
- ✅ Create `features/products/data/price_model.dart` (id, price, unit) with displayPrice helper
- ✅ Create `features/products/data/unit_model.dart` (id, name, abbreviation)
- ✅ Create `features/products/providers/product_provider.dart`:
  - productsProvider: paginated fetch, loadMore, filter by category/sub-category
  - searchProductsProvider: separate provider for search
  - productDetailProvider: FutureProvider.family for single product
- ✅ Wired to `GET /api/v1/products`, `/products/search`, `/products/{id}`

### MP-M3: Home Screen — Category Grid ✅
- ✅ Build HomeScreen replacing placeholder Home tab in NavigationShell
- ✅ Category grid (2 columns) with CachedNetworkImage and fallback icons
- ✅ Tap category → sub-categories if hasChildren, else products
- ✅ Wired to categoriesProvider with pull-to-refresh
- ✅ Error state with retry, empty state, loading state
- ✅ Search icon in app bar → /search route
- ✅ CategoryCard reusable widget created

### MP-M4: Category Listing Screen ✅
- ✅ Build CategoryListingScreen showing sub-categories grid
- ✅ Tap sub-category → product listing with sub_category_id via extra
- ✅ "View all products" button for parent category
- ✅ Empty state when no sub-categories
- ✅ Routes added: /categories/:id, /categories/:id/products, /search
- ✅ Placeholder screens for products and search until MP-M5/M7

### MP-M5: Product Listing Screen (Paginated) ✅
- ✅ Build ProductListingScreen with 2-column card grid
- ✅ Infinite scroll pagination via scroll controller + loadMore
- ✅ Pull-to-refresh via RefreshIndicator
- ✅ ProductCard widget: name, category, first price, out-of-stock badge
- ✅ Tap product → /products/:id (placeholder until MP-M6)
- ✅ Title resolved from categoriesProvider
- ✅ Error state with retry, empty state, loading indicators
- ✅ Route /categories/:id/products now uses real screen
- ✅ Added /products/:id route (placeholder)

### MP-M6: Product Detail Screen ✅
- ✅ Build ProductDetailScreen with FutureProvider.family
- ✅ Name, description, category breadcrumb, stock indicator
- ✅ All price variants listed with unit name and abbreviation
- ✅ Add to cart button (disabled when out of stock, non-functional placeholder)
- ✅ Error state with retry (invalidate provider), not-found state
- ✅ Route /products/:id now uses real screen, all placeholders removed

### MP-M7: Search Screen ✅
- ✅ Build SearchScreen with debounced text input (500ms)
- ✅ Wired to searchProductsProvider (separate from browse provider)
- ✅ Results as 2-column ProductCard grid
- ✅ States: initial (prompt), loading, no results, error
- ✅ Clear button in app bar, autofocus on open
- ✅ Route /search now uses real screen

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
| Backend | 8 | 8 | 0 |
| Mobile | 9 | 7 | 2 |
| **Total** | **17** | **15** | **2** |
