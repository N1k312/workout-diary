import 'package:flutter_test/flutter_test.dart';
import 'package:workout_diary/data/models/exercise_in_workout_model.dart';
import 'package:workout_diary/data/models/set_model.dart';

void main() {
  SetModel completedSet(double weight, int reps) =>
      SetModel(weight: weight, reps: reps, isCompleted: true);

  SetModel incompleteSet(double weight, int reps) =>
      SetModel(weight: weight, reps: reps, isCompleted: false);

  ExerciseInWorkoutModel exercise(List<SetModel> sets) =>
      ExerciseInWorkoutModel(
        exerciseId: 'ex_1',
        exerciseName: 'Test Exercise',
        order: 0,
        sets: sets,
      );

  group('SetModelX.volume', () {
    test('volume is weight × reps regardless of completion', () {
      expect(completedSet(100, 5).volume, equals(500.0));
      expect(incompleteSet(100, 5).volume, equals(500.0));
    });

    test('zero weight gives zero volume', () {
      expect(completedSet(0, 10).volume, equals(0.0));
    });
  });

  group('ExerciseInWorkoutModelX.totalVolume', () {
    test('single completed set contributes its volume', () {
      final ex = exercise([completedSet(100, 5)]);
      expect(ex.totalVolume, equals(500.0));
    });

    test('incomplete set does not count toward totalVolume', () {
      final ex = exercise([incompleteSet(100, 5)]);
      expect(ex.totalVolume, equals(0.0));
    });

    test('three completed sets are summed correctly', () {
      final ex = exercise([
        completedSet(100, 5), // 500
        completedSet(100, 5), // 500
        completedSet(100, 5), // 500
      ]);
      expect(ex.totalVolume, equals(1500.0));
    });

    test('mixed completed/incomplete: only completed count', () {
      final ex = exercise([
        completedSet(100, 5), // 500
        incompleteSet(80, 8), // not counted
        completedSet(100, 5), // 500
      ]);
      expect(ex.totalVolume, equals(1000.0));
    });

    test('empty sets list gives zero totalVolume', () {
      final ex = exercise([]);
      expect(ex.totalVolume, equals(0.0));
    });
  });

  group('ExerciseInWorkoutModelX.completedSetsCount', () {
    test('counts only completed sets', () {
      final ex = exercise([
        completedSet(100, 5),
        incompleteSet(100, 5),
        completedSet(100, 5),
      ]);
      expect(ex.completedSetsCount, equals(2));
    });

    test('returns zero when no sets completed', () {
      final ex = exercise([incompleteSet(100, 5)]);
      expect(ex.completedSetsCount, equals(0));
    });
  });
}
