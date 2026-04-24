import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:workout_diary/data/models/exercise_in_workout_model.dart';
import 'package:workout_diary/data/models/exercise_model.dart';
import 'package:workout_diary/data/models/enums/equipment.dart';
import 'package:workout_diary/data/models/enums/goal.dart';
import 'package:workout_diary/data/models/enums/units.dart';
import 'package:workout_diary/data/models/enums/muscle_group.dart';
import 'package:workout_diary/data/models/set_model.dart';
import 'package:workout_diary/data/models/user_profile_model.dart';
import 'package:workout_diary/data/models/workout_model.dart';

void main() {
  group('ExerciseModel JSON roundtrip', () {
    test('preserves all fields including enums', () {
      const original = ExerciseModel(
        id: 'bench_press',
        name: 'Bench Press',
        muscleGroup: MuscleGroup.chest,
        equipment: Equipment.barbell,
        isCustom: false,
        createdBy: null,
        isDeleted: false,
        description: 'Lie on bench, press up',
      );
      final restored = ExerciseModel.fromJson(original.toJson());
      expect(restored, equals(original));
    });

    test('nullable fields round-trip as null', () {
      const original = ExerciseModel(
        id: 'squat',
        name: 'Squat',
        muscleGroup: MuscleGroup.legs,
        equipment: Equipment.barbell,
        createdBy: null,
        description: null,
      );
      final restored = ExerciseModel.fromJson(original.toJson());
      expect(restored.createdBy, isNull);
      expect(restored.description, isNull);
    });

    test('enum serializes to name string', () {
      const model = ExerciseModel(
        id: 'x',
        name: 'X',
        muscleGroup: MuscleGroup.chest,
        equipment: Equipment.dumbbell,
      );
      final json = model.toJson();
      expect(json['muscleGroup'], equals('chest'));
      expect(json['equipment'], equals('dumbbell'));
    });

    test('all MuscleGroup values round-trip correctly', () {
      for (final mg in MuscleGroup.values) {
        final model = ExerciseModel(
          id: mg.name,
          name: mg.displayName,
          muscleGroup: mg,
          equipment: Equipment.barbell,
        );
        final restored = ExerciseModel.fromJson(model.toJson());
        expect(restored.muscleGroup, equals(mg));
      }
    });
  });

  group('SetModel JSON roundtrip', () {
    test('preserves all fields', () {
      const original = SetModel(
        weight: 100.0,
        reps: 5,
        isCompleted: true,
        estimatedOneRM: 116.67,
      );
      final restored = SetModel.fromJson(original.toJson());
      expect(restored, equals(original));
    });

    test('default values are applied when omitted', () {
      final json = {'weight': 80.0, 'reps': 8};
      final model = SetModel.fromJson(json);
      expect(model.isCompleted, isFalse);
      expect(model.estimatedOneRM, equals(0.0));
    });
  });

  group('WorkoutModel JSON roundtrip', () {
    test('preserves nested exercises and sets', () {
      final original = WorkoutModel(
        id: 'w1',
        name: 'Leg Day',
        startedAt: DateTime(2024, 3, 15, 10, 0),
        exercises: [
          const ExerciseInWorkoutModel(
            exerciseId: 'squat',
            exerciseName: 'Squat',
            order: 0,
            sets: [
              SetModel(weight: 100, reps: 5, isCompleted: true),
            ],
          ),
        ],
      );
      // jsonEncode+jsonDecode forces deep plain-Map serialization so nested
      // Freezed objects don't remain as typed instances inside the JSON map.
      final json = jsonDecode(jsonEncode(original.toJson())) as Map<String, dynamic>;
      final restored = WorkoutModel.fromJson(json);
      expect(restored, equals(original));
      expect(restored.exercises.first.sets.first.weight, equals(100.0));
    });
  });

  group('UserProfileModel JSON roundtrip', () {
    test('preserves enum fields and nullable fields', () {
      final original = UserProfileModel(
        uid: 'user_1',
        email: 'test@test.com',
        name: 'Alex',
        goal: Goal.strength,
        units: Units.kg,
        defaultRestTimer: 90,
        soundEnabled: false,
        createdAt: DateTime(2024, 1, 1),
      );
      final restored = UserProfileModel.fromJson(original.toJson());
      expect(restored, equals(original));
      expect(restored.goal, equals(Goal.strength));
      expect(restored.units, equals(Units.kg));
    });

    test('initial factory sets correct defaults', () {
      final profile = UserProfileModel.initial(
        uid: 'u1',
        email: 'a@b.com',
      );
      expect(profile.uid, equals('u1'));
      expect(profile.email, equals('a@b.com'));
      expect(profile.units, equals(Units.kg));
      expect(profile.defaultRestTimer, equals(90));
      expect(profile.soundEnabled, isFalse);
      expect(profile.name, isNull);
      expect(profile.goal, isNull);
    });
  });
}
