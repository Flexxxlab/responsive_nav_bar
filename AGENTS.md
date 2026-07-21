# Codex Instructions

This repo contains the `responsive_nav_barx` Flutter package.

## Read First

- `docs/PROJECT_MAP.md`
- `README.md`
- `CHANGELOG.md` for release context

## Commands

- Install dependencies: `flutter pub get`
- Run tests: `flutter test`
- Analyze: `flutter analyze`
- Format: `dart format .`

## Editing Rules

- Keep the public widget API stable unless making an intentional versioned breaking change.
- Preserve `go_router` integration with `StatefulNavigationShell`.
- Update README screenshots/examples when behavior changes.
- Do not commit `.dart_tool/`, generated API docs, or build output.

## Validation

- Run `flutter test` and `flutter analyze`.
- Check responsive behavior for narrow, medium, and wide layouts when changing layout logic.

