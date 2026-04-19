# Workout Diary — Context for Claude Code

Project: Flutter mobile app for tracking gym workouts.
College senior project, SE 4th year, Almaty.
Solo developer, 30-day timeline, portfolio-quality focus.

## Priority
Architecture cleanliness > feature count. This is a defense project; the examiner cares about clean layers, SOLID principles, tests, and documentation more than shipping every feature.

## Stack
- Flutter 3.x (Dart 3.x)
- State: `flutter_riverpod` (only `Provider`, `StreamProvider`, `AsyncNotifierProvider` — no StateProvider, no ChangeNotifier)
- Navigation: `go_router` with `ShellRoute` for bottom nav
- Backend: Firebase (Auth, Firestore, Storage)
- Models: `freezed` + `json_serializable`
- Charts: `fl_chart`
- Icons: `lucide_icons`
- Utils: `intl`, `wakelock_plus`, `connectivity_plus`, `package_info_plus`

## Architecture — Feature-First + 3-layer

```
lib/
├── main.dart
├── firebase_options.dart
├── core/
│   ├── constants/        # colors, text_styles, exercise_seed
│   ├── router/           # app_router.dart (go_router config)
│   ├── theme/            # app_theme.dart
│   ├── errors/           # app_exception.dart (sealed hierarchy)
│   └── utils/            # date_formatter, volume_calculator, snackbar_helper
├── data/
│   ├── models/           # *_model.dart (Freezed classes)
│   ├── repositories/
│   │   ├── interfaces/   # i_*_repository.dart (abstract)
│   │   └── implementations/  # firebase_*_repository.dart
│   └── services/         # firestore_service, auth_service, storage_service
└── features/
    ├── auth/             # login, register screens + providers
    ├── home/
    ├── workout/          # active, start, history, detail
    ├── exercises/        # library, detail, create/edit
    ├── progress/
    └── profile/
```

**Strict flow:** UI → Provider → Repository (interface) → Service → Firebase.
Never call Firebase or Service from UI or from another Provider directly.

## Conventions

### Naming
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Providers: `{thing}Provider` (e.g., `workoutRepositoryProvider`)
- Notifiers: `{Thing}Notifier` (e.g., `ActiveWorkoutNotifier`)
- Abstract repositories: `I{Thing}Repository` (e.g., `IWorkoutRepository`)
- Firebase impls: `Firebase{Thing}Repository`

### Code style
- Comments only where logic is non-obvious. In English.
- UI strings in English, collected in `core/constants/strings.dart`.
- Hard rule: **no colors hardcoded in widgets**. Only via `AppColors`.
- Hard rule: **no `TextStyle(fontSize: X)` inline**. Only via `AppTextStyles`.
- Hard rule: **no magic numbers for spacing**. Use `AppSpacing` (4/8/12/16/24/32/48).
- Prefer `const` constructors everywhere possible.
- Use `AsyncValue.when` for loading/error/data, not `FutureBuilder`.
- Use `ref.watch` for reading, `ref.read(...).method()` for actions.

### Anti-patterns — DO NOT
- `StatefulWidget` when Riverpod works (very rare exception: controllers like `TextEditingController`).
- `setState` alongside Riverpod. Pick one (Riverpod).
- `Navigator.push` / `Navigator.pop` mixed with `go_router`. Use `context.push()` / `context.pop()` / `context.go()`.
- Direct `FirebaseFirestore.instance` in UI or providers. Always via repository.
- Business logic in `build()`. Move to Notifier methods.
- Singletons via `static` fields. Use `Provider`.
- `print()` in committed code. Use `debugPrint` in debug-only spots.

## Git

### Branches
- `feature/{name}` for new work
- `fix/{name}` for bugfixes
- `refactor/{name}` for refactors
- Merge to `main` via PR (self-PR for this project; use the habit)

### Commits (Conventional Commits)
```
feat: add workout creation flow
fix: restore unfinished workout on app start
refactor: extract exercise picker to shared widget
test: cover PR calculation edge cases
docs: update Firestore schema in decisions.md
chore: bump flutter_riverpod to 2.5.0
```

## Firestore schema

