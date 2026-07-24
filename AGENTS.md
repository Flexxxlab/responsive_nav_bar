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

## Required Review Gate

Before finishing any code change, apply `../docs/REVIEW_CHECKLIST.md` using its
token-bounded protocol. At minimum, check `Reviewer posture`, `Cross-repo`,
`Workspace style and architecture`, and the `responsive_nav_bar` section. For
layout changes, report the narrow/medium/wide precedent or smoke check. Final
responses should report only: checklist sections used, validation run,
responsive checks, public API impact, and open risks.
