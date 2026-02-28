# Cuba Groceries — Phase 3.5 Progress: Home Screen Redesign

> **Version**: 0.0.3.5
> **Phase**: 3.5 — Home Screen Enhancement
> **Goal**: Banner slider from admin, beautiful category slider, featured category product sections.
> **Last Updated**: February 2026

---

## Backend Micro-Phases

### MP-B1: Banner table, model & migration ✅
- ✅ `banners` migration: title, image, sort_order, is_active
- ✅ `Banner` model with fillable, casts, `active()` and `ordered()` scopes
- ⚠️ Run: `php artisan migrate`

### MP-B2: Filament BannerResource ✅
- ✅ BannerResource with CRUD, 16:9 image upload, sort order, active toggle
- ✅ Table: image preview, title, sort_order, is_active (icon), created_at
- ✅ Default sort by sort_order asc, ternary active filter
- ✅ Navigation group: Content, icon: heroicon-o-photo

### MP-B3: Add `is_featured` to categories
- Create migration adding `is_featured` boolean to `category` table (default false)
- Update Category model fillable + cast
- Add `is_featured` toggle to CategoryResource form and table

### MP-B4: API — Banners endpoint + Home data endpoint
- `GET /api/v1/banners` — active banners ordered by sort_order
- `GET /api/v1/home` — combined endpoint: banners + featured categories with their products (limit 6 per category)
- Register routes

---

## Mobile Micro-Phases

### MP-M1: Banner & Home data layer
- Create `BannerModel` (id, title, image)
- Create `HomeProvider` (Riverpod) — fetches `/api/v1/home` data (banners + featured sections)
- State holds banners list and featured category sections

### MP-M2: Banner slider widget
- Build `BannerSlider` widget with PageView + auto-scroll + dot indicators
- Cached network images with shimmer placeholder
- Handles empty banners gracefully

### MP-M3: Category horizontal slider widget
- Build compact horizontal scrollable category chips/pills
- Tappable, navigates to category listing/products
- Uses existing category data from CategoriesProvider

### MP-M4: Featured category product sections
- Build `FeaturedSection` widget — section header (category name + "See All") + horizontal product cards
- Product card: image placeholder, name, price, "Add" button (visual only for now)
- Scrollable horizontally per section

### MP-M5: Home screen assembly & wiring
- Rebuild HomeScreen layout: Banner → Categories → Featured Sections
- Wire to HomeProvider + CategoriesProvider
- Pull-to-refresh, shimmer loading states
- AppBar with search icon

---

## Status Summary

| Area | Total | Done | Remaining |
|------|-------|------|-----------|
| Backend | 4 | 2 | 2 |
| Mobile | 5 | 0 | 5 |
| **Total** | **9** | **2** | **7** |