```
users/{userId}
  email, name, goal, age, height, weight, units (kg/lbs),
  defaultRestTimer (seconds), soundEnabled (bool),
  photoUrl, createdAt
  
  workouts/{workoutId}
    name, startedAt, finishedAt (null if active),
    duration, totalVolume, notes
    exercises: [{
      exerciseId, exerciseName (denormalized), order,
      sets: [{ weight, reps, isCompleted, estimatedOneRM }]
    }]
  
  personalRecords/{exerciseId}
    estimatedOneRM, weight, reps, workoutId, updatedAt

exercises/{exerciseId}   # global, read-all, write-own-custom
  name, muscleGroup, equipment, isCustom, createdBy, isDeleted, description
```

### Denormalization rule
`exerciseName` duplicated inside workout documents. Never join. Firestore has no joins; writes are cheap, reads are the bottleneck.

## Models to generate (in order)

1. `ExerciseModel` — id, name, muscleGroup, equipment, isCustom, createdBy, isDeleted, description
2. `SetModel` — weight, reps, isCompleted, estimatedOneRM
3. `ExerciseInWorkoutModel` — exerciseId, exerciseName, order, sets: List<SetModel>
4. `WorkoutModel` — id, name, startedAt, finishedAt, duration, totalVolume, notes, exercises: List<ExerciseInWorkoutModel>
5. `PersonalRecordModel` — exerciseId, estimatedOneRM, weight, reps, workoutId, updatedAt
6. `UserProfileModel` — uid, email, name, goal (enum: strength/mass/weightLoss), age, height, weight, units (enum: kg/lbs), defaultRestTimer, soundEnabled, photoUrl, createdAt
7. `AppUser` — uid, email (auth-level model, simpler than UserProfileModel)

All Freezed, all with `fromJson`/`toJson`.

## Repositories to generate

See `/docs/decisions.md` → ADR-04 for full interface signatures.

- `IAuthRepository` + `FirebaseAuthRepository`
- `IUserRepository` + `FirebaseUserRepository`
- `IWorkoutRepository` + `FirebaseWorkoutRepository`
- `IExerciseRepository` + `FirebaseExerciseRepository`
- `IProgressRepository` + `FirebaseProgressRepository`

## Screens (14 total)

See `/docs/screens/` for per-screen specs. Order of implementation:

**Sprint 1 (Foundation):** Splash, Login, Register, app shell with BottomNav
**Sprint 3:** Exercise Library, Create/Edit Exercise, Workout Start (+ Exercise Picker sheet)
**Sprint 4:** Active Workout, Custom Numpad, Rest Timer (sheet), Finish flow
**Sprint 5:** Home, Workout History, Workout Detail, Exercise Detail, Progress, Profile
**Sprint 6:** Settings inline in Profile, animations, polish

## Active Workout — the critical screen

This is the defining UX of the app. Specific rules:

- **Custom numpad** — NEVER use stock keyboard for weight/reps. Bottom sheet with 56x56px min buttons.
- **Auto-fill sets** — new set pre-filled from same-numbered set of the last workout of this exercise. Fallback: previous set in current workout.
- **Prev column** — always visible. Shows last workout's same-numbered set.
- **PR formula** — Epley: `weight × (1 + reps / 30)`. Stored as `estimatedOneRM` on set and PR record.
- **PR detection** — at checkmark moment. Show trophy badge immediately. Show congrats sheet at Finish.
- **Rest timer** — 90s default, bottom sheet. Persists as banner if swiped down.
- **Wakelock** — on at screen enter, off at exit.
- **Firestore writes** — debounce 1 sec after last change. Never write on every keystroke.
- **Haptic** — medium for regular checkmark, heavy for PR.
- **Timer** — driven by timestamps, not counters. Rebuilds every 1s via `Timer.periodic`.

## Error handling

Sealed hierarchy in `core/errors/app_exception.dart`:
- `AppException` (base sealed class)
- `AuthException`, `NetworkException`, `ValidationException`, `NotFoundException`, `UnknownException`

Service throws Firebase exceptions. Repository catches and maps to `AppException`. Provider returns `AsyncValue<T>`. UI uses `AsyncValue.when(error: (e, _) => ...)` and `showErrorSnackBar(context, e)`.

Snackbars for transient errors (save failed). Full error widget (with Retry) for failed list loads.

