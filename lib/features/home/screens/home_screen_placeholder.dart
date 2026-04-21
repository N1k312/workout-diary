import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/strings.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../auth/providers/auth_providers.dart';

class HomeScreenPlaceholder extends ConsumerWidget {
  const HomeScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        title: Text(AppStrings.appName, style: AppTextStyles.titleLarge),
        backgroundColor: AppColors.bgPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Home — coming in Sprint 5',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Sign out',
                onPressed: () =>
                    ref.read(authNotifierProvider.notifier).signOut(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
