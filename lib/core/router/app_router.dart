import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_providers.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/exercises/screens/exercises_screen_placeholder.dart';
import '../../features/home/screens/home_screen_placeholder.dart';
import '../../features/profile/screens/profile_screen_placeholder.dart';
import '../../features/shell/screens/main_shell.dart';
import '../../features/workout/screens/history_screen_placeholder.dart';
import '../../features/workout/screens/workout_start_placeholder.dart';
import 'route_paths.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ValueNotifier<int>(0);

  ref.listen(authStateProvider, (prev, next) {
    debugPrint(
      '[router] authStateProvider changed: '
      'hasValue=${next.hasValue}, '
      'user=${next.asData?.value?.uid}',
    );
    notifier.value++;
  });

  ref.onDispose(notifier.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: notifier,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final currentPath = state.matchedLocation;
      final user = authState.asData?.value;
      final isLoggedIn = user != null;
      final isAuthRoute = currentPath == AppRoutes.login ||
          currentPath == AppRoutes.register;
      final isSplash = currentPath == AppRoutes.splash;

      debugPrint(
        '[router] redirect: path=$currentPath, '
        'hasValue=${authState.hasValue}, '
        'user=${user?.uid}',
      );

      // Stay on splash until we have received at least one auth event
      if (!authState.hasValue && isSplash) {
        debugPrint('[router] decision: null (waiting for auth)');
        return null;
      }

      if (isSplash) {
        final target = isLoggedIn ? AppRoutes.home : AppRoutes.login;
        debugPrint('[router] decision: $target (from splash)');
        return target;
      }

      if (!isLoggedIn && !isAuthRoute) {
        debugPrint('[router] decision: /login (not logged in)');
        return AppRoutes.login;
      }

      if (isLoggedIn && isAuthRoute) {
        debugPrint('[router] decision: /home (already logged in)');
        return AppRoutes.home;
      }

      debugPrint('[router] decision: null (stay)');
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomeScreenPlaceholder(),
          ),
          GoRoute(
            path: AppRoutes.history,
            builder: (context, state) => const HistoryScreenPlaceholder(),
          ),
          GoRoute(
            path: AppRoutes.exercises,
            builder: (context, state) => const ExercisesScreenPlaceholder(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (context, state) => const ProfileScreenPlaceholder(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.workoutStart,
        builder: (context, state) => const WorkoutStartPlaceholder(),
      ),
    ],
  );
});
