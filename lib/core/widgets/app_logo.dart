import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    final s = size / 96;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.accentPrimary,
        borderRadius: BorderRadius.circular(size * 0.25),
      ),
      child: Stack(
        children: [
          _bar(left: 30 * s, top: 43 * s, width: 36 * s, height: 10 * s),
          _bar(left: 18 * s, top: 28 * s, width: 10 * s, height: 40 * s),
          _bar(left: 28 * s, top: 34 * s, width: 8 * s, height: 28 * s),
          _bar(left: 58 * s, top: 34 * s, width: 8 * s, height: 28 * s),
          _bar(left: 68 * s, top: 28 * s, width: 10 * s, height: 40 * s),
        ],
      ),
    );
  }

  Widget _bar({
    required double left,
    required double top,
    required double width,
    required double height,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.textPrimary,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
