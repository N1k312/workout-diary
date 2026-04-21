enum MuscleGroup {
  chest,
  back,
  legs,
  shoulders,
  biceps,
  triceps,
  core;

  String get displayName {
    switch (this) {
      case MuscleGroup.chest:
        return 'Chest';
      case MuscleGroup.back:
        return 'Back';
      case MuscleGroup.legs:
        return 'Legs';
      case MuscleGroup.shoulders:
        return 'Shoulders';
      case MuscleGroup.biceps:
        return 'Biceps';
      case MuscleGroup.triceps:
        return 'Triceps';
      case MuscleGroup.core:
        return 'Core';
    }
  }

  /// 2-letter label for exercise icon (Ch, Ba, Le, Sh, Bi, Tr, Co)
  String get shortLabel {
    switch (this) {
      case MuscleGroup.chest:
        return 'Ch';
      case MuscleGroup.back:
        return 'Ba';
      case MuscleGroup.legs:
        return 'Le';
      case MuscleGroup.shoulders:
        return 'Sh';
      case MuscleGroup.biceps:
        return 'Bi';
      case MuscleGroup.triceps:
        return 'Tr';
      case MuscleGroup.core:
        return 'Co';
    }
  }
}
