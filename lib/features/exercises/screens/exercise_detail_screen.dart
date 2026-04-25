import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radii.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/avatars/muscle_group_badge.dart';
import '../../../core/widgets/states/empty_state.dart';
import '../../../core/widgets/states/error_state.dart';
import '../../../data/repositories/interfaces/i_progress_repository.dart';
import '../providers/exercise_detail_providers.dart';
import '../providers/exercise_providers.dart';

class ExerciseDetailScreen extends ConsumerWidget {
  const ExerciseDetailScreen({super.key, required this.exerciseId});

  final String exerciseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseAsync = ref.watch(exerciseByIdProvider(exerciseId));
    final prAsync = ref.watch(prForExerciseProvider(exerciseId));
    final historyAsync = ref.watch(exerciseHistoryProvider(exerciseId));
    final period = ref.watch(chartPeriodProvider(exerciseId));

    void openPeriodPicker() {
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) => _PeriodPickerSheet(
          current: period,
          onSelected: (p) {
            ref.read(chartPeriodProvider(exerciseId).notifier).select(p);
            Navigator.pop(context);
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.base),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(
                  LucideIcons.arrowLeft,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.base),
              exerciseAsync.when(
                loading: () => const SizedBox(
                  height: 300,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accentPrimary,
                    ),
                  ),
                ),
                error: (e, _) => ErrorState(message: e.toString()),
                data: (exercise) {
                  if (exercise == null) {
                    return const EmptyState(
                      icon: LucideIcons.fileQuestion,
                      title: 'Exercise not found',
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MuscleGroupBadge(
                        muscleGroup: exercise.muscleGroup,
                        size: 56,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(exercise.name, style: AppTextStyles.headlineLarge),
                      const SizedBox(height: 4),
                      Text(
                        '${exercise.muscleGroup.displayName} · ${exercise.equipment.displayName}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (exercise.description != null &&
                          exercise.description!.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.base),
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.bgSecondary,
                            borderRadius: BorderRadius.circular(AppRadii.md),
                          ),
                          child: Text(
                            exercise.description!,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.base),
                      _buildPRCard(prAsync),
                      const SizedBox(height: AppSpacing.base),
                      _buildChartHeader(period, openPeriodPicker),
                      const SizedBox(height: AppSpacing.md),
                      _buildChart(historyAsync, period),
                      const SizedBox(height: AppSpacing.base),
                      Text('History', style: AppTextStyles.titleMedium),
                      const SizedBox(height: AppSpacing.md),
                      _buildHistory(historyAsync, prAsync),
                      const SizedBox(height: AppSpacing.xxl),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPRCard(AsyncValue<dynamic> prAsync) {
    return prAsync.when(
      loading: () => Container(
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.bgSecondary,
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
      ),
      error: (e, _) => const SizedBox.shrink(),
      data: (pr) {
        if (pr == null) {
          return Container(
            padding: const EdgeInsets.all(AppSpacing.base),
            decoration: BoxDecoration(
              color: AppColors.bgSecondary,
              borderRadius: BorderRadius.circular(AppRadii.md),
              border: Border.all(color: AppColors.borderDefault, width: 0.5),
            ),
            child: Center(
              child: Text(
                'No PR yet. Complete a set!',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          );
        }
        return Container(
          padding: const EdgeInsets.all(AppSpacing.base),
          decoration: BoxDecoration(
            color: AppColors.bgSecondary,
            borderRadius: BorderRadius.circular(AppRadii.md),
            border: Border.all(
              color: AppColors.accentPrimary.withValues(alpha: 0.3),
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    LucideIcons.trophy,
                    size: 12,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Personal record',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '${pr.weight} kg × ${pr.reps}',
                style: AppTextStyles.headlineMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                DateFormat.yMMMd().format(pr.updatedAt),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChartHeader(ChartPeriod period, VoidCallback onPickerTap) {
    return Row(
      children: [
        Text('Progress', style: AppTextStyles.titleMedium),
        const Spacer(),
        GestureDetector(
          onTap: onPickerTap,
          child: Row(
            children: [
              Text(
                period.label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                LucideIcons.chevronDown,
                size: 12,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChart(
    AsyncValue<List<ExerciseHistoryPoint>> historyAsync,
    ChartPeriod period,
  ) {
    return historyAsync.when(
      loading: () => Container(
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.bgSecondary,
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.accentPrimary),
        ),
      ),
      error: (e, _) => ErrorState(message: e.toString()),
      data: (history) {
        final cutoff = period.duration == null
            ? null
            : DateTime.now().subtract(period.duration!);
        final filtered = cutoff == null
            ? history
            : history.where((p) => p.date.isAfter(cutoff)).toList();

        if (filtered.isEmpty) {
          return Container(
            height: 150,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.bgSecondary,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: Center(
              child: Text(
                'No data for this period',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          );
        }

        return _buildLineChart(filtered);
      },
    );
  }

  Widget _buildLineChart(List<ExerciseHistoryPoint> points) {
    final maxOneRM = points.map((p) => p.estimatedOneRM).reduce(max);
    final spots = points.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.estimatedOneRM);
    }).toList();

    return Container(
      height: 180,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppColors.accentPrimary,
              barWidth: 1.5,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, bar, index) {
                  final isMax = points[index].estimatedOneRM == maxOneRM;
                  return FlDotCirclePainter(
                    radius: isMax ? 4 : 3,
                    color: isMax ? AppColors.warning : AppColors.accentPrimary,
                    strokeWidth: 0,
                    strokeColor: Colors.transparent,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistory(
    AsyncValue<List<ExerciseHistoryPoint>> historyAsync,
    AsyncValue<dynamic> prAsync,
  ) {
    return historyAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (e, _) => const SizedBox.shrink(),
      data: (history) {
        if (history.isEmpty) {
          return const EmptyState(
            icon: LucideIcons.history,
            title: 'No history yet',
          );
        }
        final prWorkoutId = prAsync.asData?.value?.workoutId as String?;
        final sorted = history.reversed.toList();
        return Column(
          children: sorted.map((point) {
            final isPR = prWorkoutId != null &&
                point.workoutId == prWorkoutId;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMd().format(point.date),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        '${point.weight} kg × ${point.reps}',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                  if (isPR) ...[
                    const SizedBox(width: AppSpacing.xs),
                    const Icon(
                      LucideIcons.trophy,
                      size: 12,
                      color: AppColors.warning,
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _PeriodPickerSheet extends StatelessWidget {
  const _PeriodPickerSheet({
    required this.current,
    required this.onSelected,
  });

  final ChartPeriod current;
  final ValueChanged<ChartPeriod> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadii.xl),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.base,
        AppSpacing.base,
        AppSpacing.base,
        AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select period', style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.base),
          ...ChartPeriod.values.map(
            (p) => GestureDetector(
              onTap: () => onSelected(p),
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Text(p.label, style: AppTextStyles.bodyMedium),
                    const Spacer(),
                    if (p == current)
                      const Icon(
                        LucideIcons.check,
                        size: 16,
                        color: AppColors.accentPrimary,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
