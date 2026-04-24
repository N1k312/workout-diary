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
