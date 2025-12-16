// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_house_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateHouseFormState {

 int? get countryId; int? get stateId; int? get cityId; int? get neighborhoodId; int? get imageId; List<Country> get countries; List<StateData> get states; List<City> get cities; List<Neighborhood> get neighborhoods; bool get isSubmitting; bool get isLoadingLocations;
/// Create a copy of CreateHouseFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateHouseFormStateCopyWith<CreateHouseFormState> get copyWith => _$CreateHouseFormStateCopyWithImpl<CreateHouseFormState>(this as CreateHouseFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateHouseFormState&&(identical(other.countryId, countryId) || other.countryId == countryId)&&(identical(other.stateId, stateId) || other.stateId == stateId)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.neighborhoodId, neighborhoodId) || other.neighborhoodId == neighborhoodId)&&(identical(other.imageId, imageId) || other.imageId == imageId)&&const DeepCollectionEquality().equals(other.countries, countries)&&const DeepCollectionEquality().equals(other.states, states)&&const DeepCollectionEquality().equals(other.cities, cities)&&const DeepCollectionEquality().equals(other.neighborhoods, neighborhoods)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isLoadingLocations, isLoadingLocations) || other.isLoadingLocations == isLoadingLocations));
}


@override
int get hashCode => Object.hash(runtimeType,countryId,stateId,cityId,neighborhoodId,imageId,const DeepCollectionEquality().hash(countries),const DeepCollectionEquality().hash(states),const DeepCollectionEquality().hash(cities),const DeepCollectionEquality().hash(neighborhoods),isSubmitting,isLoadingLocations);

@override
String toString() {
  return 'CreateHouseFormState(countryId: $countryId, stateId: $stateId, cityId: $cityId, neighborhoodId: $neighborhoodId, imageId: $imageId, countries: $countries, states: $states, cities: $cities, neighborhoods: $neighborhoods, isSubmitting: $isSubmitting, isLoadingLocations: $isLoadingLocations)';
}


}

