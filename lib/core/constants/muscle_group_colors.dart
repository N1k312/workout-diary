import 'package:flutter/material.dart';

import '../../data/models/enums/muscle_group.dart';
import 'app_colors.dart';

class MuscleGroupColors {
  MuscleGroupColors._();

  static Color colorFor(MuscleGroup group) {
    switch (group) {
      case MuscleGroup.chest:
        return AppColors.chest;
      case MuscleGroup.back:
        return AppColors.back;
      case MuscleGroup.legs:
        return AppColors.legs;
      case MuscleGroup.shoulders:
        return AppColors.shoulders;
      case MuscleGroup.biceps:
        return AppColors.biceps;
      case MuscleGroup.triceps:
        return AppColors.triceps;
      case MuscleGroup.core:
        return AppColors.core;
    }
  }
}
