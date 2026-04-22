import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_record_model.freezed.dart';
part 'personal_record_model.g.dart';

@freezed
abstract class PersonalRecordModel with _$PersonalRecordModel {
  const factory PersonalRecordModel({
    required String exerciseId,
    required double estimatedOneRM,
    required double weight,
    required int reps,
    required String workoutId,
    required DateTime updatedAt,
  }) = _PersonalRecordModel;

  factory PersonalRecordModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalRecordModelFromJson(json);
}
