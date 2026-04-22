import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_model.freezed.dart';
part 'set_model.g.dart';

@freezed
abstract class SetModel with _$SetModel {
  const factory SetModel({
    required double weight,
    required int reps,
    @Default(false) bool isCompleted,
    @Default(0.0) double estimatedOneRM,
  }) = _SetModel;

  factory SetModel.fromJson(Map<String, dynamic> json) =>
      _$SetModelFromJson(json);
}

extension SetModelX on SetModel {
  /// Epley formula for estimated 1RM
  double computeOneRM() => weight * (1 + reps / 30);

  /// Volume = weight × reps
  double get volume => weight * reps;
}
