import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_radii.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_text_styles.dart';
import '../buttons/secondary_button.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.bgTertiary,
                borderRadius: BorderRadius.circular(AppRadii.lg),
              ),
              child: const Icon(
                LucideIcons.alertCircle,
                size: 28,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Something went wrong', style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              message,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              IntrinsicWidth(
                child: SecondaryButton(
                  label: 'Retry',
                  icon: LucideIcons.refreshCw,
                  onPressed: onRetry,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