/// @nodoc
abstract mixin class $CreateHouseFormStateCopyWith<$Res>  {
  factory $CreateHouseFormStateCopyWith(CreateHouseFormState value, $Res Function(CreateHouseFormState) _then) = _$CreateHouseFormStateCopyWithImpl;
@useResult
$Res call({
 int? countryId, int? stateId, int? cityId, int? neighborhoodId, int? imageId, List<Country> countries, List<StateData> states, List<City> cities, List<Neighborhood> neighborhoods, bool isSubmitting, bool isLoadingLocations
});




}
/// @nodoc
class _$CreateHouseFormStateCopyWithImpl<$Res>
    implements $CreateHouseFormStateCopyWith<$Res> {
  _$CreateHouseFormStateCopyWithImpl(this._self, this._then);

  final CreateHouseFormState _self;
  final $Res Function(CreateHouseFormState) _then;

/// Create a copy of CreateHouseFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? countryId = freezed,Object? stateId = freezed,Object? cityId = freezed,Object? neighborhoodId = freezed,Object? imageId = freezed,Object? countries = null,Object? states = null,Object? cities = null,Object? neighborhoods = null,Object? isSubmitting = null,Object? isLoadingLocations = null,}) {
  return _then(_self.copyWith(
countryId: freezed == countryId ? _self.countryId : countryId // ignore: cast_nullable_to_non_nullable
as int?,stateId: freezed == stateId ? _self.stateId : stateId // ignore: cast_nullable_to_non_nullable
as int?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as int?,neighborhoodId: freezed == neighborhoodId ? _self.neighborhoodId : neighborhoodId // ignore: cast_nullable_to_non_nullable
as int?,imageId: freezed == imageId ? _self.imageId : imageId // ignore: cast_nullable_to_non_nullable
as int?,countries: null == countries ? _self.countries : countries // ignore: cast_nullable_to_non_nullable
as List<Country>,states: null == states ? _self.states : states // ignore: cast_nullable_to_non_nullable
as List<StateData>,cities: null == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as List<City>,neighborhoods: null == neighborhoods ? _self.neighborhoods : neighborhoods // ignore: cast_nullable_to_non_nullable
as List<Neighborhood>,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isLoadingLocations: null == isLoadingLocations ? _self.isLoadingLocations : isLoadingLocations // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateHouseFormState].
extension CreateHouseFormStatePatterns on CreateHouseFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateHouseFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateHouseFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateHouseFormState value)  $default,){
final _that = this;
switch (_that) {
case _CreateHouseFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateHouseFormState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateHouseFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? countryId,  int? stateId,  int? cityId,  int? neighborhoodId,  int? imageId,  List<Country> countries,  List<StateData> states,  List<City> cities,  List<Neighborhood> neighborhoods,  bool isSubmitting,  bool isLoadingLocations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateHouseFormState() when $default != null:
return $default(_that.countryId,_that.stateId,_that.cityId,_that.neighborhoodId,_that.imageId,_that.countries,_that.states,_that.cities,_that.neighborhoods,_that.isSubmitting,_that.isLoadingLocations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? countryId,  int? stateId,  int? cityId,  int? neighborhoodId,  int? imageId,  List<Country> countries,  List<StateData> states,  List<City> cities,  List<Neighborhood> neighborhoods,  bool isSubmitting,  bool isLoadingLocations)  $default,) {final _that = this;
switch (_that) {
case _CreateHouseFormState():
return $default(_that.countryId,_that.stateId,_that.cityId,_that.neighborhoodId,_that.imageId,_that.countries,_that.states,_that.cities,_that.neighborhoods,_that.isSubmitting,_that.isLoadingLocations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? countryId,  int? stateId,  int? cityId,  int? neighborhoodId,  int? imageId,  List<Country> countries,  List<StateData> states,  List<City> cities,  List<Neighborhood> neighborhoods,  bool isSubmitting,  bool isLoadingLocations)?  $default,) {final _that = this;
switch (_that) {
case _CreateHouseFormState() when $default != null:
return $default(_that.countryId,_that.stateId,_that.cityId,_that.neighborhoodId,_that.imageId,_that.countries,_that.states,_that.cities,_that.neighborhoods,_that.isSubmitting,_that.isLoadingLocations);case _:
  return null;

}
}

}

/// @nodoc


class _CreateHouseFormState implements CreateHouseFormState {
  const _CreateHouseFormState({this.countryId, this.stateId, this.cityId, this.neighborhoodId, this.imageId, final  List<Country> countries = const [], final  List<StateData> states = const [], final  List<City> cities = const [], final  List<Neighborhood> neighborhoods = const [], this.isSubmitting = false, this.isLoadingLocations = false}): _countries = countries,_states = states,_cities = cities,_neighborhoods = neighborhoods;
  

@override final  int? countryId;
@override final  int? stateId;
@override final  int? cityId;
@override final  int? neighborhoodId;
@override final  int? imageId;
 final  List<Country> _countries;
@override@JsonKey() List<Country> get countries {
  if (_countries is EqualUnmodifiableListView) return _countries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_countries);
}

 final  List<StateData> _states;
@override@JsonKey() List<StateData> get states {
  if (_states is EqualUnmodifiableListView) return _states;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_states);
}

 final  List<City> _cities;
@override@JsonKey() List<City> get cities {
  if (_cities is EqualUnmodifiableListView) return _cities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cities);
}

 final  List<Neighborhood> _neighborhoods;
@override@JsonKey() List<Neighborhood> get neighborhoods {
  if (_neighborhoods is EqualUnmodifiableListView) return _neighborhoods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_neighborhoods);
}

@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isLoadingLocations;

