import 'package:flutter/material.dart';

import '../../../data/models/enums/muscle_group.dart';
import '../../constants/muscle_group_colors.dart';

class MuscleGroupBadge extends StatelessWidget {
  const MuscleGroupBadge({
    super.key,
    required this.muscleGroup,
    this.size = 32,
  });

  final MuscleGroup muscleGroup;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = MuscleGroupColors.colorFor(muscleGroup);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(size * 0.25),
      ),
      alignment: Alignment.center,
      child: Text(
        muscleGroup.shortLabel,
        style: TextStyle(
          fontSize: size * 0.33,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}