## Design system

- **Dark theme default** — accent `#3B82FF`
- **Fonts** — Inter (NOT SF Pro — Apple licence does not allow Android use)
- **Icons** — Lucide (`lucide_icons` package), never Material Icons
- **Spacing** — 8-point grid: 4/8/12/16/24/32/48
- **Radii** — 8/12/16/24
- **Muscle group colors** — each of 7 groups has a color ramp (chest = blue, back = green, legs = purple, shoulders = amber, biceps = coral, triceps = teal, core = pink). Used for exercise icon circles with 2-letter labels ("Ch", "Ba", etc.).

## Offline-first

```dart
// main.dart
FirebaseFirestore.instance.settings = const Settings(
  persistenceEnabled: true,
  cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
);
```

Connectivity badge in AppBar when offline. Streams still work (from cache). Writes queue and sync when online returns. `connectivity_plus` package drives the `connectivityProvider`.

## Firebase Emulator in debug

```dart
if (kDebugMode) {
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
}
```

Start with `firebase emulators:start` before flutter run.

## Tests

Target: ~8 tests. Focus on business logic, not UI.

```
test/
├── unit/
│   ├── volume_calculator_test.dart       # weight * reps
│   ├── one_rm_calculator_test.dart       # Epley formula
│   ├── workout_model_test.dart           # fromJson/toJson roundtrip
│   ├── exercise_model_test.dart          # same
│   └── personal_record_test.dart         # PR update logic
├── widget/
│   ├── set_row_widget_test.dart          # displays weight/reps, check toggle
│   └── exercise_card_test.dart           # name and muscle group
└── integration/
    └── auth_flow_test.dart               # login → home (with emulator)
```

## CI/CD

`.github/workflows/flutter_ci.yml`:
- `flutter analyze` + `flutter test` on every push
- `flutter build apk --release` on main branch merge
- Upload APK as artifact

`google-services.json` via GitHub Secret, echoed at build time. Never committed.

## Generation order for Claude Code

When building a new feature, always generate in this order:

1. **Model** (Freezed) — verify `fromJson`/`toJson` roundtrip
2. **Repository interface** — define methods, return types
3. **Repository implementation** — Firebase calls + exception mapping
4. **Provider** — `StreamProvider` or `AsyncNotifierProvider` depending on use case
5. **Screen/Widget** — `ConsumerWidget`, use `ref.watch`
6. **Test** (if applicable) — unit test for logic

Generate one layer per prompt. Do not ask Claude to "build the whole feature". Iterate.

## Key reference files

- `/docs/decisions.md` — all ADRs (59 decisions with rationale)
- `/docs/screens/*.md` — per-screen specs (14 screens)
- `/docs/user_flow.png` — navigation diagram
- `/workout_backlog.xlsx` — product backlog with sprint assignments
- `/DEVLOG.md` — daily progress log
- `/docs/retrospectives.md` — sprint retros

## Definition of Done (from backlog)

For every story:
1. Code written and runs on emulator
2. Unit test written if applicable (business logic)
3. Committed to feature branch with conventional commit
4. Self-reviewed
5. Merged to main
6. Marked done in `workout_backlog.xlsx` (or GitHub Project)

## Non-obvious decisions (quick reference for defense questions)

- **Why Inter not SF Pro?** Apple licence prohibits SF Pro on Android.
- **Why 90s default rest?** Median of bodybuilding 60-120s range.
- **Why Epley 1RM?** Standard in fitness apps; fairly compares sets of different intensity (100×1 vs 80×10).
- **Why interfaces for repositories?** DIP (SOLID), mock-friendly for tests, one-line impl swap.
- **Why denormalize exerciseName?** Firestore has no joins; reads are the hot path.
- **Why soft delete for exercises but hard delete for workouts?** Workouts reference exercises; exercises have downstream dependencies. Workouts are self-contained.
- **Why Riverpod not Bloc?** Compile-time safety, less boilerplate, works better with Freezed.
- **Why custom numpad?** Core UX differentiator. Stock keyboard is slow in-gym.
- **Why debounce Firestore writes 1s?** Quota economy + performance. Never write on every keystroke.

---

See also: `/docs/decisions.md` for full reasoning on any decision.
