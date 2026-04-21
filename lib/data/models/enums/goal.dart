enum Goal {
  strength,
  hypertrophy,
  weightLoss,
  general;

  String get displayName {
    switch (this) {
      case Goal.strength:
        return 'Strength';
      case Goal.hypertrophy:
        return 'Muscle gain';
      case Goal.weightLoss:
        return 'Weight loss';
      case Goal.general:
        return 'General fitness';
    }
  }
}
