# Notify

A minimalist flutter app for sending notifications through different means

## How to run it

### Prerequesites
You need to have FVM installed to run the project
You need a firebase project
You need firebase CLI and flutterfire CLI and run
You need a base URL you can watch an example in example_config.json

```
flutterfire configure --[your-firebase-project]
```
### Run it
You can just press F5 in vscode with 

OR

```
chmod 711 run_prod_debug.sh
./run_prod_debug.sh
```
## Decisions Taken for: Mobile (Flutter)
### Setup, Architecture and Design
- Simplified Clean Architecture: The project uses a "Lean" version of Clean Architecture, removing the UseCase layer to avoid "Pass-through" functions (Middle Men) and reduce boilerplate where business logic is straightforward.

- Feature-First Structure: Organized by feature folders (e.g., features/auth/) rather than layers to ensure high cohesion, easier scalability, and faster navigation.

- Bloc & Cubit Split: Used Bloc for complex, event-driven business logic and Cubits for simpler UI states like form validation and toggles to keep the codebase lightweight yet powerful.

- Value Objects for Entities: Modeled domain entities as Value Objects to ensure data integrity and encapsulate business rules within the data structures themselves.

### Implementation
- Functional Error Handling: Integrated the either type for all Repository. This creates explicit contracts, forcing the UI to handle both Failure and Success states at compile-time.

- Direct Repository-to-Client Mapping: In features without local caching, the Repository interacts directly with the API Client, bypassing the DataSource layer to eliminate redundant abstraction.

- Base Repository Pattern: Implemented a centralized Base Repository to standardize the handling of HTTP status codes, timeouts, and the mapping of exceptions into a unified Failure object.
## Known issues
- Limited Theme Support: The app currently supports a single primary theme; a more robust Dynamic Theme system is not yet implemented.

- Hardcoded Error Strings: Some error messages are hardcoded in the Failure classes rather than being fully localized or driven by a translation engine.

## Possible improvements
- Offline First: Adding a Hive or Drift LocalDataSource to the Repository layer for features that require offline persistence.

- Skeleton Loaders: Improving the UX by adding Shimmer/Skeleton loaders to replace the standard CircularProgressIndicator.

## Non Goals
- Full Offline Sync: Real-time synchronization between local and remote databases is out of scope; the app currently fetches fresh data on view initialization.

- Web/Desktop Support: While Flutter is cross-platform, the UI and plugins have only been optimized and tested for Mobile (iOS/Android).

