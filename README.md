# PathFinder AI

PathFinder AI is a Flutter mobile app scaffold for an AI-powered career guidance platform.

## Architecture

The project uses Feature-First Clean Architecture:

- `lib/core`: app setup, DI, routing, networking, storage, theme, localization, validation, shared widgets, extensions, and utilities.
- `lib/features`: feature modules with `data`, `domain`, and `presentation` layers.
- `assets/translations`: Easy Localization translation files.

## Requirements

- Flutter with Dart `>=3.4.0 <4.0.0`.
- Run `flutter pub get` after cloning.
- Run code generation after changing injectable/json/freezed annotations.

## Commands

```bash
flutter pub get
flutter pub run build_runner build
flutter analyze
flutter test
```

## Notes

- The app currently contains architecture scaffolding and an example auth login flow.
- Do not commit `.env`, Firebase config files, build outputs, or local IDE caches.
- `lib/core/di/di.config.dart` is intentionally tracked because the app imports it at startup.