/// Create a copy of CreateHouseFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateHouseFormStateCopyWith<_CreateHouseFormState> get copyWith => __$CreateHouseFormStateCopyWithImpl<_CreateHouseFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateHouseFormState&&(identical(other.countryId, countryId) || other.countryId == countryId)&&(identical(other.stateId, stateId) || other.stateId == stateId)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.neighborhoodId, neighborhoodId) || other.neighborhoodId == neighborhoodId)&&(identical(other.imageId, imageId) || other.imageId == imageId)&&const DeepCollectionEquality().equals(other._countries, _countries)&&const DeepCollectionEquality().equals(other._states, _states)&&const DeepCollectionEquality().equals(other._cities, _cities)&&const DeepCollectionEquality().equals(other._neighborhoods, _neighborhoods)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isLoadingLocations, isLoadingLocations) || other.isLoadingLocations == isLoadingLocations));
}


@override
int get hashCode => Object.hash(runtimeType,countryId,stateId,cityId,neighborhoodId,imageId,const DeepCollectionEquality().hash(_countries),const DeepCollectionEquality().hash(_states),const DeepCollectionEquality().hash(_cities),const DeepCollectionEquality().hash(_neighborhoods),isSubmitting,isLoadingLocations);

@override
String toString() {
  return 'CreateHouseFormState(countryId: $countryId, stateId: $stateId, cityId: $cityId, neighborhoodId: $neighborhoodId, imageId: $imageId, countries: $countries, states: $states, cities: $cities, neighborhoods: $neighborhoods, isSubmitting: $isSubmitting, isLoadingLocations: $isLoadingLocations)';
}


}

/// @nodoc
abstract mixin class _$CreateHouseFormStateCopyWith<$Res> implements $CreateHouseFormStateCopyWith<$Res> {
  factory _$CreateHouseFormStateCopyWith(_CreateHouseFormState value, $Res Function(_CreateHouseFormState) _then) = __$CreateHouseFormStateCopyWithImpl;
@override @useResult
$Res call({
 int? countryId, int? stateId, int? cityId, int? neighborhoodId, int? imageId, List<Country> countries, List<StateData> states, List<City> cities, List<Neighborhood> neighborhoods, bool isSubmitting, bool isLoadingLocations
});




}
/// @nodoc
class __$CreateHouseFormStateCopyWithImpl<$Res>
    implements _$CreateHouseFormStateCopyWith<$Res> {
  __$CreateHouseFormStateCopyWithImpl(this._self, this._then);

  final _CreateHouseFormState _self;
  final $Res Function(_CreateHouseFormState) _then;

/// Create a copy of CreateHouseFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? countryId = freezed,Object? stateId = freezed,Object? cityId = freezed,Object? neighborhoodId = freezed,Object? imageId = freezed,Object? countries = null,Object? states = null,Object? cities = null,Object? neighborhoods = null,Object? isSubmitting = null,Object? isLoadingLocations = null,}) {
  return _then(_CreateHouseFormState(
countryId: freezed == countryId ? _self.countryId : countryId // ignore: cast_nullable_to_non_nullable
as int?,stateId: freezed == stateId ? _self.stateId : stateId // ignore: cast_nullable_to_non_nullable
as int?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as int?,neighborhoodId: freezed == neighborhoodId ? _self.neighborhoodId : neighborhoodId // ignore: cast_nullable_to_non_nullable
as int?,imageId: freezed == imageId ? _self.imageId : imageId // ignore: cast_nullable_to_non_nullable
as int?,countries: null == countries ? _self._countries : countries // ignore: cast_nullable_to_non_nullable
as List<Country>,states: null == states ? _self._states : states // ignore: cast_nullable_to_non_nullable
as List<StateData>,cities: null == cities ? _self._cities : cities // ignore: cast_nullable_to_non_nullable
as List<City>,neighborhoods: null == neighborhoods ? _self._neighborhoods : neighborhoods // ignore: cast_nullable_to_non_nullable
as List<Neighborhood>,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isLoadingLocations: null == isLoadingLocations ? _self.isLoadingLocations : isLoadingLocations // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
