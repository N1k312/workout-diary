import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class HistoryScreenPlaceholder extends StatelessWidget {
  const HistoryScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Center(
        child: Text('History — Sprint 5', style: AppTextStyles.bodyMedium),
      ),
    );
  }
}
