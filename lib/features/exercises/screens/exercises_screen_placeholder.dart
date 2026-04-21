import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class ExercisesScreenPlaceholder extends StatelessWidget {
  const ExercisesScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        title: Text('Exercises', style: AppTextStyles.titleLarge),
        backgroundColor: AppColors.bgPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Center(
        child: Text('Exercises — coming in Sprint 3', style: AppTextStyles.bodyMedium),
      ),
    );
  }
}
