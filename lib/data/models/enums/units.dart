enum Units {
  kg,
  lbs;

  String get displayName {
    switch (this) {
      case Units.kg:
        return 'kg';
      case Units.lbs:
        return 'lbs';
    }
  }
}
