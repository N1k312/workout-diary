import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class HistoryScreenPlaceholder extends StatelessWidget {
  const HistoryScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        title: Text('History', style: AppTextStyles.titleLarge),
        backgroundColor: AppColors.bgPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Center(
        child: Text('History — coming in Sprint 5', style: AppTextStyles.bodyMedium),
      ),
    );
  }
}
