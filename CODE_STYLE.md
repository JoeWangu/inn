# Logic & Code Style Guidelines

This project follows the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style) and [Flutter Style Guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo).

## 1. Static Analysis

We use strict linting rules provided by `flutter_lints`.

- **Run Linter**: `flutter analyze`
- **Fix Lints**: `dart fix --apply`

## 2. Formatting

Code must be formatted using the standard Dart formatter.

- **Run Formatter**: `dart format .`
- **Line Length**: 80 characters (default).

## 3. Architecture & State Management

We use **Riverpod** for state management and dependency injection, following a clean architecture pattern:

### Layering
1.  **Presentation**: Widgets, Pages, and Controllers (Notifiers).
    *   *Rule*: UI should not contain business logic. Delegate to Controllers.
2.  **Domain**: Repositories (Interfaces), Entities (Models), and Use Cases.
    *   *Rule*: Pure Dart code. No Flutter dependencies (except for basic UI types if absolutely necessary).
3.  **Data**: Repository Implementations, Data Sources (API, DB), DTOs.
    *   *Rule*: Handles data fetching and caching.

### Riverpod Guidelines
- Use `@riverpod` annotation for all providers/notifiers (Riverpod Generator).
- Prefer `ConsumerWidget` over `ConsumerStatefulWidget` unless local state (like `TextControllers`) is needed.
- Use `ref.watch` in `build()` and `ref.read` in callbacks.

## 4. Naming Conventions

- **Classes/Enums**: `PascalCase` (`HouseModel`, `AuthStatus`)
- **Files/Directories**: `snake_case` (`house_model.dart`, `auth_repository.dart`)
- **Variables/Functions**: `camelCase` (`isLoading`, `fetchHouses`)
- **Constants**: `lowerCamelCase` (preferred) or `SCREAMING_SNAKE_CASE` (legacy/config).

## 5. Testing

- **Naming**: `target_file_test.dart`
- **Location**: Mirror `lib/` structure inside `test/`.
- **Mocks**: Use `mockito` with `@GenerateMocks` in helpers.
