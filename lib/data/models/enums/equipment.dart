enum Equipment {
  barbell,
  dumbbell,
  machine,
  bodyweight,
  cable,
  kettlebell,
  other;

  String get displayName {
    switch (this) {
      case Equipment.barbell:
        return 'Barbell';
      case Equipment.dumbbell:
        return 'Dumbbell';
      case Equipment.machine:
        return 'Machine';
      case Equipment.bodyweight:
        return 'Bodyweight';
      case Equipment.cable:
        return 'Cable';
      case Equipment.kettlebell:
        return 'Kettlebell';
      case Equipment.other:
        return 'Other';
    }
  }
}
