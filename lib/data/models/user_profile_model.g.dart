// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    _UserProfileModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      goal: $enumDecodeNullable(_$GoalEnumMap, json['goal']),
      age: (json['age'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      units: $enumDecodeNullable(_$UnitsEnumMap, json['units']) ?? Units.kg,
      defaultRestTimer: (json['defaultRestTimer'] as num?)?.toInt() ?? 90,
      soundEnabled: json['soundEnabled'] as bool? ?? false,
      photoUrl: json['photoUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$UserProfileModelToJson(_UserProfileModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'goal': _$GoalEnumMap[instance.goal],
      'age': instance.age,
      'height': instance.height,
      'weight': instance.weight,
      'units': _$UnitsEnumMap[instance.units]!,
      'defaultRestTimer': instance.defaultRestTimer,
      'soundEnabled': instance.soundEnabled,
      'photoUrl': instance.photoUrl,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$GoalEnumMap = {
  Goal.strength: 'strength',
  Goal.hypertrophy: 'hypertrophy',
  Goal.weightLoss: 'weightLoss',
  Goal.general: 'general',
};

const _$UnitsEnumMap = {Units.kg: 'kg', Units.lbs: 'lbs'};
