# Responsive Nav Bar Project Map

## Purpose

`responsive_nav_barx` is a Flutter package that adapts navigation layout across screen sizes: bottom navigation on mobile, side rail on wider layouts, and top/tab-style navigation for widest layouts.

## Technology Stack

- Flutter package.
- `go_router` dependency.
- Tests through `flutter_test`.

## Entry Points

- Public library: `lib/responsive_nav_bar.dart`
- Tests: currently package test directory if present.
- Package metadata: `pubspec.yaml`

## Public Concepts

- Adaptive navigation container.
- `go_router` integration for shell navigation.
- Navigation items/buttons for app tabs.

## Common Changes

| Task | Primary files | Validation |
|---|---|---|
| Change layout breakpoints | `lib/responsive_nav_bar.dart` | responsive smoke test, `flutter test` |
| Change public item API | `lib/responsive_nav_bar.dart`, README | tests and README update |
| Prepare release | `pubspec.yaml`, `CHANGELOG.md`, README | `flutter test`, `flutter analyze`, `dart format .` |

## No-Edit Areas

- `.dart_tool/`
- `build/`
- generated API docs
- `/pubspec.lock` for this library package

