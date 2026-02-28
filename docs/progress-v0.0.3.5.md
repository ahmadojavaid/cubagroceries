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

### MP-B3: Add `is_featured` to categories ✅
- ✅ Migration: adds `is_featured` boolean to `category` table (default false)
- ✅ Category model: fillable + cast + `featured()` scope
- ✅ CategoryResource: toggle in form + icon column in table
- ⚠️ Run: `php artisan migrate`

### MP-B4: API — Banners endpoint + Home data endpoint ✅
- ✅ `HomeController` with `banners()` and `home()` methods
- ✅ `GET /api/v1/banners` — active banners ordered by sort_order
- ✅ `GET /api/v1/home` — banners + featured categories with products (limit 6, in-stock only)
- ✅ Routes registered under Sanctum middleware

---

## Mobile Micro-Phases

### MP-M1: Banner & Home data layer ✅
- ✅ `BannerModel` (id, title, image)
- ✅ `FeaturedSection` model (category + products list)
- ✅ `HomeProvider` (StateNotifier) — fetches `/home`, caches data, force refresh
- ✅ State holds banners + featured sections

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
| Backend | 4 | 4 | 0 |
| Mobile | 5 | 1 | 4 |
| **Total** | **9** | **5** | **4** |
