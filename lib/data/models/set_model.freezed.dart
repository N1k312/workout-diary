// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'set_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SetModel {

 double get weight; int get reps; bool get isCompleted; double get estimatedOneRM;
/// Create a copy of SetModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetModelCopyWith<SetModel> get copyWith => _$SetModelCopyWithImpl<SetModel>(this as SetModel, _$identity);

  /// Serializes this SetModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetModel&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.estimatedOneRM, estimatedOneRM) || other.estimatedOneRM == estimatedOneRM));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weight,reps,isCompleted,estimatedOneRM);

@override
String toString() {
  return 'SetModel(weight: $weight, reps: $reps, isCompleted: $isCompleted, estimatedOneRM: $estimatedOneRM)';
}


}

/// @nodoc
abstract mixin class $SetModelCopyWith<$Res>  {
  factory $SetModelCopyWith(SetModel value, $Res Function(SetModel) _then) = _$SetModelCopyWithImpl;
@useResult
$Res call({
 double weight, int reps, bool isCompleted, double estimatedOneRM
});




}
/// @nodoc
class _$SetModelCopyWithImpl<$Res>
    implements $SetModelCopyWith<$Res> {
  _$SetModelCopyWithImpl(this._self, this._then);

  final SetModel _self;
  final $Res Function(SetModel) _then;

/// Create a copy of SetModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weight = null,Object? reps = null,Object? isCompleted = null,Object? estimatedOneRM = null,}) {
  return _then(_self.copyWith(
weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,estimatedOneRM: null == estimatedOneRM ? _self.estimatedOneRM : estimatedOneRM // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SetModel].
extension SetModelPatterns on SetModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetModel value)  $default,){
final _that = this;
switch (_that) {
case _SetModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetModel value)?  $default,){
final _that = this;
switch (_that) {
case _SetModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double weight,  int reps,  bool isCompleted,  double estimatedOneRM)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetModel() when $default != null:
return $default(_that.weight,_that.reps,_that.isCompleted,_that.estimatedOneRM);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double weight,  int reps,  bool isCompleted,  double estimatedOneRM)  $default,) {final _that = this;
switch (_that) {
case _SetModel():
return $default(_that.weight,_that.reps,_that.isCompleted,_that.estimatedOneRM);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double weight,  int reps,  bool isCompleted,  double estimatedOneRM)?  $default,) {final _that = this;
switch (_that) {
case _SetModel() when $default != null:
return $default(_that.weight,_that.reps,_that.isCompleted,_that.estimatedOneRM);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SetModel implements SetModel {
  const _SetModel({required this.weight, required this.reps, this.isCompleted = false, this.estimatedOneRM = 0.0});
  factory _SetModel.fromJson(Map<String, dynamic> json) => _$SetModelFromJson(json);

@override final  double weight;
@override final  int reps;
@override@JsonKey() final  bool isCompleted;
@override@JsonKey() final  double estimatedOneRM;

/// Create a copy of SetModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetModelCopyWith<_SetModel> get copyWith => __$SetModelCopyWithImpl<_SetModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SetModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetModel&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.estimatedOneRM, estimatedOneRM) || other.estimatedOneRM == estimatedOneRM));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weight,reps,isCompleted,estimatedOneRM);

@override
String toString() {
  return 'SetModel(weight: $weight, reps: $reps, isCompleted: $isCompleted, estimatedOneRM: $estimatedOneRM)';
}


}

/// @nodoc
abstract mixin class _$SetModelCopyWith<$Res> implements $SetModelCopyWith<$Res> {
  factory _$SetModelCopyWith(_SetModel value, $Res Function(_SetModel) _then) = __$SetModelCopyWithImpl;
@override @useResult
$Res call({
 double weight, int reps, bool isCompleted, double estimatedOneRM
});




}
/// @nodoc
class __$SetModelCopyWithImpl<$Res>
    implements _$SetModelCopyWith<$Res> {
  __$SetModelCopyWithImpl(this._self, this._then);

  final _SetModel _self;
  final $Res Function(_SetModel) _then;

/// Create a copy of SetModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weight = null,Object? reps = null,Object? isCompleted = null,Object? estimatedOneRM = null,}) {
  return _then(_SetModel(
weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,estimatedOneRM: null == estimatedOneRM ? _self.estimatedOneRM : estimatedOneRM // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
