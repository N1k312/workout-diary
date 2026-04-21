import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class ExercisesScreenPlaceholder extends StatelessWidget {
  const ExercisesScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Center(
        child: Text('Exercises — Sprint 3', style: AppTextStyles.bodyMedium),
      ),
    );
  }
}
