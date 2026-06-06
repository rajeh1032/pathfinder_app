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

- Never hardcode colors in widgets.
- Feature UI must read colors from `Theme.of(context).colorScheme` so light and dark mode both work.
- Use `AppColors` only inside theme/token files or when defining shared theme primitives, not directly in feature widgets.
- Keep `AppBar` and `SliverAppBar` styling centralized in `lib/core/theme/app_theme.dart`.
- `AppBar` background color must always match `scaffoldBackgroundColor`.
- Define `AppBar` title font size, weight, icon colors, action icon colors, tint, and scroll behavior in `AppBarTheme`, not per screen.
- `AppBar` titles must use the current screen/tab name, not the app brand name, unless the screen is explicitly a brand/splash/landing context.
- Normal screen `AppBar` titles should use `Text(localizedKey.tr())` so the title gradient from `AppBarTheme.titleTextStyle` is applied centrally.
- Do not hardcode `AppBar` or `SliverAppBar` icon colors, title font sizes, or background colors inside feature widgets.
- If a custom `AppBar` title or leading widget is needed across multiple screens, create or reuse a shared widget under `lib/core/widgets`.
- Do not create local one-off gradient title widgets inside feature files; app bar title gradients belong in `lib/core/theme/app_theme.dart`.
- Keep the default app bar without a back button unless that screen actually needs back navigation.
- Never hardcode user-facing strings in UI.
- Any visible UI text, labels, prices, durations, stats, badges, and demo/sample content must use Easy Localization keys.
- Translation files live in `assets/translations/en.json` and `assets/translations/ar.json`.
- Support English, Arabic, RTL, and LTR.

## Interaction And UI Behavior

- Use `CustomSnackbar` from `lib/core/utils/custom_snackbar.dart` for user feedback instead of raw `SnackBar` calls in feature UI.
- Use `CustomButton` from `lib/core/utils/custom_button.dart` for fixed-height primary, outline, and destructive full-width action buttons.
- Save/update action buttons must start disabled when no local changes exist, become enabled only after the user edits something, show loading while submitting, and return to disabled after a successful save.
- Successful profile and settings preference updates should keep the user on the current screen unless a flow explicitly requires returning. If a previous screen needs refreshed data, return a refresh signal only when the user later navigates back.
- Profile edit and reset-password forms must apply dirty-state logic to their action buttons.
- Settings option screens such as AI mentor tone and career goal tuning must stage selection locally and commit through an explicit `Update` button.
- Notifications must support horizontal swipe-to-dismiss in addition to any visible dismiss control.
- The profile tab must not own saved-jobs UI; saved jobs belong to the jobs feature unless explicitly reassigned.
- Profile/edit account text fields should use the approved Figma-aligned filled background from `Theme.of(context).colorScheme.onPrimary` unless a shared input theme supersedes it.

## Widget Composition And File Size

- Screens should only compose layout and wire state/navigation.
- Extract repeated or complex UI into feature-owned custom widgets under `presentation/widgets`.
- Shared reusable widgets used by multiple features belong in `lib/core/widgets`.
- Keep every Dart file at or below 250 lines.
- If a screen or widget approaches 250 lines, split it before adding more code.
- Use `SafeArea` for mobile screens and bottom action bars unless a deliberate full-bleed design requires otherwise.
- If using a full-bleed hero/header, keep the unsafe area intentional and wrap the remaining content or controls in `SafeArea`.

## Git And Generated Files

- Use `main` and `dev` branches only.
- Do not push directly to `dev`; changes should go through a pull request.
- Pull requests targeting `dev` should require 2 approving code reviews.
- Do not update `main` unless explicitly acting as repository owner `rajeh1032`.
- Repository ruleset JSON files live in `.github/rulesets`.
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
