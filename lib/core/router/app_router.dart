import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_providers.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/exercises/screens/create_exercise_screen.dart';
import '../../features/exercises/screens/exercise_library_screen.dart';
import '../../features/home/screens/home_screen_placeholder.dart';
import '../../features/profile/screens/profile_screen_placeholder.dart';
import '../../features/shell/screens/main_shell.dart';
import '../../features/workout/screens/history_screen_placeholder.dart';
import '../../features/exercises/screens/exercise_detail_screen.dart';
import '../../features/workout/screens/workout_start_screen.dart';
import 'route_paths.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ValueNotifier<int>(0);

  ref.listen(authStateProvider, (prev, next) {
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

      if (!authState.hasValue && isSplash) return null;

      if (isSplash) {
        return isLoggedIn ? AppRoutes.home : AppRoutes.login;
      }

      if (!isLoggedIn && !isAuthRoute) return AppRoutes.login;

      if (isLoggedIn && isAuthRoute) return AppRoutes.home;

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
            builder: (context, state) => const ExerciseLibraryScreen(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (context, state) => const ProfileScreenPlaceholder(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.workoutStart,
        builder: (context, state) => const WorkoutStartScreen(),
      ),
      GoRoute(
        path: AppRoutes.activeWorkout,
        builder: (context, state) {
          final id = state.uri.queryParameters['id'];
          return Scaffold(
            appBar: AppBar(title: const Text('Active Workout (Sprint 4)')),
            body: Center(child: Text('Workout ID: $id')),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.createExercise,
        builder: (context, state) => CreateExerciseScreen(
          initialName: state.uri.queryParameters['name'],
        ),
      ),
      GoRoute(
        path: AppRoutes.exerciseDetail,
        builder: (context, state) => ExerciseDetailScreen(
          exerciseId: state.pathParameters['id']!,
        ),
      ),
    ],
  );
});
