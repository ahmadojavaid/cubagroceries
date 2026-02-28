# Cuba Groceries — Flutter ProKit Screen Mapping

> **Status**: COMPLETE
> **Last Updated**: February 2026
> **Primary Source**: `fullApps/grocery/` (Grocery app)
> **Secondary Sources**: `fullApps/shopHop/` (e-commerce), `fullApps/food/` (delivery)

---

## Strategy

1. **Primary**: Use `grocery/` screens as main source — closest match to our app
2. **Secondary**: Pull from `shopHop/` for missing screens (onboarding, address management, order list/detail, settings)
3. **Tertiary**: Pull from `food/` for address form and walkthrough if needed
4. **Extract** matched screens + their widget dependencies into our project
5. **Rewire** static data to Riverpod providers consuming our API
6. **Delete** ProKit after all extractions are complete

---

## ProKit Source Structure

```
prokit-flutter/lib/fullApps/grocery/
├── model/              ← Data models (replace with our API models)
├── screen/             ← 34 screen files
└── utils/
    ├── GroceryColors.dart        ← Color constants
    ├── GroceryConstant.dart      ← Sizing constants
    ├── GroceryImages.dart        ← Image asset paths
    ├── GroceryWidget.dart        ← Shared widgets/helpers
    ├── GroceryDataGenerator.dart ← Dummy data (discard)
    └── GeoceryStrings.dart       ← String constants
```

---

## Screen Mapping

| Cuba Groceries Screen | ProKit Source Screen | ProKit File Path | Phase |
|-----------------------|---------------------|------------------|-------|
| Splash | GrocerySplashScreen | `grocery/screen/GrocerySplash.dart` | M8 |
| Onboarding (2-3 slides) | ShWalkThroughScreen | `shopHop/screens/ShWalkThroughScreen.dart` | M9 |
| Login | GrocerySignUp (has login tab) | `grocery/screen/GrocerySignUp.dart` | M10 |
| Register | GrocerySignUp (has register tab) | `grocery/screen/GrocerySignUp.dart` | M11 |
| Home (categories + featured) | GroceryDashboard | `grocery/screen/GroceryDashboard.dart` | M12, 2.12 |
| Category grid | GroceryCategoryList | `grocery/screen/GroceryCategoryList.dart` | 2.13 |
| Sub-category listing | GrocerySubCategoryList | `grocery/screen/GrocerySubCategoryList.dart` | 2.13 |
| Product listing | GroceryStore | `grocery/screen/GroceryStore.dart` | 2.14 |
| Product detail | GroceryProductDescription | `grocery/screen/GroceryProductDescription.dart` | 2.15 |
| Search | GrocerySearch | `grocery/screen/GrocerySearch.dart` | 2.16 |
| Cart | ShCartScreen | `shopHop/screens/ShCartScreen.dart` | 4.10 |
| Checkout — Address | GroceryDeliveryAddress | `grocery/screen/GroceryDeliveryAddress.dart` | 4.11 |
| Checkout — Review | GroceryCheckOut | `grocery/screen/GroceryCheckOut.dart` | 4.11 |
| Address list | ShAdressManagerScreen | `shopHop/screens/ShAdressManagerScreen.dart` | 3.7 |
| Address add/edit | ShAddNewAddress | `shopHop/screens/ShAddNewAddress.dart` | 3.8 |
| Order history | ShOrderListScreen | `shopHop/screens/ShOrderListScreen.dart` | 4.13 |
| Order detail | ShOrderDetailScreen | `shopHop/screens/ShOrderDetailScreen.dart` | 4.14 |
| Order tracking | GroceryTrackOrder | `grocery/screen/GroceryTrackOrder.dart` | 5.7 |
| Profile | GroceryProfile | `grocery/screen/GroceryProfile.dart` | 3.6 |
| Settings | ShSettingsScreen | `shopHop/screens/ShSettingsScreen.dart` | 3.10 |
| Change Password | GroceryChangePassword | `grocery/screen/GroceryChangePassword.dart` | 3.10 |
| Notifications | GroceryNotification | `grocery/screen/GroceryNotification.dart` | 6.10 |
| Complaint form | GroceryGotQuestion | `grocery/screen/GroceryGotQuestion.dart` | 5.8 |
| Wallet | _Build custom_ | — | 3.9 |

---

## Shared Components to Extract

| Component | ProKit Source | File Path |
|-----------|-------------|-----------|
| Theme colors | GroceryColors | `grocery/utils/GroceryColors.dart` |
| Sizing constants | GroceryConstant | `grocery/utils/GroceryConstant.dart` |
| Shared widgets | GroceryWidget | `grocery/utils/GroceryWidget.dart` |
| Image paths | GroceryImages | `grocery/utils/GroceryImages.dart` |
| Bottom nav bar | GroceryDashboard (contains nav) | `grocery/screen/GroceryDashboard.dart` |
| Product card widget | GroceryStore (inline) | `grocery/screen/GroceryStore.dart` |
| Category card widget | GroceryCategoryList (inline) | `grocery/screen/GroceryCategoryList.dart` |
| Order status timeline | GroceryTrackOrder (inline) | `grocery/screen/GroceryTrackOrder.dart` |
| Loading shimmer | _Use shimmer package_ | — |
| Empty state widget | _Build custom_ | — |
| Error state widget | _Build custom_ | — |

---

## Key Dependencies in ProKit Screens

All ProKit grocery screens depend on:
- `nb_utils` package (common Flutter utilities by Iqonic)
- `prokit_flutter/main.dart` (app-wide state like `appStore`)
- `prokit_flutter/main/utils/AppWidget.dart` (shared app widgets)

**Strategy**: Replace `nb_utils` calls with Flutter equivalents or keep the package. Replace `appStore` references with Riverpod. Replace `AppWidget` helpers with our own.

---

## Notes

- ProKit screens use static/dummy data from `GroceryDataGenerator.dart` — all replaced with Riverpod providers
- Navigation will be rewired to go_router
- State management references in ProKit (if any) will be replaced with Riverpod
- ProKit is a paid commercial kit — extracted files become part of our codebase, kit is deleted after
- The `grocery/` app has 34 screens — we'll use ~20 of them
- `shopHop/` fills gaps: onboarding, address management, order list, settings, cart
- `food/` available as fallback for walkthrough and address forms
