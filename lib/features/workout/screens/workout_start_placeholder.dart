import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class WorkoutStartPlaceholder extends StatelessWidget {
  const WorkoutStartPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, size: 20),
          onPressed: () => context.pop(),
          color: AppColors.textPrimary,
        ),
        title: Text('New workout', style: AppTextStyles.titleLarge),
        backgroundColor: AppColors.bgPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Center(
        child: Text(
          'Workout start — Sprint 3',
          style: AppTextStyles.bodyMedium,
        ),
      ),
    );
  }
}
