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
