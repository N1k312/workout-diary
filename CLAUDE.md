# Workout Diary — Context for Claude Code

Project: Flutter mobile app for tracking gym workouts.
College senior project, SE 4th year, Almaty.
Solo developer, 30-day timeline, portfolio-quality focus.

## Priority
Architecture cleanliness > feature count. This is a defense project; the examiner cares about clean layers, SOLID principles, tests, and documentation more than shipping every feature.

## Stack (actual versions — see pubspec.yaml for exact versions)

- **Flutter 3.41+** (Dart 3.11+)
- **flutter_riverpod 3.x** — state management. New API: class-based providers, `AsyncNotifier.build()` override pattern. NOT the legacy `AutoDisposeAsyncNotifierProvider` from 2.x.
- **go_router 17.x** — navigation. Uses `GoRouter` with `ShellRoute` for bottom nav.
- **firebase_core 4.x**, **firebase_auth 6.x**, **cloud_firestore 6.x** — Firebase (major version bump means breaking changes vs 5.x docs online).
- **google_sign_in 7.x** — new initialization API in 7.x. **Only Auth + Firestore used. NO Firebase Storage (requires Blaze plan, cut from MVP). NO FCM.**
- **freezed 3.x**, **json_serializable 6.x** — immutable models.
- **fl_chart 1.x** — charts (stable 1.0 API).
- **lucide_icons 0.257** — icons.
- **google_fonts** — Inter font loaded dynamically (NO assets/fonts/ needed — use `GoogleFonts.inter()` in TextTheme).
- **intl**, **wakelock_plus**, **connectivity_plus 7.x**, **package_info_plus 10.x**, **shared_preferences 2.x**.

**IMPORTANT:** If unsure about current API for any package, check `pubspec.lock` for exact version and reference the package docs on pub.dev for that version. Do NOT generate code based on tutorials/blog posts without verifying — they often reference older APIs.

## Architecture — Feature-First + 3-layer

```
lib/
├── main.dart
├── firebase_options.dart
├── core/
│   ├── constants/        # colors, text_styles, muscle_group_colors, strings
│   ├── router/           # app_router.dart (go_router config)
│   ├── theme/            # app_theme.dart
│   ├── errors/           # app_exception.dart (sealed hierarchy)
│   └── utils/            # date_formatter, volume_calculator, snackbar_helper
├── data/
│   ├── models/           # *_model.dart (Freezed classes)
│   ├── repositories/
│   │   ├── interfaces/   # i_*_repository.dart (abstract)
│   │   └── implementations/  # firebase_*_repository.dart
│   └── services/         # firestore_service, auth_service (NO storage_service — Firebase Storage not used)
└── features/
    ├── auth/
    ├── home/
    ├── workout/
    ├── exercises/
    ├── progress/
    └── profile/
```

**Strict dependency flow:** UI → Provider → Repository (interface) → Service → Firebase.
Never call Firebase or Service from UI or from another Provider directly.

## Conventions

