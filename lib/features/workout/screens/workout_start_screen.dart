import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radii.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/utils/snackbar_helper.dart';
import '../widgets/exercise_picker_sheet.dart';
import '../../../core/widgets/avatars/muscle_group_badge.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/buttons/secondary_button.dart';
import '../../../core/widgets/inputs/text_input.dart';
import '../../../core/widgets/states/empty_state.dart';
import '../../../data/models/exercise_model.dart';
import '../providers/workout_providers.dart';

class WorkoutStartScreen extends ConsumerStatefulWidget {
  const WorkoutStartScreen({super.key});

  @override
  ConsumerState<WorkoutStartScreen> createState() => _WorkoutStartScreenState();
}

class _WorkoutStartScreenState extends ConsumerState<WorkoutStartScreen> {
  final _nameController = TextEditingController();
  List<ExerciseModel> _selectedExercises = [];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(workoutStartNotifierProvider, (prev, next) {
      if (next.hasError) {
        showErrorSnackBar(context, next.error.toString());
      }
    });

    final isLoading = ref.watch(workoutStartNotifierProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.base,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.base),
                    AppTextInput(
                      label: '',
                      hintText: 'Workout name',
                      controller: _nameController,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _buildExercisesHeader(),
                    const SizedBox(height: AppSpacing.md),
                    _buildExerciseList(),
                    const SizedBox(height: AppSpacing.md),
                    SecondaryButton(
                      label: 'Add exercise',
                      icon: LucideIcons.plus,
                      onPressed: _openExercisePicker,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
            _buildBottomBar(isLoading),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.base,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(
                  LucideIcons.x,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Text('New workout', style: AppTextStyles.titleMedium),
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

  Widget _buildExercisesHeader() {
    return Row(
      children: [
        Text(
          'Exercises (${_selectedExercises.length})',
          style: AppTextStyles.titleMedium,
        ),
        const Spacer(),
        GestureDetector(
          onTap: _openExercisePicker,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: AppColors.bgTertiary,
              borderRadius: BorderRadius.circular(AppRadii.pill),
            ),
            child: const Icon(
              LucideIcons.plus,
              size: 10,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExerciseList() {
    if (_selectedExercises.isEmpty) {
      return const EmptyState(
        icon: LucideIcons.dumbbell,
        title: 'No exercises',
        subtitle: 'Tap + to add exercises',
      );
    }

    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: false,
      itemCount: _selectedExercises.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) newIndex--;
          final item = _selectedExercises.removeAt(oldIndex);
          _selectedExercises.insert(newIndex, item);
        });
      },
      itemBuilder: (context, index) {
        final exercise = _selectedExercises[index];
        return _buildExerciseRow(exercise, index);
      },
    );
  }

  Widget _buildExerciseRow(ExerciseModel exercise, int index) {
    return Container(
      key: ValueKey(exercise.id),
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Row(
        children: [
          ReorderableDragStartListener(
            index: index,
            child: const Icon(
              LucideIcons.alignJustify,
              size: 12,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          MuscleGroupBadge(muscleGroup: exercise.muscleGroup, size: 24),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              exercise.name,
              style: AppTextStyles.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () => _removeExercise(exercise, index),
            child: const Icon(
              LucideIcons.x,
              size: 12,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(bool isLoading) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          height: 0.5,
          thickness: 0.5,
          color: AppColors.borderDefault,
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.base),
          child: PrimaryButton(
            label: 'Start',
            icon: LucideIcons.play,
            isLoading: isLoading,
            onPressed: _selectedExercises.isEmpty ? null : _handleStart,
          ),
        ),
      ],
    );
  }

  void _removeExercise(ExerciseModel exercise, int index) {
    setState(() => _selectedExercises.removeAt(index));
    showSuccessSnackBar(context, '${exercise.name} removed');
  }

  Future<void> _openExercisePicker() async {
    final result = await showModalBottomSheet<List<ExerciseModel>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ExercisePickerSheet(
        alreadySelectedIds: _selectedExercises.map((e) => e.id).toList(),
      ),
    );
    if (result != null) {
      setState(() => _selectedExercises = result);
    }
  }

  Future<void> _handleStart() async {
    if (_selectedExercises.isEmpty) return;
    final workout = await ref
        .read(workoutStartNotifierProvider.notifier)
        .startWorkout(
          name: _nameController.text,
          exercises: _selectedExercises,
        );
    if (workout != null && mounted) {
      context.pushReplacement(
        '${AppRoutes.activeWorkout}?id=${workout.id}',
      );
    }
  }
}
