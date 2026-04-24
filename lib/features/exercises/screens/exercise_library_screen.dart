import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radii.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/widgets/inputs/text_input.dart';
import '../../../core/widgets/states/empty_state.dart';
import '../../../core/widgets/states/error_state.dart';
import '../../../data/models/enums/muscle_group.dart';
import '../providers/exercise_filter_state.dart';
import '../providers/exercise_providers.dart';
import '../widgets/exercise_card.dart';

class ExerciseLibraryScreen extends ConsumerStatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  ConsumerState<ExerciseLibraryScreen> createState() =>
      _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState
    extends ConsumerState<ExerciseLibraryScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(exerciseFilterProvider);

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildSearchAndFilter(filter),
            Expanded(child: _buildBody(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.base,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Text('Exercises', style: AppTextStyles.titleLarge),
              const Spacer(),
              GestureDetector(
                onTap: () => context.push(AppRoutes.createExercise),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.bgTertiary,
                    borderRadius: BorderRadius.circular(AppRadii.pill),
                  ),
                  child: const Icon(
                    LucideIcons.plus,
                    size: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 0.5,
          thickness: 0.5,
          color: AppColors.borderDefault,
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter(ExerciseFilterState filterState) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        children: [
          AppTextInput(
            label: '',
            hintText: 'Search exercises…',
            controller: _searchController,
            onChanged: (v) =>
                ref.read(exerciseFilterProvider.notifier).setSearchQuery(v),
            trailingIcon: _searchController.text.isEmpty
                ? LucideIcons.search
                : LucideIcons.x,
            onTrailingTap: _searchController.text.isEmpty
                ? null
                : () {
                    _searchController.clear();
                    ref
                        .read(exerciseFilterProvider.notifier)
                        .setSearchQuery('');
                  },
          ),
          const SizedBox(height: AppSpacing.sm),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChip(
                  label: 'All',
                  selected: filterState.selectedMuscleGroup == null,
                  onTap: () => ref
                      .read(exerciseFilterProvider.notifier)
                      .setMuscleGroup(null),
                ),
                const SizedBox(width: AppSpacing.xs),
                ...MuscleGroup.values.map((group) {
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.xs),
                    child: _FilterChip(
                      label: group.displayName,
                      selected: filterState.selectedMuscleGroup == group,
                      onTap: () => ref
                          .read(exerciseFilterProvider.notifier)
                          .setMuscleGroup(group),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ref.watch(groupedExercisesProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.accentPrimary),
          ),
          error: (e, _) => ErrorState(
            message: e.toString(),
            onRetry: () => ref.invalidate(allExercisesProvider),
          ),
          data: (grouped) {
            if (grouped.isEmpty) return _buildEmptyState(context);
            return ListView.builder(
              padding: const EdgeInsets.only(
                left: AppSpacing.base,
                right: AppSpacing.base,
                bottom: AppSpacing.xxl,
              ),
              itemCount: MuscleGroup.values.length,
              itemBuilder: (context, index) {
                final group = MuscleGroup.values[index];
                final list = grouped[group];
                if (list == null || list.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Text(group.displayName, style: AppTextStyles.titleMedium),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          '· ${list.length}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ...list.map(
                      (ex) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: ExerciseCard(exercise: ex, onTap: null),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
  }

  Widget _buildEmptyState(BuildContext context) {
    final filter = ref.read(exerciseFilterProvider);
    final query = filter.searchQuery;

    if (query.isNotEmpty) {
      return EmptyState(
        icon: LucideIcons.searchX,
        title: 'No exercises found',
        subtitle: 'Try a different search',
        actionLabel: 'Create "$query"',
        onAction: () => context.push(
          '${AppRoutes.createExercise}?name=${Uri.encodeComponent(query)}',
        ),
      );
    }

    if (filter.selectedMuscleGroup != null) {
      return const EmptyState(
        icon: LucideIcons.dumbbell,
        title: 'No exercises in this group',
      );
    }

    return const EmptyState(
      icon: LucideIcons.dumbbell,
      title: 'No exercises yet',
      subtitle: 'Add your first custom exercise',
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentPrimary : Colors.transparent,
          border: selected
              ? null
              : Border.all(color: AppColors.borderDefault, width: 0.5),
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: selected ? AppColors.textOnAccent : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
