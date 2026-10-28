# TreeHouse — iOS app

Native iPhone app (Swift + SwiftUI, iOS 17+) for **TreeHouse – Central Jersey Dispensary**, Somerset, NJ.
In-store pickup ordering, rewards, deals and store info.

- **How to run it (no coding needed):** see [`docs/XCODE_GUIDE.md`](docs/XCODE_GUIDE.md)
- **Architecture:** MVVM. All data access goes through protocols in `TreeHouse/Services/Protocols`.
  The app currently uses `MockDutchieService`; switching to the real Dutchie API is a one-line change in
  `TreeHouse/App/AppEnvironment.swift`.
- **No third-party dependencies.**

## Folder layout

```
TreeHouse/
├── App/            App entry point, tab bar, service container
├── Models/         Product, Cart, Order, Deal, Loyalty, Store, User
├── Services/
│   ├── Protocols/  What the app needs from a backend
│   ├── Mock/       MockDutchieService + realistic sample data
│   ├── Dutchie/    Real Dutchie implementation (to be written)
│   └── Platform/   Location, Face ID, notifications
├── Features/       One folder per screen area (views + view models)
├── DesignSystem/   Colors, spacing, haptics, reusable components
├── Compliance/     Age/geo rules and required warning text
└── Resources/      Asset catalog (app icon, accent color)
```
