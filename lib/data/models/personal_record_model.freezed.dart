// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersonalRecordModel {

 String get exerciseId; double get estimatedOneRM; double get weight; int get reps; String get workoutId; DateTime get updatedAt;
/// Create a copy of PersonalRecordModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalRecordModelCopyWith<PersonalRecordModel> get copyWith => _$PersonalRecordModelCopyWithImpl<PersonalRecordModel>(this as PersonalRecordModel, _$identity);

  /// Serializes this PersonalRecordModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalRecordModel&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.estimatedOneRM, estimatedOneRM) || other.estimatedOneRM == estimatedOneRM)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.workoutId, workoutId) || other.workoutId == workoutId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseId,estimatedOneRM,weight,reps,workoutId,updatedAt);

@override
String toString() {
  return 'PersonalRecordModel(exerciseId: $exerciseId, estimatedOneRM: $estimatedOneRM, weight: $weight, reps: $reps, workoutId: $workoutId, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PersonalRecordModelCopyWith<$Res>  {
  factory $PersonalRecordModelCopyWith(PersonalRecordModel value, $Res Function(PersonalRecordModel) _then) = _$PersonalRecordModelCopyWithImpl;
@useResult
$Res call({
 String exerciseId, double estimatedOneRM, double weight, int reps, String workoutId, DateTime updatedAt
});




}
/// @nodoc
class _$PersonalRecordModelCopyWithImpl<$Res>
    implements $PersonalRecordModelCopyWith<$Res> {
  _$PersonalRecordModelCopyWithImpl(this._self, this._then);

  final PersonalRecordModel _self;
  final $Res Function(PersonalRecordModel) _then;

/// Create a copy of PersonalRecordModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exerciseId = null,Object? estimatedOneRM = null,Object? weight = null,Object? reps = null,Object? workoutId = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,estimatedOneRM: null == estimatedOneRM ? _self.estimatedOneRM : estimatedOneRM // ignore: cast_nullable_to_non_nullable
as double,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,workoutId: null == workoutId ? _self.workoutId : workoutId // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonalRecordModel].
extension PersonalRecordModelPatterns on PersonalRecordModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalRecordModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalRecordModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalRecordModel value)  $default,){
final _that = this;
switch (_that) {
case _PersonalRecordModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalRecordModel value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalRecordModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String exerciseId,  double estimatedOneRM,  double weight,  int reps,  String workoutId,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalRecordModel() when $default != null:
return $default(_that.exerciseId,_that.estimatedOneRM,_that.weight,_that.reps,_that.workoutId,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String exerciseId,  double estimatedOneRM,  double weight,  int reps,  String workoutId,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PersonalRecordModel():
return $default(_that.exerciseId,_that.estimatedOneRM,_that.weight,_that.reps,_that.workoutId,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String exerciseId,  double estimatedOneRM,  double weight,  int reps,  String workoutId,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PersonalRecordModel() when $default != null:
return $default(_that.exerciseId,_that.estimatedOneRM,_that.weight,_that.reps,_that.workoutId,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonalRecordModel implements PersonalRecordModel {
  const _PersonalRecordModel({required this.exerciseId, required this.estimatedOneRM, required this.weight, required this.reps, required this.workoutId, required this.updatedAt});
  factory _PersonalRecordModel.fromJson(Map<String, dynamic> json) => _$PersonalRecordModelFromJson(json);

@override final  String exerciseId;
@override final  double estimatedOneRM;
@override final  double weight;
@override final  int reps;
@override final  String workoutId;
@override final  DateTime updatedAt;

/// Create a copy of PersonalRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalRecordModelCopyWith<_PersonalRecordModel> get copyWith => __$PersonalRecordModelCopyWithImpl<_PersonalRecordModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalRecordModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalRecordModel&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.estimatedOneRM, estimatedOneRM) || other.estimatedOneRM == estimatedOneRM)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.workoutId, workoutId) || other.workoutId == workoutId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseId,estimatedOneRM,weight,reps,workoutId,updatedAt);

@override
String toString() {
  return 'PersonalRecordModel(exerciseId: $exerciseId, estimatedOneRM: $estimatedOneRM, weight: $weight, reps: $reps, workoutId: $workoutId, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PersonalRecordModelCopyWith<$Res> implements $PersonalRecordModelCopyWith<$Res> {
  factory _$PersonalRecordModelCopyWith(_PersonalRecordModel value, $Res Function(_PersonalRecordModel) _then) = __$PersonalRecordModelCopyWithImpl;
@override @useResult
$Res call({
 String exerciseId, double estimatedOneRM, double weight, int reps, String workoutId, DateTime updatedAt
});




}
/// @nodoc
class __$PersonalRecordModelCopyWithImpl<$Res>
    implements _$PersonalRecordModelCopyWith<$Res> {
  __$PersonalRecordModelCopyWithImpl(this._self, this._then);

  final _PersonalRecordModel _self;
  final $Res Function(_PersonalRecordModel) _then;

/// Create a copy of PersonalRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exerciseId = null,Object? estimatedOneRM = null,Object? weight = null,Object? reps = null,Object? workoutId = null,Object? updatedAt = null,}) {
  return _then(_PersonalRecordModel(
exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,estimatedOneRM: null == estimatedOneRM ? _self.estimatedOneRM : estimatedOneRM // ignore: cast_nullable_to_non_nullable
as double,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,workoutId: null == workoutId ? _self.workoutId : workoutId // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
