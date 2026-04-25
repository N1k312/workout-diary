# DEVLOG

## Sprint 1 — Foundation (completed 2026-04-22)

### Delivered
- Core design system: AppColors, AppSpacing, AppRadii, AppTextStyles, AppTheme (dark, Inter via google_fonts)
- Core widgets: AppLogo, PrimaryButton, SecondaryButton, AppTextButton, GoogleButton, AppTextInput, DividerWithText
- Firebase initialized with offline persistence + emulator hooks
- go_router 17.x skeleton with ShellRoute for 5-tab bottom nav
- Auth layer: AppUser model (Freezed), AppException sealed hierarchy, ErrorMapper
- AuthService → IAuthRepository → FirebaseAuthRepository (clean boundary, no Firebase types leak to UI)
- authStateProvider (StreamProvider) + AuthNotifier (AsyncNotifier for actions)
- Login, Register screens with validation and error SnackBars
- Auth redirect logic — protected routes, auto-navigation on login/logout
- 4 placeholder screens for tabs + Workout Start
- Global tap-outside-to-dismiss-keyboard behavior

### Cut / Deferred
- Google Sign-In — cut to post-MVP (ADR-65). Too much setup overhead vs value for student defense.

### Key lessons
- Freezed 3.x requires `abstract class X with _$X` when using factory redirects
- Firebase Auth stream must be wrapped in asBroadcastStream() inside repository AND router refreshListenable must use ref.listen on the Riverpod provider, not raw stream — otherwise subscribers get out of sync (saw this with sign-out not redirecting)
- Android emulator needs 10.0.2.2 (not localhost) + network_security_config.xml allowing cleartext to that IP for Firebase emulator access
- Material TextField leaks default underline — need InputBorder.none on all three border states (enabled/focused/disabled) + isDense:true

### Start / Stop / Continue
- Start: committing smaller pieces (1 commit per step, not per feature)
- Stop: debug-first-then-code approach worked; keep it
- Continue: reading CLAUDE.md at the start of each step

### Velocity
- Planned: 13 steps / ~5h coding
- Actual: 13 steps / ~7h (emulator/network issues ate ~1.5h)

## Sprint 2 — Core Infrastructure (completed 2026-04-24)

### Delivered
- 4 enums: MuscleGroup, Equipment, Goal, Units with displayName helpers
- 6 Freezed models: SetModel, ExerciseInWorkoutModel, ExerciseModel, WorkoutModel, PersonalRecordModel, UserProfileModel (all with fromJson/toJson roundtrip)
- Helper extensions for business logic: computeOneRM (Epley), volume, totalVolume, computeTotalVolume, computeDurationSeconds
- FirestoreService — generic CRUD wrapper (setDoc, addDoc, getDoc, docStream, collectionStream, updateDoc, deleteDoc, runTransaction, batch)
- 4 repositories (interface + Firebase impl each): Exercise, Workout, User, Progress
- ProgressRepository.detectPRsInWorkout — atomic PR detection after finish
- Utility widgets: EmptyState, ErrorState, ConnectivityBadge, MuscleGroupBadge, SectionHeader, StatCard
- ConnectivityProvider (StreamProvider<bool>) with connectivity_plus
- 30 seed exercises in firebase/seed/exercises.json + bash script for emulator seeding
- 31 unit tests covering 1RM, volume, workout model, JSON serialization

### Key decisions made during sprint
- DateTime serialization left as ISO 8601 strings (not Firestore Timestamp) — simpler, Firestore SDK handles roundtrip
- Repositories throw AppException; Service layer lets FirebaseException propagate
- Exercise filtering done client-side (isDeleted, isCustom+createdBy) to avoid complex Firestore OR queries
- PR detection sequential (not batched) in detectPRsInWorkout — acceptable for MVP

### Cut / Deferred
- Mocktail-based repository tests — deferred to Sprint 6, 31 unit tests on pure logic sufficient for now

### Key lessons
- Freezed toJson() on nested models returns typed Dart objects, not plain Maps — use jsonDecode(jsonEncode(model.toJson())) for true JSON roundtrip tests
- Epley formula for 1 rep is NOT identity: 100kg × 1 rep = 103.33, not 100 — it's an estimator, not a weight lookup
- connectivity_plus 7.x onConnectivityChanged emits List<ConnectivityResult>, not a single value — check every element for ConnectivityResult.none

### Start / Stop / Continue
- Start: using FirestoreService helper — eliminates ~30% of repository boilerplate
- Stop: [your note]
- Continue: one layer per prompt (model → repo → provider), don't batch

### Metrics
- 25+ files created
- 31 unit tests passing
- flutter analyze: clean
- Estimated time: ~4.5h actual vs 5-6h planned

## Sprint 3 — Exercise Library + Workout Start (completed 2026-04-25)

### Delivered
- Exercise providers: allExercisesProvider (StreamProvider), exerciseFilterProvider (Notifier), filteredExercisesProvider (derived), groupedExercisesProvider (Map<MuscleGroup, List>), exerciseByIdProvider (family)
- Exercise Library screen — search, filter chips by muscle, grouped list, "Create '$query'" empty state shortcut
- ExerciseCard widget with muscle badge, name, equipment, Custom badge for user-created
- Create Custom Exercise screen with name validation, muscle/equipment bottom-sheet pickers, optional description
- Exercise Detail screen with PR card, fl_chart line chart with period picker (1M/3M/6M/1Y/All), history list
- Workout providers: workoutsProvider (stream), activeWorkoutProvider (future), workoutByIdProvider (family stream), WorkoutStartNotifier (AsyncNotifier)
- Workout Start screen: name input, ReorderableListView, ExerciseInWorkoutRow with drag handle and remove
- Exercise Picker bottom sheet (85% screen): search + chips + multi-select + "Create new" shortcut from empty search
- End-to-end Workout Start flow: select exercises → name → Start → Firestore document created → navigates to Active Workout placeholder

### Bugs fixed during sprint
- "Invalid argument: Instance of '_ExerciseInWorkoutModel'" on workout start — fixed by adding build.yaml with `explicit_to_json: true` so json_serializable calls `.toJson()` on nested Freezed objects instead of dumping raw Dart instances

### Key decisions made during sprint
- ChartPeriod enum lives with provider (NotifierProvider.autoDispose.family) — auto-resets on screen exit
- Chart shows estimatedOneRM (not raw weight) — better comparison across rep ranges
- Picker uses local state (not exerciseFilterProvider) — ephemeral, doesn't pollute Library filter

### Cut / Deferred
- Editing custom exercises — deferred to Sprint 6 polish
- Soft-deleting custom exercises — deferred (needs UI confirmation dialog)
- Period picker bottom sheet styling — currently functional but minimal

### Start / Stop / Continue
- Start: testing every step on emulator before commit catches integration bugs early
- Stop: skipping flutter analyze between sub-steps
- Continue: one screen per step, never two

### Metrics
- 8 new screens/widgets created
- ~20 files added to lib/features/exercises and lib/features/workout
- flutter analyze: clean
- Estimated time: ~4-5h actual
