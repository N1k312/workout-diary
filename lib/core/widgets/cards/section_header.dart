import 'package:flutter/material.dart';

import '../../constants/app_text_styles.dart';
import '../buttons/app_text_button.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.titleMedium),
        const Spacer(),
        if (actionLabel != null)
          AppTextButton(label: actionLabel!, onPressed: onActionTap),
      ],
    );
  }
}
