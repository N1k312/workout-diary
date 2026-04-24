import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radii.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/snackbar_helper.dart';
import '../../../core/widgets/buttons/app_text_button.dart';
import '../../../core/widgets/inputs/text_input.dart';
import '../../../data/models/enums/equipment.dart';
import '../../../data/models/enums/muscle_group.dart';
import '../../../core/widgets/avatars/muscle_group_badge.dart';
import '../providers/create_exercise_notifier.dart';

class CreateExerciseScreen extends ConsumerStatefulWidget {
  const CreateExerciseScreen({super.key, this.initialName});

  final String? initialName;

  @override
  ConsumerState<CreateExerciseScreen> createState() =>
      _CreateExerciseScreenState();
}

class _CreateExerciseScreenState extends ConsumerState<CreateExerciseScreen> {
  late final TextEditingController _nameController;
  final TextEditingController _descriptionController = TextEditingController();

  MuscleGroup? _selectedMuscleGroup;
  Equipment? _selectedEquipment;
  String? _nameError;
  String? _groupError;
  String? _equipmentError;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.initialName ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(createExerciseNotifierProvider, (prev, next) {
      if (next.hasError) {
        showErrorSnackBar(context, next.error.toString());
      }
    });

    final isLoading =
        ref.watch(createExerciseNotifierProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.base),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context, isLoading),
              const SizedBox(height: AppSpacing.xl),
              _buildNameField(),
              const SizedBox(height: AppSpacing.base),
              _buildMuscleGroupPicker(),
              const SizedBox(height: AppSpacing.base),
              _buildEquipmentPicker(),
              const SizedBox(height: AppSpacing.base),
              _buildDescriptionField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, bool isLoading) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            LucideIcons.x,
            size: 16,
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Text('New exercise', style: AppTextStyles.titleMedium),
        const Spacer(),
        AppTextButton(
          label: 'Save',
          onPressed: isLoading ? null : _handleSave,
          color: AppColors.accentPrimary,
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Name',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: _nameController,
              builder: (context, value, child) => Text(
                '${_nameController.text.length}/50',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        AppTextInput(
          label: '',
          controller: _nameController,
          hintText: 'e.g., Bench Press',
          errorText: _nameError,
          onChanged: (_) => setState(() {}),
        ),
      ],
    );
  }

  Widget _buildMuscleGroupPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Muscle group',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _openMuscleGroupPicker,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.bgTertiary,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: Row(
              children: [
                if (_selectedMuscleGroup != null) ...[
                  MuscleGroupBadge(
                    muscleGroup: _selectedMuscleGroup!,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Text(
                  _selectedMuscleGroup?.displayName ?? 'Select muscle group',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: _selectedMuscleGroup != null
                        ? AppColors.textPrimary
                        : AppColors.textTertiary,
                  ),
                ),
                const Spacer(),
                const Icon(
                  LucideIcons.chevronDown,
                  size: 12,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (_groupError != null) ...[
          const SizedBox(height: 4),
          Text(
            _groupError!,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }

  Widget _buildEquipmentPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Equipment',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _openEquipmentPicker,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.bgTertiary,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: Row(
              children: [
                Text(
                  _selectedEquipment?.displayName ?? 'Select equipment',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: _selectedEquipment != null
                        ? AppColors.textPrimary
                        : AppColors.textTertiary,
                  ),
                ),
                const Spacer(),
                const Icon(
                  LucideIcons.chevronDown,
                  size: 12,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (_equipmentError != null) ...[
          const SizedBox(height: 4),
          Text(
            _equipmentError!,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Description (optional)',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: _descriptionController,
              builder: (context, value, child) => Text(
                '${_descriptionController.text.length}/500',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        AppTextInput(
          label: '',
          controller: _descriptionController,
          hintText: 'Describe the technique…',
          maxLines: 5,
        ),
      ],
    );
  }

  void _openMuscleGroupPicker() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _PickerSheet(
        title: 'Select muscle group',
        children: MuscleGroup.values.map((group) {
          final isSelected = _selectedMuscleGroup == group;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedMuscleGroup = group);
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  MuscleGroupBadge(muscleGroup: group, size: 28),
                  const SizedBox(width: AppSpacing.md),
                  Text(group.displayName, style: AppTextStyles.bodyMedium),
                  const Spacer(),
                  if (isSelected)
                    const Icon(
                      LucideIcons.check,
                      size: 16,
                      color: AppColors.accentPrimary,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _openEquipmentPicker() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _PickerSheet(
        title: 'Select equipment',
        children: Equipment.values.map((eq) {
          final isSelected = _selectedEquipment == eq;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedEquipment = eq);
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Text(eq.displayName, style: AppTextStyles.bodyMedium),
                  const Spacer(),
                  if (isSelected)
                    const Icon(
                      LucideIcons.check,
                      size: 16,
                      color: AppColors.accentPrimary,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _handleSave() async {
    final name = _nameController.text.trim();
    setState(() {
      _nameError = name.isEmpty
          ? 'Name is required'
          : name.length > 50
              ? 'Name too long'
              : null;
      _groupError =
          _selectedMuscleGroup == null ? 'Select muscle group' : null;
      _equipmentError =
          _selectedEquipment == null ? 'Select equipment' : null;
    });

    if (_nameError != null || _groupError != null || _equipmentError != null) {
      return;
    }

    final result = await ref
        .read(createExerciseNotifierProvider.notifier)
        .create(
          name: name,
          muscleGroup: _selectedMuscleGroup!,
          equipment: _selectedEquipment!,
          description: _descriptionController.text,
        );

    if (result != null && mounted) {
      showSuccessSnackBar(context, '${result.name} added');
      context.pop();
    }
  }
}

class _PickerSheet extends StatelessWidget {
  const _PickerSheet({required this.title, required this.children});

  final String title;
  final List<Widget> children;

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
          Text(title, style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.base),
          ...children,
        ],
      ),
    );
  }
}
