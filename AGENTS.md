# AI Project Rules

This file is the project spec for AI coding assistants. Read it before editing the codebase.

## Product Context

PathFinder AI is a Flutter mobile app for AI-powered career guidance. The app helps users discover career paths, analyze CVs, build roadmaps, find courses/jobs, generate cover letters, chat with an AI mentor, and practice interviews.

## Architecture Rules

- Use Feature-First Clean Architecture.
- Keep feature code under `lib/features/<feature_name>`.
- Each feature follows `data`, `domain`, and `presentation`.
- Use lowercase folder names and snake_case file names only.
- Do not create UI screens outside their owning feature.
- Do not put business logic in widgets.
- Do not create God classes.
- Keep feature-specific widgets inside their feature.
- Keep shared reusable widgets in `lib/core/widgets`.

## Layering Rules

- Domain entities are pure Dart classes and should use `Equatable`.
- Data models must not extend domain entities.
- Convert models to entities with `toEntity()`.
- Repositories and use cases should return `Future<Either<Failure, T>>`.
- Do not throw errors into UI.
- UI receives state from Cubits.

## State Management

- Use `flutter_bloc`.
- Use `Cubit` for normal feature state.
- Use `HydratedCubit` only for persistent app state such as theme, language, auth session, or onboarding status.
- State classes should use `Equatable`.
- Prefer explicit states such as `Initial`, `Loading`, `Success`, `Error`, and `Empty`.

## Dependency Injection

- Use `get_it` and `injectable`.
- Register dependencies through annotations and modules under `lib/core/di`.
- After DI changes, run:

```bash
flutter pub run build_runner build
```

## Networking

- Use `Dio` through `ApiClient`.
- Use `connectivity_plus: ^6.1.5` for connectivity checks.
- Keep API paths centralized in `ApiEndpoints`.
- Attach auth tokens through `ApiInterceptor`.
- Handle Dio errors through `DioErrorHandler`.

## Theme And Localization

- Never hardcode colors in widgets. Use `AppColors` and theme tokens.
- Never hardcode user-facing strings in UI. Use Easy Localization keys.
- Translation files live in `assets/translations/en.json` and `assets/translations/ar.json`.
- Support English, Arabic, RTL, and LTR.

## Git And Generated Files

- Do not commit build output, local IDE caches, `.env`, or Firebase secrets.
- Keep `pubspec.lock` tracked for the app.
- Keep `lib/core/di/di.config.dart` tracked because startup imports it.
- Do not edit generated files manually unless explicitly requested.

## Verification

Before handing off code changes, run:

```bash
flutter pub get
flutter analyze
flutter test
```

Run `build_runner` too if annotations, DI, models, or generated files changed.
