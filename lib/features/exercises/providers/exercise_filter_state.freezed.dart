// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExerciseFilterState {

 String get searchQuery; MuscleGroup? get selectedMuscleGroup;
/// Create a copy of ExerciseFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseFilterStateCopyWith<ExerciseFilterState> get copyWith => _$ExerciseFilterStateCopyWithImpl<ExerciseFilterState>(this as ExerciseFilterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseFilterState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedMuscleGroup, selectedMuscleGroup) || other.selectedMuscleGroup == selectedMuscleGroup));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,selectedMuscleGroup);

@override
String toString() {
  return 'ExerciseFilterState(searchQuery: $searchQuery, selectedMuscleGroup: $selectedMuscleGroup)';
}


}

/// @nodoc
abstract mixin class $ExerciseFilterStateCopyWith<$Res>  {
  factory $ExerciseFilterStateCopyWith(ExerciseFilterState value, $Res Function(ExerciseFilterState) _then) = _$ExerciseFilterStateCopyWithImpl;
@useResult
$Res call({
 String searchQuery, MuscleGroup? selectedMuscleGroup
});




}
/// @nodoc
class _$ExerciseFilterStateCopyWithImpl<$Res>
    implements $ExerciseFilterStateCopyWith<$Res> {
  _$ExerciseFilterStateCopyWithImpl(this._self, this._then);

  final ExerciseFilterState _self;
  final $Res Function(ExerciseFilterState) _then;

/// Create a copy of ExerciseFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchQuery = null,Object? selectedMuscleGroup = freezed,}) {
  return _then(_self.copyWith(
searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedMuscleGroup: freezed == selectedMuscleGroup ? _self.selectedMuscleGroup : selectedMuscleGroup // ignore: cast_nullable_to_non_nullable
as MuscleGroup?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseFilterState].
extension ExerciseFilterStatePatterns on ExerciseFilterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseFilterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseFilterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseFilterState value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseFilterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseFilterState value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseFilterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String searchQuery,  MuscleGroup? selectedMuscleGroup)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseFilterState() when $default != null:
return $default(_that.searchQuery,_that.selectedMuscleGroup);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String searchQuery,  MuscleGroup? selectedMuscleGroup)  $default,) {final _that = this;
switch (_that) {
case _ExerciseFilterState():
return $default(_that.searchQuery,_that.selectedMuscleGroup);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String searchQuery,  MuscleGroup? selectedMuscleGroup)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseFilterState() when $default != null:
return $default(_that.searchQuery,_that.selectedMuscleGroup);case _:
  return null;

}
}

}

/// @nodoc


class _ExerciseFilterState implements ExerciseFilterState {
  const _ExerciseFilterState({this.searchQuery = '', this.selectedMuscleGroup});
  

@override@JsonKey() final  String searchQuery;
@override final  MuscleGroup? selectedMuscleGroup;

/// Create a copy of ExerciseFilterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseFilterStateCopyWith<_ExerciseFilterState> get copyWith => __$ExerciseFilterStateCopyWithImpl<_ExerciseFilterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseFilterState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedMuscleGroup, selectedMuscleGroup) || other.selectedMuscleGroup == selectedMuscleGroup));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,selectedMuscleGroup);

@override
String toString() {
  return 'ExerciseFilterState(searchQuery: $searchQuery, selectedMuscleGroup: $selectedMuscleGroup)';
}


}

/// @nodoc
abstract mixin class _$ExerciseFilterStateCopyWith<$Res> implements $ExerciseFilterStateCopyWith<$Res> {
  factory _$ExerciseFilterStateCopyWith(_ExerciseFilterState value, $Res Function(_ExerciseFilterState) _then) = __$ExerciseFilterStateCopyWithImpl;
@override @useResult
$Res call({
 String searchQuery, MuscleGroup? selectedMuscleGroup
});




}
/// @nodoc
class __$ExerciseFilterStateCopyWithImpl<$Res>
    implements _$ExerciseFilterStateCopyWith<$Res> {
  __$ExerciseFilterStateCopyWithImpl(this._self, this._then);

  final _ExerciseFilterState _self;
  final $Res Function(_ExerciseFilterState) _then;

/// Create a copy of ExerciseFilterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchQuery = null,Object? selectedMuscleGroup = freezed,}) {
  return _then(_ExerciseFilterState(
searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedMuscleGroup: freezed == selectedMuscleGroup ? _self.selectedMuscleGroup : selectedMuscleGroup // ignore: cast_nullable_to_non_nullable
as MuscleGroup?,
  ));
}


}

// dart format on
