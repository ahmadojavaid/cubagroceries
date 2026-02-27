# Cuba Groceries — Flutter ProKit Screen Mapping

> **Status**: PENDING — To be completed after ProKit folder analysis in Phase 1
> **Last Updated**: February 2026

---

## Strategy

1. **Identify** the best matching ProKit demo app (grocery/food delivery/e-commerce)
2. **Map** each Cuba Groceries screen to a ProKit screen
3. **Extract** matched screens + their widget dependencies into our project
4. **Rewire** static data to Riverpod providers consuming our API
5. **Delete** ProKit after all extractions are complete

---

## Screen Mapping (To Be Filled)

| Cuba Groceries Screen | ProKit Source Screen | ProKit File Path | Extraction Status |
|-----------------------|---------------------|------------------|------------------|
| Splash | TBD | TBD | [ ] |
| Onboarding (2-3 slides) | TBD | TBD | [ ] |
| Login | TBD | TBD | [ ] |
| Register | TBD | TBD | [ ] |
| Home (categories + featured) | TBD | TBD | [ ] |
| Category grid | TBD | TBD | [ ] |
| Product listing | TBD | TBD | [ ] |
| Product detail | TBD | TBD | [ ] |
| Search | TBD | TBD | [ ] |
| Cart | TBD | TBD | [ ] |
| Checkout flow | TBD | TBD | [ ] |
| Address list | TBD | TBD | [ ] |
| Address add/edit | TBD | TBD | [ ] |
| Order history | TBD | TBD | [ ] |
| Order detail | TBD | TBD | [ ] |
| Profile | TBD | TBD | [ ] |
| Wallet | TBD | TBD | [ ] |
| Settings | TBD | TBD | [ ] |
| Notifications | TBD | TBD | [ ] |
| Complaint form | TBD | TBD | [ ] |

---

## Shared Components to Extract

| Component | ProKit Source | Status |
|-----------|-------------|--------|
| Theme (colors, typography) | TBD | [ ] |
| App bar variants | TBD | [ ] |
| Bottom navigation bar | TBD | [ ] |
| Product card widget | TBD | [ ] |
| Category card widget | TBD | [ ] |
| Order status timeline | TBD | [ ] |
| Loading shimmer | TBD | [ ] |
| Empty state widget | TBD | [ ] |
| Error state widget | TBD | [ ] |
| Button variants | TBD | [ ] |
| Input field variants | TBD | [ ] |

---

## Notes

- ProKit screens use static/dummy data — all will be replaced with Riverpod providers
- Navigation will be rewired to go_router
- State management references in ProKit (if any) will be replaced with Riverpod
- ProKit is a paid commercial kit — extracted files become part of our codebase, kit is deleted after
