# my_message_fe

Flutter mobile app for **my_message**, a one-to-one chat app. The API it will talk to is
[my_message_be](https://github.com/VigneshJagannadhan/my_message_be).

**Where it is today:** login and register screens (UI and form validation) plus the shared widgets
they are built from. It does not call the backend yet, so there is nothing to configure or sign in
to. Everything below works on a fresh clone.

| Area | State |
| --- | --- |
| Login and register screens | Done |
| Shared widgets and text styles (`lib/core`) | Done |
| State management (BLoC), API calls, token storage | Planned |
| Chat list, chat screen, realtime messages | Planned |

## Quick start

You need Flutter **3.44 or newer** (it ships the Dart 3.12 this project requires), plus Android
Studio (Android emulator) or Xcode (iOS simulator, macOS only).

```bash
git clone git@github.com:VigneshJagannadhan/my_message_fe.git
cd my_message_fe

git config core.hooksPath .githooks   # turn on the commit message check, see "Commit rules"
flutter doctor                        # confirm your toolchain is healthy
flutter pub get                       # install dependencies
flutter run                           # start an emulator/simulator first, or pass -d <device>
```

You should see the **Welcome back** login screen. Tap **Register** to open the sign-up screen and
**Log in** to go back. Submitting only runs form validation for now.

Before every commit:

```bash
flutter analyze   # must report "No issues found"
flutter test      # all tests must pass
```

## What is where, and why

The app is **feature-first**: code is grouped by what it does for the user, not by file type.
Anything used by more than one feature lives in `core`.

```
lib/
  main.dart                          Starts the app: MaterialApp, theme, first screen (LoginPage)
  core/                              Shared building blocks. Features import from here, never the reverse
    theme/app_text_styles.dart       HeadingText / BodyText / LabelText: one place that decides how text looks
    widgets/
      app_button.dart                AppButton (+ .secondary, .destructive): all buttons in the app
      app_text_field.dart            AppTextField (+ .email, .password): all form fields
      app_page_scaffold.dart         Page shell for form screens: safe area, scroll, max width, padding
  features/
    auth/
      presentation/pages/            login_page.dart, register_page.dart
test/
  widget_test.dart                   Login -> Register -> back navigation flow
  app_button_test.dart               AppButton behaviour (tap, loading)
.githooks/commit-msg                 Rejects commit messages that break the rules below
```

**Why `core` exists:** if every screen built its own buttons and fields, the app would drift out of
sync and every design change would touch every screen. Screens compose shared widgets, so a change
in one file updates the whole app.

**Where new code goes:** a new feature is a new folder under `features/`
(for example `features/chat/`). Inside it, start with `presentation/`. As the feature gains logic,
add `domain/` (business rules) and `data/` (API and storage) next to it. A widget moves to `core`
only once a second feature needs it.

## Using the shared widgets

```dart
// Page shell: handles safe area, scrolling, centering and width limit
AppPageScaffold(
  appBar: AppBar(),            // optional
  child: Column(children: [ ... ]),
)

// Text: pick the role, not a font size
Text('Welcome back', style: HeadingText.largeStyle(context))
Text('Log in to continue', style: BodyText.mediumStyle(context))
Text('Error', style: BodyText.smallStyle(context)?.copyWith(color: Colors.red))

// Fields: presets for the common cases, plain AppTextField for anything else
AppTextField.email(controller: _email, validator: ...)
AppTextField.password(controller: _password, validator: ...)   // includes show/hide toggle
AppTextField(controller: _name, label: 'Name', icon: Icons.person_outline)

// Buttons
AppButton(label: 'Log in', onPressed: _submit)                  // primary
AppButton.secondary(label: 'Cancel', onPressed: _cancel)
AppButton.destructive(label: 'Delete', onPressed: _delete)
AppButton(label: 'Log in', onPressed: _submit, isLoading: true) // spinner, taps ignored
AppButton(label: 'Log in', onPressed: null)                     // disabled
```

## Conventions

These keep the codebase consistent. Please follow them.

- **Use the shared widgets.** No raw `FilledButton`, `ElevatedButton` or hand-built text fields in
  screens. If a shared widget is missing something, extend it in `core`.
- **No ad hoc `TextStyle`.** Use `HeadingText`, `BodyText` or `LabelText` and adjust with
  `?.copyWith(...)` if needed.
- **Composition, not inheritance.** Build widgets by wrapping other widgets. Do not create a base
  widget class that others extend: Dart allows one parent, and Stateless/Stateful widgets are
  separate hierarchies.
- **Kinds are named constructors, states are parameters.** `AppButton.destructive(...)` is a kind.
  Disabled (`onPressed: null`) and loading (`isLoading`) are states.
- **Client validation is for usability only.** The backend enforces the real rules.
- **Dispose controllers.** Every `TextEditingController` you create in a `State` is disposed in
  `dispose()` (see `login_page.dart`).

## Commit rules

Commit messages follow [Conventional Commits](https://www.conventionalcommits.org), enforced by a
hook so a bad message never gets in:

```
type(optional-scope): description
```

- Types: `feat fix docs style refactor perf test build ci chore revert`
- Description starts lowercase, no trailing period, first line at most 72 characters
- One logical change per commit

```
feat(auth): add login screen        accepted
fix: password field not obscured    accepted
updated stuff                       rejected
```

The hook is in [`.githooks/commit-msg`](.githooks/commit-msg). Git does not turn it on
automatically, so run this once per clone (it is in Quick start too):

```bash
git config core.hooksPath .githooks
```

## Troubleshooting

| Problem | Fix |
| --- | --- |
| `flutter pub get` fails on the SDK constraint | Upgrade Flutter: `flutter upgrade` (needs Dart 3.12+) |
| No device to run on | Start an emulator/simulator, then `flutter devices` and `flutter run -d <id>` |
| A bad commit message is not rejected | The hook is not on. Run `git config core.hooksPath .githooks` |
| iOS build fails after a Flutter upgrade | `flutter clean && flutter pub get`, then rebuild |

## Related

- Backend API, endpoints and setup: [my_message_be](https://github.com/VigneshJagannadhan/my_message_be)
