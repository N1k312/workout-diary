import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radii.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/widgets/avatars/muscle_group_badge.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/inputs/text_input.dart';
import '../../../core/widgets/states/empty_state.dart';
import '../../../core/widgets/states/error_state.dart';
import '../../../data/models/enums/muscle_group.dart';
import '../../../data/models/exercise_model.dart';
import '../../exercises/providers/exercise_providers.dart';

class ExercisePickerSheet extends ConsumerStatefulWidget {
  const ExercisePickerSheet({super.key, required this.alreadySelectedIds});

  final List<String> alreadySelectedIds;

  @override
  ConsumerState<ExercisePickerSheet> createState() =>
      _ExercisePickerSheetState();
}

class _ExercisePickerSheetState extends ConsumerState<ExercisePickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  MuscleGroup? _selectedMuscleGroup;
  late Set<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = Set<String>.from(widget.alreadySelectedIds);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.85,
      decoration: const BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadii.xl),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.md),
          _buildDragHandle(),
          const SizedBox(height: AppSpacing.md),
          _buildHeader(),
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
            child: Column(
              children: [
                AppTextInput(
                  label: '',
                  hintText: 'Search…',
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: AppSpacing.sm),
                _buildFilterChips(),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(child: _buildList()),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 32,
        height: 3,
        decoration: BoxDecoration(
          color: AppColors.bgTertiary,
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
      child: Row(
        children: [
          Text('Add exercises', style: AppTextStyles.titleMedium),
          const Spacer(),
          Text(
            '${_selectedIds.length} selected',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(
            label: 'All',
            selected: _selectedMuscleGroup == null,
            onTap: () => setState(() => _selectedMuscleGroup = null),
          ),
          const SizedBox(width: AppSpacing.xs),
          ...MuscleGroup.values.map((group) => Padding(
                padding: const EdgeInsets.only(right: AppSpacing.xs),
                child: _FilterChip(
                  label: group.displayName,
                  selected: _selectedMuscleGroup == group,
                  onTap: () => setState(() => _selectedMuscleGroup = group),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildList() {
    return Consumer(
      builder: (context, ref, _) {
        return ref.watch(allExercisesProvider).when(
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: AppColors.accentPrimary,
                ),
              ),
              error: (e, _) => ErrorState(
                message: e.toString(),
                onRetry: () => ref.invalidate(allExercisesProvider),
              ),
              data: (list) {
                Iterable<ExerciseModel> filtered = list;
                if (_selectedMuscleGroup != null) {
                  filtered = filtered.where(
                    (e) => e.muscleGroup == _selectedMuscleGroup,
                  );
                }
                final query = _searchController.text.trim().toLowerCase();
                if (query.isNotEmpty) {
                  filtered = filtered.where(
                    (e) => e.name.toLowerCase().contains(query),
                  );
                }
                final items = filtered.toList()
                  ..sort((a, b) => a.name.compareTo(b.name));

                if (items.isEmpty) {
                  return EmptyState(
                    icon: LucideIcons.searchX,
                    title: 'No exercises found',
                    subtitle: query.isEmpty ? 'Try different filters' : null,
                    actionLabel:
                        query.isNotEmpty ? 'Create "$query"' : null,
                    onAction: query.isNotEmpty
                        ? () {
                            Navigator.pop(context);
                            context.push(
                              '${AppRoutes.createExercise}?name=${Uri.encodeComponent(query)}',
                            );
                          }
                        : null,
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.base,
                  ),
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    final ex = items[i];
                    return _buildExerciseRow(ex, _selectedIds.contains(ex.id));
                  },
                );
              },
            );
      },
    );
  }

  Widget _buildExerciseRow(ExerciseModel ex, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedIds.remove(ex.id);
          } else {
            _selectedIds.add(ex.id);
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentPrimary.withValues(alpha: 0.1)
              : AppColors.bgTertiary,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: isSelected
              ? Border.all(color: AppColors.accentPrimary, width: 0.5)
              : null,
        ),
        child: Row(
          children: [
            MuscleGroupBadge(muscleGroup: ex.muscleGroup, size: 32),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ex.name,
                    style: AppTextStyles.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    ex.equipment.displayName,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            _buildSelectionIndicator(isSelected),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionIndicator(bool isSelected) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.accentPrimary : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: isSelected
            ? null
            : Border.all(color: AppColors.borderDefault, width: 1.5),
      ),
      child: isSelected
          ? const Icon(
              LucideIcons.check,
              size: 12,
              color: AppColors.textOnAccent,
            )
          : null,
    );
  }

  Widget _buildBottomBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 0.5, thickness: 0.5, color: AppColors.borderDefault),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.base),
          child: PrimaryButton(
            label: _selectedIds.isEmpty
                ? 'Add exercises'
                : 'Add ${_selectedIds.length} exercise${_selectedIds.length == 1 ? '' : 's'}',
            onPressed: _selectedIds.isEmpty ? null : _handleAdd,
          ),
        ),
      ],
    );
  }

  void _handleAdd() {
    final allExercises =
        ref.read(allExercisesProvider).asData?.value ?? <ExerciseModel>[];
    final selected =
        allExercises.where((e) => _selectedIds.contains(e.id)).toList();

    selected.sort((a, b) {
      final ai = widget.alreadySelectedIds.indexOf(a.id);
      final bi = widget.alreadySelectedIds.indexOf(b.id);
      if (ai == -1 && bi == -1) return 0;
      if (ai == -1) return 1;
      if (bi == -1) return -1;
      return ai.compareTo(bi);
    });

    Navigator.pop(context, selected);
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
            color:
                selected ? AppColors.textOnAccent : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
