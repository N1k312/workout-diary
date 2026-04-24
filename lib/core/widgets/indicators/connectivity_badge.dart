import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../data/providers/connectivity_provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_radii.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_text_styles.dart';

class ConnectivityBadge extends ConsumerWidget {
  const ConnectivityBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Default to online until stream emits — avoids false offline flash on start
    final isOnline = ref.watch(connectivityProvider).asData?.value ?? true;
    if (isOnline) return const SizedBox.shrink();

    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.bgTertiary,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            LucideIcons.wifiOff,
            size: 14,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            'Offline',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
