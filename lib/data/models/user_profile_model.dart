import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/goal.dart';
import 'enums/units.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
abstract class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    required String uid,
    required String email,
    String? name,
    Goal? goal,
    int? age,
    double? height,
    double? weight,
    @Default(Units.kg) Units units,
    @Default(90) int defaultRestTimer,
    @Default(false) bool soundEnabled,
    String? photoUrl,
    required DateTime createdAt,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  factory UserProfileModel.initial({
    required String uid,
    required String email,
  }) {
    return UserProfileModel(
      uid: uid,
      email: email,
      createdAt: DateTime.now(),
    );
  }
}