### Naming
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Providers: `{thing}Provider`
- Notifiers: `{Thing}Notifier`
- Abstract repositories: `I{Thing}Repository` — **non-idiomatic for Dart (C# style), chosen deliberately for visual clarity in student project.**
- Firebase impls: `Firebase{Thing}Repository`

### Code style
- Comments only where logic is non-obvious. In English.
- UI strings in English, collected in `core/constants/strings.dart`.
- Hard rule: no colors hardcoded in widgets. Only via `AppColors`.
- Hard rule: no `TextStyle(fontSize: X)` inline. Only via `AppTextStyles`.
- Hard rule: no magic numbers for spacing. Use `AppSpacing` constants.
- Prefer `const` constructors everywhere possible.
- Use `AsyncValue.when` for loading/error/data, not `FutureBuilder`.
- Use `ref.watch` for reading, `ref.read(...).method()` for actions.

### Riverpod 3.x specifics
- Use class-based providers: `class WorkoutNotifier extends AsyncNotifier<Workout?>`
- For simple derived state: `final xyzProvider = Provider<Xyz>((ref) => ...)`
- For streams: `final xyzProvider = StreamProvider<List<Xyz>>((ref) => ...)`
- Avoid code generation for providers in this project (simpler without `@riverpod` annotation + build_runner). Code gen is used only for Freezed models + JSON.
- For `AsyncNotifier` in Riverpod 3.x: override `build()` not a constructor.

### go_router 17.x specifics
- `GoRouter(routes: [...], redirect: ...)` for configuration
- `context.go('/path')` for replacement, `context.push('/path')` for stack push
- `ShellRoute` for bottom navigation layout persistence
- Redirect via `redirect:` parameter for auth guards

### Anti-patterns — DO NOT
- `StatefulWidget` when Riverpod works (rare exception: local controllers like `TextEditingController`).
- `setState` alongside Riverpod. Pick one.
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
- Merge to `main` via PR (self-PR for this project)

### Commits (Conventional Commits)
```
feat: add workout creation flow
fix: restore unfinished workout on app start
refactor: extract exercise picker to shared widget
test: cover PR calculation edge cases
docs: update Firestore schema
chore: bump flutter_riverpod
```

## Firestore schema

```
users/{userId}
  email, name, goal, age, height, weight, units (kg/lbs),
  defaultRestTimer (seconds), soundEnabled,
  photoUrl       // RESERVED: field nullable, never populated in MVP (photo cut)
  createdAt
  
  workouts/{workoutId}
    name, startedAt, finishedAt (null if active),
    duration       // PRECOMPUTED on finish (seconds)
    totalVolume    // PRECOMPUTED on finish (sum of weight × reps across all completed sets)
    notes          // RESERVED: nullable, no UI in MVP (notes cut)
    exercises: [{
      exerciseId, exerciseName (denormalized), order,
      sets: [{ weight, reps, isCompleted, estimatedOneRM }]
    }]
  
  personalRecords/{exerciseId}
    estimatedOneRM, weight, reps, workoutId, updatedAt

exercises/{exerciseId}   # global, read-all, write-own-custom
  name, muscleGroup (enum), equipment (enum), isCustom, createdBy, isDeleted, description
```

### Key rules
- **Denormalization:** `exerciseName` duplicated inside workout documents. Never join. Firestore has no joins; reads are the hot path.
- **Precomputation:** `duration` and `totalVolume` computed on Workout.finish() and stored. Workouts list (History) reads them directly — no runtime recompute.
- **Reserved fields:** `photoUrl`, `notes` — nullable, forward-compat, no UI in MVP.
- **Rest timer:** single user-level `defaultRestTimer` in UserProfile. **No per-exercise override in MVP** (simpler, can add later as stretch).

## Models to generate (in order)

1. `ExerciseModel` — id, name, muscleGroup (enum), equipment (enum), isCustom, createdBy, isDeleted, description
2. `SetModel` — weight, reps, isCompleted, estimatedOneRM
3. `ExerciseInWorkoutModel` — exerciseId, exerciseName, order, sets: List<SetModel>
4. `WorkoutModel` — id, name, startedAt, finishedAt, duration, totalVolume, notes, exercises
5. `PersonalRecordModel` — exerciseId, estimatedOneRM, weight, reps, workoutId, updatedAt
6. `UserProfileModel` — uid, email, name, goal (enum), age, height, weight, units (enum), defaultRestTimer, soundEnabled, photoUrl, createdAt
7. `AppUser` — uid, email only (lightweight Firebase Auth representation)

### AppUser vs UserProfileModel — when to use each

**`AppUser`** (lightweight, from Firebase Auth):
- Source: `FirebaseAuth.instance.currentUser`
- Used in: auth state stream, auth guards (router redirect), login/register flows
- Contains: just `uid` + `email` (plus any auth metadata)
- Null if not logged in

**`UserProfileModel`** (full, from Firestore):
- Source: `users/{uid}` document
- Used in: Profile screen, settings, Home greeting ("Hi, {name}!")
- Contains: display name, goal, settings, etc.
- Can be null even if AppUser exists (right after registration, before profile created)

**Creation flow:** Register → Firebase Auth creates user → immediately write `users/{uid}` document via batch write → UserProfileModel exists.

All Freezed 3.x, all with `fromJson`/`toJson`.

## Repositories to generate

See `/docs/decisions.md` → ADR-04 for full interface signatures.

- `IAuthRepository` + `FirebaseAuthRepository` — only Auth (no Storage)
- `IUserRepository` + `FirebaseUserRepository`
- `IWorkoutRepository` + `FirebaseWorkoutRepository`
- `IExerciseRepository` + `FirebaseExerciseRepository`
- `IProgressRepository` + `FirebaseProgressRepository`

## Screens (14 total)

See `/docs/decisions.md` for per-screen specs (ADR-36 to ADR-57). Order of implementation:

- **Sprint 1 (Foundation):** app scaffolding, theme, router, Splash, Login, Register, Bottom Nav
- **Sprint 2 (Core infra):** toast, empty state, connectivity badge, models, repositories
- **Sprint 3:** Exercise Library, Create/Edit Exercise, Workout Start, Exercise Picker
- **Sprint 4:** Active Workout, Custom Numpad, Rest Timer, Finish flow — the critical sprint
- **Sprint 5:** Home, Workout History, Workout Detail, Exercise Detail, Progress, Profile
- **Sprint 6:** Settings, animations, haptic, polish

**Note:** `Home` is not a single user story but an aggregation screen composed of: greeting (from UserProfile), weekly stats (from workouts), last workout card, recent PRs carousel, Start workout CTA. Built in Sprint 5 when its constituent data sources (workouts, PRs, profile) are ready.

## Active Workout — the critical screen

Defining UX of the app. Rules:

- Custom numpad — NEVER use stock keyboard for weight/reps. Bottom sheet with 56x56px min buttons.
- Auto-fill sets — new set pre-filled from same-numbered set of last workout of this exercise. Fallback: previous set in current workout.
- Prev column — always visible. Shows last workout's same-numbered set.
- PR formula — Epley: `weight × (1 + reps / 30)`. Stored as `estimatedOneRM`.
- PR detection — at checkmark moment. Show trophy badge immediately. Congrats sheet at Finish.
- Rest timer — **single user default (90s), configurable in Profile**. No per-exercise override.
- Wakelock — on at screen enter, off at exit.
- Firestore writes — debounce 1 sec after last change.
- Haptic — medium for regular checkmark, heavy for PR.
- Timer — driven by timestamps, not counters. Rebuilds every 1s via `Timer.periodic`.
- On Finish — compute `totalVolume` and `duration`, write to Firestore in one batch along with PR updates.

## Error handling

Sealed hierarchy in `core/errors/app_exception.dart`:
- `AppException` (sealed base)
- `AuthException`, `NetworkException`, `ValidationException`, `NotFoundException`, `UnknownException`

Service throws Firebase exceptions → Repository catches → maps to AppException → Provider returns `AsyncValue<T>` → UI uses `AsyncValue.when(error: ...)` and `showErrorSnackBar(context, e)`.

SnackBars for transient errors (save failed). Full error widget (with Retry) for failed list loads.

## Design system

- Dark theme default. Accent `#3B82FF`.
- Font — Inter via `google_fonts`: `GoogleFonts.interTextTheme(...)` in ThemeData.
- Icons — Lucide (`lucide_icons`), never Material Icons.
- Spacing — 8-point grid: 4/8/12/16/24/32/48.
- Radii — 8/12/16/24.
- Muscle group colors (enum values lowercase, display labels 2 chars):
  - `chest` → `#3B82FF` / "Ch"
  - `back` → `#10B981` / "Ba"
  - `legs` → `#8B5CF6` / "Le"
  - `shoulders` → `#F59E0B` / "Sh"
  - `biceps` → `#F97316` / "Bi"
  - `triceps` → `#14B8A6` / "Tr"
  - `core` → `#EC4899` / "Co"

## Offline-first

```dart
// main.dart
FirebaseFirestore.instance.settings = const Settings(
  persistenceEnabled: true,
  cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
);
```

Connectivity badge in AppBar when offline. Streams work from cache. Writes queue and sync on reconnect. `connectivity_plus` drives `connectivityProvider`.

## Firebase Emulator in debug

```dart
if (kDebugMode) {
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
}
```

Start with `firebase emulators:start` before flutter run. **Only Auth + Firestore emulators used.**

## Tests

Target: ~8 tests. Focus on business logic, not UI.

```
test/
├── unit/
│   ├── one_rm_calculator_test.dart       # Epley formula
│   ├── volume_calculator_test.dart
│   ├── workout_model_test.dart           # fromJson/toJson roundtrip
│   ├── exercise_model_test.dart
│   └── personal_record_test.dart         # PR update logic
├── widget/
│   ├── set_row_widget_test.dart
│   └── exercise_card_test.dart
└── integration/
    └── auth_flow_test.dart               # login → home (with emulator)
```

Mocking: `mocktail` package (add when needed).

## CI/CD

`.github/workflows/flutter_ci.yml` (add in Sprint 6):
- `flutter analyze` + `flutter test` on every push
- `flutter build apk --release` on main branch merge
- Upload APK as artifact

`google-services.json` via GitHub Secret, echoed at build time.

## Generation order for Claude Code

When building a new feature, always generate in this order:

1. Model (Freezed) — verify `fromJson`/`toJson` roundtrip
2. Repository interface — define methods, return types
3. Repository implementation — Firebase calls + exception mapping
4. Provider — `StreamProvider` or `AsyncNotifierProvider` depending on use case
5. Screen/Widget — `ConsumerWidget`, use `ref.watch`
6. Test (if applicable) — unit test for logic

Generate one layer per prompt. Do not build "the whole feature" at once. Iterate.

## Key reference files

- `/docs/decisions.md` — all 59 ADRs (source of truth for any design question)
- `/workout_backlog.xlsx` — product backlog with sprint assignments
- `/DEVLOG.md` — daily progress log (to create)
- `/pubspec.yaml` — exact package versions (trust this over versions mentioned here)

## Definition of Done

1. Code written and runs on emulator
2. Unit test written if applicable (business logic)
3. Committed to feature branch with conventional commit
4. Self-reviewed
5. Merged to main
6. Marked done in `workout_backlog.xlsx`

## Non-obvious decisions (quick reference for defense questions)

- Why Inter not SF Pro? Apple licence prohibits SF Pro on Android.
- Why Riverpod 3.x? Compile-time safety, less boilerplate, better Freezed compat than Bloc.
- Why go_router over Navigator 2.0? Declarative, type-safe, redirect logic for auth guards.
- Why 90s default rest? Median of bodybuilding 60-120s range.
- Why no per-exercise rest timer override? Simplicity for MVP; rest timer is one value in user profile. Advanced setting can be added later.
- Why Epley 1RM? Industry standard; fairly compares sets of different intensity (100×1 vs 80×10).
- Why interfaces for repositories? DIP (SOLID), mock-friendly for tests, one-line impl swap.
- Why denormalize exerciseName? Firestore has no joins; reads are the hot path.
- Why precompute totalVolume/duration? History list reads should not trigger recalculation. Written once on Finish.
- Why soft delete for exercises but hard delete for workouts? Workouts reference exercises (downstream deps). Workouts are self-contained.
- Why custom numpad? Core UX differentiator. Stock keyboard is slow in-gym.
- Why debounce Firestore writes 1s? Quota economy + performance.
- Why no Firebase Storage? Requires Blaze (paid) plan. Photo profile cut from MVP to stay on free Spark plan.
- Why no FCM / push notifications? Avoid Cloud Functions setup. Rest timer uses local notifications via `flutter_local_notifications` instead (add in Sprint 4 if needed).
- Why I-prefix for interfaces (non-Dart-idiomatic)? Visual clarity for student project; deliberate trade-off of idiom for readability.

---

When in doubt on any decision, see `/docs/decisions.md` for full reasoning on 59 ADRs.
