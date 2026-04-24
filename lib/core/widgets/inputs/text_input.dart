import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_radii.dart';
import '../../constants/app_text_styles.dart';

class AppTextInput extends StatelessWidget {
  const AppTextInput({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.errorText,
    this.keyboardType,
    this.trailingIcon,
    this.onTrailingTap,
    this.hintText,
    this.onChanged,
    this.maxLines,
  });

  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final String? errorText;
  final TextInputType? keyboardType;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label.isNotEmpty)
          Text(
            label,
            style: AppTextStyles.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: AppColors.bgTertiary,
            borderRadius: BorderRadius.circular(AppRadii.md),
            border: hasError
                ? Border.all(color: AppColors.error, width: 1)
                : null,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: isPassword,
                  keyboardType: keyboardType,
                  maxLines: isPassword ? 1 : maxLines,
                  onChanged: onChanged,
                  style: AppTextStyles.bodyMedium,
                  cursorColor: AppColors.accentPrimary,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    hintText: hintText,
                    hintStyle: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textTertiary),
                    isDense: true,
                  ),
                ),
              ),
              if (trailingIcon != null)
                IconButton(
                  icon: Icon(
                    trailingIcon,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: onTrailingTap,
                  padding: const EdgeInsets.only(right: 8),
                ),
            ],
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style:
                AppTextStyles.bodySmall.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}
