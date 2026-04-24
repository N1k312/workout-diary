import 'package:flutter_test/flutter_test.dart';
import 'package:workout_diary/data/models/set_model.dart';

void main() {
  SetModel set(double weight, int reps) =>
      SetModel(weight: weight, reps: reps);

  group('Epley 1RM formula', () {
    test('1 rep gives weight × (1 + 1/30) ≈ 103.33', () {
      // Epley adds a small bonus even for 1 rep — it's an estimator, not identity
      expect(set(100, 1).computeOneRM(), closeTo(103.33, 0.01));
    });

    test('5 reps adds ~16.67% to weight', () {
      // 100 × (1 + 5/30) = 116.667
      expect(set(100, 5).computeOneRM(), closeTo(116.67, 0.01));
    });

    test('10 reps adds ~33% to weight', () {
      // 80 × (1 + 10/30) = 106.667
      expect(set(80, 10).computeOneRM(), closeTo(106.67, 0.01));
    });

    test('zero weight returns zero', () {
      expect(set(0, 5).computeOneRM(), closeTo(0.0, 0.01));
    });

    test('high reps are handled correctly', () {
      // 50 × (1 + 20/30) = 83.333
      expect(set(50, 20).computeOneRM(), closeTo(83.33, 0.01));
    });
  });
}
