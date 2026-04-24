import 'package:flutter_test/flutter_test.dart';
import 'package:workout_diary/data/models/exercise_in_workout_model.dart';
import 'package:workout_diary/data/models/set_model.dart';
import 'package:workout_diary/data/models/workout_model.dart';

WorkoutModel buildWorkout({
  DateTime? startedAt,
  DateTime? finishedAt,
  List<ExerciseInWorkoutModel> exercises = const [],
}) {
  return WorkoutModel(
    id: 'w1',
    name: 'Test Workout',
    startedAt: startedAt ?? DateTime(2024, 1, 1, 10, 0),
    finishedAt: finishedAt,
    exercises: exercises,
  );
}

ExerciseInWorkoutModel buildExercise(List<SetModel> sets) =>
    ExerciseInWorkoutModel(
      exerciseId: 'ex_1',
      exerciseName: 'Squat',
      order: 0,
      sets: sets,
    );

void main() {
  group('WorkoutModelX.isActive / isFinished', () {
    test('isActive is true when finishedAt is null', () {
      expect(buildWorkout().isActive, isTrue);
      expect(buildWorkout().isFinished, isFalse);
    });

    test('isFinished is true when finishedAt is set', () {
      final w = buildWorkout(finishedAt: DateTime(2024, 1, 1, 11, 0));
      expect(w.isFinished, isTrue);
      expect(w.isActive, isFalse);
    });
  });

  group('WorkoutModelX.computeDurationSeconds', () {
    test('returns seconds from startedAt to finishedAt', () {
      final start = DateTime(2024, 1, 1, 10, 0, 0);
      final end = DateTime(2024, 1, 1, 11, 30, 0); // 90 minutes = 5400s
      final w = buildWorkout(startedAt: start, finishedAt: end);
      expect(w.computeDurationSeconds(), equals(5400));
    });

    test('uses DateTime.now() when workout is still active', () {
      final start = DateTime.now().subtract(const Duration(minutes: 5));
      final w = buildWorkout(startedAt: start);
      // Should be close to 300s; give 5s tolerance for test execution time
      expect(w.computeDurationSeconds(), closeTo(300, 5));
    });
  });

  group('WorkoutModelX.computeTotalVolume', () {
    test('sums volume across all exercises (completed sets only)', () {
      final w = buildWorkout(exercises: [
        buildExercise([
          const SetModel(weight: 100, reps: 5, isCompleted: true), // 500
          const SetModel(weight: 100, reps: 5, isCompleted: true), // 500
        ]),
        buildExercise([
          const SetModel(weight: 80, reps: 8, isCompleted: true), // 640
          const SetModel(weight: 80, reps: 8, isCompleted: false), // excluded
        ]),
      ]);
      expect(w.computeTotalVolume(), equals(1640.0));
    });

    test('returns zero when no exercises', () {
      expect(buildWorkout().computeTotalVolume(), equals(0.0));
    });
  });

  group('WorkoutModelX.totalCompletedSets', () {
    test('counts completed sets across all exercises', () {
      final w = buildWorkout(exercises: [
        buildExercise([
          const SetModel(weight: 100, reps: 5, isCompleted: true),
          const SetModel(weight: 100, reps: 5, isCompleted: false),
        ]),
        buildExercise([
          const SetModel(weight: 80, reps: 8, isCompleted: true),
          const SetModel(weight: 80, reps: 8, isCompleted: true),
        ]),
      ]);
      expect(w.totalCompletedSets, equals(3));
    });

    test('returns zero when no sets completed', () {
      final w = buildWorkout(exercises: [
        buildExercise([const SetModel(weight: 100, reps: 5)]),
      ]);
      expect(w.totalCompletedSets, equals(0));
    });
  });
}
