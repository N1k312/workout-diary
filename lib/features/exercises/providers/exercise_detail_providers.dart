import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/personal_record_model.dart';
import '../../../data/providers/repository_providers.dart';
import '../../../data/repositories/interfaces/i_progress_repository.dart';
import '../../auth/providers/auth_providers.dart';

// ---------------------------------------------------------------------------
// PR for a single exercise — filtered from the all-PRs stream
// ---------------------------------------------------------------------------

final prForExerciseProvider =
    StreamProvider.family<PersonalRecordModel?, String>((ref, exerciseId) {
  final user = ref.watch(authStateProvider).asData?.value;
  if (user == null) return Stream.value(null);
  return ref
      .watch(progressRepositoryProvider)
      .watchAllPRs(userId: user.uid)
      .map((prs) => prs.where((p) => p.exerciseId == exerciseId).firstOrNull);
});

// ---------------------------------------------------------------------------
// Exercise history for chart + history list
// ---------------------------------------------------------------------------

final exerciseHistoryProvider =
    StreamProvider.family<List<ExerciseHistoryPoint>, String>((ref, exerciseId) {
  final user = ref.watch(authStateProvider).asData?.value;
  if (user == null) return Stream.value(<ExerciseHistoryPoint>[]);
  return ref.watch(progressRepositoryProvider).watchExerciseHistory(
        userId: user.uid,
        exerciseId: exerciseId,
      );
});

// ---------------------------------------------------------------------------
// Chart period filter
// ---------------------------------------------------------------------------

enum ChartPeriod {
  month,
  threeMonths,
  sixMonths,
  year,
  all;

  String get label {
    switch (this) {
      case ChartPeriod.month:
        return '1M';
      case ChartPeriod.threeMonths:
        return '3M';
      case ChartPeriod.sixMonths:
        return '6M';
      case ChartPeriod.year:
        return '1Y';
      case ChartPeriod.all:
        return 'All';
    }
  }

  Duration? get duration {
    switch (this) {
      case ChartPeriod.month:
        return const Duration(days: 30);
      case ChartPeriod.threeMonths:
        return const Duration(days: 90);
      case ChartPeriod.sixMonths:
        return const Duration(days: 180);
      case ChartPeriod.year:
        return const Duration(days: 365);
      case ChartPeriod.all:
        return null;
    }
  }
}

// Auto-dispose so the selected period resets whenever the user leaves the screen.
class ChartPeriodNotifier extends Notifier<ChartPeriod> {
  @override
  ChartPeriod build() => ChartPeriod.threeMonths;

  void select(ChartPeriod period) => state = period;
}

final chartPeriodProvider = NotifierProvider.autoDispose
    .family<ChartPeriodNotifier, ChartPeriod, String>(
  // arg scopes the provider per exercise; notifier itself doesn't need it
  (exerciseId) => ChartPeriodNotifier(),
);
