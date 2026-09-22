# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

MyInoface2 is a Flutter mobile application (iOS + Android) for school/institution management. It supports QR code and email/password login, class schedules, shift management (gardes), and recovery requests. The app uses French and Arabic localization.

**Flutter version**: 3.10.0 (managed via FVM — see `.fvmrc`)
**Dart SDK**: >=2.12.0 <3.0.0 (null safety enabled)
**Package name**: `com.inoser.myinoface2`

## Common Commands

```bash
# Use fvm prefix if FVM is installed, otherwise use flutter directly
fvm flutter pub get              # Install dependencies
fvm flutter analyze              # Run Dart linter (uses flutter_lints)
fvm flutter test                 # Run tests
fvm flutter run                  # Run in debug mode
fvm flutter build apk            # Build Android APK
fvm flutter build ios            # Build iOS

# Code generation (required after modifying Moor tables, MobX stores, or BLoC events/states)
fvm flutter pub run build_runner build --delete-conflicting-outputs
fvm flutter pub run build_runner watch   # Watch mode for continuous generation
```

## Architecture

The app follows **Clean Architecture** with a feature-based module structure.

### Layer Structure (per feature)

Each feature in `lib/features/` follows this pattern:

```
feature/
├── data/
│   ├── database/          # Remote + local data source implementations
│   ├── models/            # JSON-serializable models
│   └── repositories/      # Repository implementations
├── domain/
│   ├── entities/          # Business entities
│   ├── repositories/      # Repository interfaces (abstract classes)
│   └── usecases/          # UseCase classes
└── presentation/
    ├── bloc/              # BLoC (events, states, bloc)
    ├── pages/             # Full-screen widgets
    └── widgets/           # Feature-specific UI components
```

### Features

- **login** — Email/password and QR code authentication
- **all_classes** — Student class listings
- **gardes** — Shift/schedule management with calendar
- **demande_recuperation** — Recovery/retrieval requests
- **forgot_pass** — Password reset flow

### Core Module (`lib/core/`)

- **injection/** — GetIt dependency injection setup (`injection_container.dart`). BLoCs are registered as factories; repositories, data sources, and utils as lazy singletons.
- **database/** — Moor (SQLite) ORM database. Singleton at `AppDatabase.instance`. Tables: `DemandesRecuperations`, `ClassEntities`, `EleveEntities`. Generated files: `*.g.dart`.
- **error/** — Failure classes (`ServerFailure`, `CacheFailure`, `NetworkFailure`, `NoDataFailure`) used with `Either<Failure, T>` from dartz.
- **langs/** — Translations (fr.dart, ar.dart) using GetX `Translations`.
- **mobx/** — App-level observable state (`mobx_app.dart` + generated `.g.dart`).
- **usecases/** — Base `UseCase` class, `PreferenceUtils` singleton, `Constants`, Firebase notification setup.
- **util/** — `AppUtils` (abstract) / `AppUtilsImpl` for business logic utilities, `ColorHelper`, `AppTheme`, `SizeConfig`.

### State Management

The app uses a hybrid approach:
- **BLoC** (`flutter_bloc`) — Per-feature state (events/states pattern)
- **MobX** — App-level observable state
- **Provider** — Injecting `AppUtilsImpl`, `AppDatabase`, `ModelNotifier` at the root
- **GetX** — Navigation, routing, and translations

### Error Handling Pattern

Repositories return `Either<Failure, T>` (from dartz). BLoCs handle the Either result and emit corresponding states. Failure types map to specific error scenarios (server, cache, network, no data).

### Dependency Injection Pattern

All DI is in `lib/core/injection/injection_container.dart`. When adding a new feature, register in this order:
1. BLoC (factory)
2. UseCases (lazy singleton)
3. Repository interface → implementation (lazy singleton)
4. Remote data source (lazy singleton)
5. Local data source (lazy singleton)

### App Entry Flow (`lib/main.dart`)

1. Initialize Firebase, DI container (`di.setup()`), Firebase notifications, local notifications
2. Register `NetworkLogic` and `UtilsLogic` as permanent GetX controllers
3. Start an 8-second interval timer calling `appUtils.getAllClasses()`
4. Run app with `MultiProvider` wrapping `GetMaterialApp`
5. Splash screen → `HomePage`

## Key Conventions

- Generated code files end in `.g.dart` — never edit these manually
- BLoC events/states use `part` files (e.g., `part 'login_event.dart'`)
- Entities extend `Equatable` for value comparison
- The Dart package name is `myinoface` (not `myinoface2`)
- Android: minSdk 19, targetSdk 34, multiDex enabled
