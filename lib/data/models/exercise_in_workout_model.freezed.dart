// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_in_workout_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExerciseInWorkoutModel {

 String get exerciseId; String get exerciseName; int get order; List<SetModel> get sets;
/// Create a copy of ExerciseInWorkoutModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseInWorkoutModelCopyWith<ExerciseInWorkoutModel> get copyWith => _$ExerciseInWorkoutModelCopyWithImpl<ExerciseInWorkoutModel>(this as ExerciseInWorkoutModel, _$identity);

  /// Serializes this ExerciseInWorkoutModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseInWorkoutModel&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&(identical(other.order, order) || other.order == order)&&const DeepCollectionEquality().equals(other.sets, sets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseId,exerciseName,order,const DeepCollectionEquality().hash(sets));

@override
String toString() {
  return 'ExerciseInWorkoutModel(exerciseId: $exerciseId, exerciseName: $exerciseName, order: $order, sets: $sets)';
}


}

/// @nodoc
abstract mixin class $ExerciseInWorkoutModelCopyWith<$Res>  {
  factory $ExerciseInWorkoutModelCopyWith(ExerciseInWorkoutModel value, $Res Function(ExerciseInWorkoutModel) _then) = _$ExerciseInWorkoutModelCopyWithImpl;
@useResult
$Res call({
 String exerciseId, String exerciseName, int order, List<SetModel> sets
});




}
/// @nodoc
class _$ExerciseInWorkoutModelCopyWithImpl<$Res>
    implements $ExerciseInWorkoutModelCopyWith<$Res> {
  _$ExerciseInWorkoutModelCopyWithImpl(this._self, this._then);

  final ExerciseInWorkoutModel _self;
  final $Res Function(ExerciseInWorkoutModel) _then;

/// Create a copy of ExerciseInWorkoutModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exerciseId = null,Object? exerciseName = null,Object? order = null,Object? sets = null,}) {
  return _then(_self.copyWith(
exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,exerciseName: null == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<SetModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseInWorkoutModel].
extension ExerciseInWorkoutModelPatterns on ExerciseInWorkoutModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseInWorkoutModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseInWorkoutModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseInWorkoutModel value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseInWorkoutModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseInWorkoutModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseInWorkoutModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String exerciseId,  String exerciseName,  int order,  List<SetModel> sets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseInWorkoutModel() when $default != null:
return $default(_that.exerciseId,_that.exerciseName,_that.order,_that.sets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String exerciseId,  String exerciseName,  int order,  List<SetModel> sets)  $default,) {final _that = this;
switch (_that) {
case _ExerciseInWorkoutModel():
return $default(_that.exerciseId,_that.exerciseName,_that.order,_that.sets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String exerciseId,  String exerciseName,  int order,  List<SetModel> sets)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseInWorkoutModel() when $default != null:
return $default(_that.exerciseId,_that.exerciseName,_that.order,_that.sets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExerciseInWorkoutModel implements ExerciseInWorkoutModel {
  const _ExerciseInWorkoutModel({required this.exerciseId, required this.exerciseName, required this.order, final  List<SetModel> sets = const <SetModel>[]}): _sets = sets;
  factory _ExerciseInWorkoutModel.fromJson(Map<String, dynamic> json) => _$ExerciseInWorkoutModelFromJson(json);

@override final  String exerciseId;
@override final  String exerciseName;
@override final  int order;
 final  List<SetModel> _sets;
@override@JsonKey() List<SetModel> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}


/// Create a copy of ExerciseInWorkoutModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseInWorkoutModelCopyWith<_ExerciseInWorkoutModel> get copyWith => __$ExerciseInWorkoutModelCopyWithImpl<_ExerciseInWorkoutModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExerciseInWorkoutModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseInWorkoutModel&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&(identical(other.order, order) || other.order == order)&&const DeepCollectionEquality().equals(other._sets, _sets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseId,exerciseName,order,const DeepCollectionEquality().hash(_sets));

@override
String toString() {
  return 'ExerciseInWorkoutModel(exerciseId: $exerciseId, exerciseName: $exerciseName, order: $order, sets: $sets)';
}


}

/// @nodoc
abstract mixin class _$ExerciseInWorkoutModelCopyWith<$Res> implements $ExerciseInWorkoutModelCopyWith<$Res> {
  factory _$ExerciseInWorkoutModelCopyWith(_ExerciseInWorkoutModel value, $Res Function(_ExerciseInWorkoutModel) _then) = __$ExerciseInWorkoutModelCopyWithImpl;
@override @useResult
$Res call({
 String exerciseId, String exerciseName, int order, List<SetModel> sets
});




}
/// @nodoc
class __$ExerciseInWorkoutModelCopyWithImpl<$Res>
    implements _$ExerciseInWorkoutModelCopyWith<$Res> {
  __$ExerciseInWorkoutModelCopyWithImpl(this._self, this._then);

  final _ExerciseInWorkoutModel _self;
  final $Res Function(_ExerciseInWorkoutModel) _then;

/// Create a copy of ExerciseInWorkoutModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exerciseId = null,Object? exerciseName = null,Object? order = null,Object? sets = null,}) {
  return _then(_ExerciseInWorkoutModel(
exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,exerciseName: null == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<SetModel>,
  ));
}


}

// dart format on
