// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutModel {

 String get id; String get name; DateTime get startedAt; DateTime? get finishedAt; int get duration; double get totalVolume; String? get notes; List<ExerciseInWorkoutModel> get exercises;
/// Create a copy of WorkoutModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutModelCopyWith<WorkoutModel> get copyWith => _$WorkoutModelCopyWithImpl<WorkoutModel>(this as WorkoutModel, _$identity);

  /// Serializes this WorkoutModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.exercises, exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startedAt,finishedAt,duration,totalVolume,notes,const DeepCollectionEquality().hash(exercises));

@override
String toString() {
  return 'WorkoutModel(id: $id, name: $name, startedAt: $startedAt, finishedAt: $finishedAt, duration: $duration, totalVolume: $totalVolume, notes: $notes, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class $WorkoutModelCopyWith<$Res>  {
  factory $WorkoutModelCopyWith(WorkoutModel value, $Res Function(WorkoutModel) _then) = _$WorkoutModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, DateTime startedAt, DateTime? finishedAt, int duration, double totalVolume, String? notes, List<ExerciseInWorkoutModel> exercises
});




}
/// @nodoc
class _$WorkoutModelCopyWithImpl<$Res>
    implements $WorkoutModelCopyWith<$Res> {
  _$WorkoutModelCopyWithImpl(this._self, this._then);

  final WorkoutModel _self;
  final $Res Function(WorkoutModel) _then;

/// Create a copy of WorkoutModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? startedAt = null,Object? finishedAt = freezed,Object? duration = null,Object? totalVolume = null,Object? notes = freezed,Object? exercises = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ExerciseInWorkoutModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkoutModel].
extension WorkoutModelPatterns on WorkoutModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutModel value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutModel value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  DateTime startedAt,  DateTime? finishedAt,  int duration,  double totalVolume,  String? notes,  List<ExerciseInWorkoutModel> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutModel() when $default != null:
return $default(_that.id,_that.name,_that.startedAt,_that.finishedAt,_that.duration,_that.totalVolume,_that.notes,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  DateTime startedAt,  DateTime? finishedAt,  int duration,  double totalVolume,  String? notes,  List<ExerciseInWorkoutModel> exercises)  $default,) {final _that = this;
switch (_that) {
case _WorkoutModel():
return $default(_that.id,_that.name,_that.startedAt,_that.finishedAt,_that.duration,_that.totalVolume,_that.notes,_that.exercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  DateTime startedAt,  DateTime? finishedAt,  int duration,  double totalVolume,  String? notes,  List<ExerciseInWorkoutModel> exercises)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutModel() when $default != null:
return $default(_that.id,_that.name,_that.startedAt,_that.finishedAt,_that.duration,_that.totalVolume,_that.notes,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkoutModel implements WorkoutModel {
  const _WorkoutModel({required this.id, required this.name, required this.startedAt, this.finishedAt, this.duration = 0, this.totalVolume = 0.0, this.notes, final  List<ExerciseInWorkoutModel> exercises = const <ExerciseInWorkoutModel>[]}): _exercises = exercises;
  factory _WorkoutModel.fromJson(Map<String, dynamic> json) => _$WorkoutModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  DateTime startedAt;
@override final  DateTime? finishedAt;
@override@JsonKey() final  int duration;
@override@JsonKey() final  double totalVolume;
@override final  String? notes;
 final  List<ExerciseInWorkoutModel> _exercises;
@override@JsonKey() List<ExerciseInWorkoutModel> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of WorkoutModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutModelCopyWith<_WorkoutModel> get copyWith => __$WorkoutModelCopyWithImpl<_WorkoutModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkoutModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._exercises, _exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startedAt,finishedAt,duration,totalVolume,notes,const DeepCollectionEquality().hash(_exercises));

@override
String toString() {
  return 'WorkoutModel(id: $id, name: $name, startedAt: $startedAt, finishedAt: $finishedAt, duration: $duration, totalVolume: $totalVolume, notes: $notes, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$WorkoutModelCopyWith<$Res> implements $WorkoutModelCopyWith<$Res> {
  factory _$WorkoutModelCopyWith(_WorkoutModel value, $Res Function(_WorkoutModel) _then) = __$WorkoutModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, DateTime startedAt, DateTime? finishedAt, int duration, double totalVolume, String? notes, List<ExerciseInWorkoutModel> exercises
});




}
/// @nodoc
class __$WorkoutModelCopyWithImpl<$Res>
    implements _$WorkoutModelCopyWith<$Res> {
  __$WorkoutModelCopyWithImpl(this._self, this._then);

  final _WorkoutModel _self;
  final $Res Function(_WorkoutModel) _then;

/// Create a copy of WorkoutModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? startedAt = null,Object? finishedAt = freezed,Object? duration = null,Object? totalVolume = null,Object? notes = freezed,Object? exercises = null,}) {
  return _then(_WorkoutModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ExerciseInWorkoutModel>,
  ));
}


}

// dart format on
