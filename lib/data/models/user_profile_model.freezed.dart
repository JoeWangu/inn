// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileModel {

@JsonKey(name: 'first_name') String? get firstName;@JsonKey(name: 'last_name') String? get lastName;@JsonKey(name: 'phone_number') String? get phoneNumber; String? get dob; String? get gender; String? get address;@JsonKey(name: 'profile_picture') String? get profilePicture; String? get bio;@JsonKey(name: 'country') int? get countryId;@JsonKey(name: 'state') int? get stateId;@JsonKey(name: 'city') int? get cityId;@JsonKey(name: 'neighborhood') int? get neighborhoodId;@JsonKey(name: 'countryDetails') Country? get country;@JsonKey(name: 'stateDetails') StateData? get state;@JsonKey(name: 'cityDetails') City? get city;@JsonKey(name: 'neighborhoodDetails') Neighborhood? get neighborhood;
/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileModelCopyWith<UserProfileModel> get copyWith => _$UserProfileModelCopyWithImpl<UserProfileModel>(this as UserProfileModel, _$identity);

  /// Serializes this UserProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileModel&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.address, address) || other.address == address)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.countryId, countryId) || other.countryId == countryId)&&(identical(other.stateId, stateId) || other.stateId == stateId)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.neighborhoodId, neighborhoodId) || other.neighborhoodId == neighborhoodId)&&(identical(other.country, country) || other.country == country)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,phoneNumber,dob,gender,address,profilePicture,bio,countryId,stateId,cityId,neighborhoodId,country,state,city,neighborhood);

@override
String toString() {
  return 'UserProfileModel(firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, dob: $dob, gender: $gender, address: $address, profilePicture: $profilePicture, bio: $bio, countryId: $countryId, stateId: $stateId, cityId: $cityId, neighborhoodId: $neighborhoodId, country: $country, state: $state, city: $city, neighborhood: $neighborhood)';
}


}

/// @nodoc
abstract mixin class $UserProfileModelCopyWith<$Res>  {
  factory $UserProfileModelCopyWith(UserProfileModel value, $Res Function(UserProfileModel) _then) = _$UserProfileModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'first_name') String? firstName,@JsonKey(name: 'last_name') String? lastName,@JsonKey(name: 'phone_number') String? phoneNumber, String? dob, String? gender, String? address,@JsonKey(name: 'profile_picture') String? profilePicture, String? bio,@JsonKey(name: 'country') int? countryId,@JsonKey(name: 'state') int? stateId,@JsonKey(name: 'city') int? cityId,@JsonKey(name: 'neighborhood') int? neighborhoodId,@JsonKey(name: 'countryDetails') Country? country,@JsonKey(name: 'stateDetails') StateData? state,@JsonKey(name: 'cityDetails') City? city,@JsonKey(name: 'neighborhoodDetails') Neighborhood? neighborhood
});


$CountryCopyWith<$Res>? get country;$StateDataCopyWith<$Res>? get state;$CityCopyWith<$Res>? get city;$NeighborhoodCopyWith<$Res>? get neighborhood;

}
/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._self, this._then);

  final UserProfileModel _self;
  final $Res Function(UserProfileModel) _then;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = freezed,Object? lastName = freezed,Object? phoneNumber = freezed,Object? dob = freezed,Object? gender = freezed,Object? address = freezed,Object? profilePicture = freezed,Object? bio = freezed,Object? countryId = freezed,Object? stateId = freezed,Object? cityId = freezed,Object? neighborhoodId = freezed,Object? country = freezed,Object? state = freezed,Object? city = freezed,Object? neighborhood = freezed,}) {
  return _then(_self.copyWith(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,countryId: freezed == countryId ? _self.countryId : countryId // ignore: cast_nullable_to_non_nullable
as int?,stateId: freezed == stateId ? _self.stateId : stateId // ignore: cast_nullable_to_non_nullable
as int?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as int?,neighborhoodId: freezed == neighborhoodId ? _self.neighborhoodId : neighborhoodId // ignore: cast_nullable_to_non_nullable
as int?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as StateData?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as City?,neighborhood: freezed == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as Neighborhood?,
  ));
}
/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CountryCopyWith<$Res>? get country {
    if (_self.country == null) {
    return null;
  }

  return $CountryCopyWith<$Res>(_self.country!, (value) {
    return _then(_self.copyWith(country: value));
  });
}/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateDataCopyWith<$Res>? get state {
    if (_self.state == null) {
    return null;
  }

  return $StateDataCopyWith<$Res>(_self.state!, (value) {
    return _then(_self.copyWith(state: value));
  });
}/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CityCopyWith<$Res>? get city {
    if (_self.city == null) {
    return null;
  }

  return $CityCopyWith<$Res>(_self.city!, (value) {
    return _then(_self.copyWith(city: value));
  });
}/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NeighborhoodCopyWith<$Res>? get neighborhood {
    if (_self.neighborhood == null) {
    return null;
  }

  return $NeighborhoodCopyWith<$Res>(_self.neighborhood!, (value) {
    return _then(_self.copyWith(neighborhood: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserProfileModel].
extension UserProfileModelPatterns on UserProfileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'first_name')  String? firstName, @JsonKey(name: 'last_name')  String? lastName, @JsonKey(name: 'phone_number')  String? phoneNumber,  String? dob,  String? gender,  String? address, @JsonKey(name: 'profile_picture')  String? profilePicture,  String? bio, @JsonKey(name: 'country')  int? countryId, @JsonKey(name: 'state')  int? stateId, @JsonKey(name: 'city')  int? cityId, @JsonKey(name: 'neighborhood')  int? neighborhoodId, @JsonKey(name: 'countryDetails')  Country? country, @JsonKey(name: 'stateDetails')  StateData? state, @JsonKey(name: 'cityDetails')  City? city, @JsonKey(name: 'neighborhoodDetails')  Neighborhood? neighborhood)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
return $default(_that.firstName,_that.lastName,_that.phoneNumber,_that.dob,_that.gender,_that.address,_that.profilePicture,_that.bio,_that.countryId,_that.stateId,_that.cityId,_that.neighborhoodId,_that.country,_that.state,_that.city,_that.neighborhood);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'first_name')  String? firstName, @JsonKey(name: 'last_name')  String? lastName, @JsonKey(name: 'phone_number')  String? phoneNumber,  String? dob,  String? gender,  String? address, @JsonKey(name: 'profile_picture')  String? profilePicture,  String? bio, @JsonKey(name: 'country')  int? countryId, @JsonKey(name: 'state')  int? stateId, @JsonKey(name: 'city')  int? cityId, @JsonKey(name: 'neighborhood')  int? neighborhoodId, @JsonKey(name: 'countryDetails')  Country? country, @JsonKey(name: 'stateDetails')  StateData? state, @JsonKey(name: 'cityDetails')  City? city, @JsonKey(name: 'neighborhoodDetails')  Neighborhood? neighborhood)  $default,) {final _that = this;
switch (_that) {
case _UserProfileModel():
return $default(_that.firstName,_that.lastName,_that.phoneNumber,_that.dob,_that.gender,_that.address,_that.profilePicture,_that.bio,_that.countryId,_that.stateId,_that.cityId,_that.neighborhoodId,_that.country,_that.state,_that.city,_that.neighborhood);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'first_name')  String? firstName, @JsonKey(name: 'last_name')  String? lastName, @JsonKey(name: 'phone_number')  String? phoneNumber,  String? dob,  String? gender,  String? address, @JsonKey(name: 'profile_picture')  String? profilePicture,  String? bio, @JsonKey(name: 'country')  int? countryId, @JsonKey(name: 'state')  int? stateId, @JsonKey(name: 'city')  int? cityId, @JsonKey(name: 'neighborhood')  int? neighborhoodId, @JsonKey(name: 'countryDetails')  Country? country, @JsonKey(name: 'stateDetails')  StateData? state, @JsonKey(name: 'cityDetails')  City? city, @JsonKey(name: 'neighborhoodDetails')  Neighborhood? neighborhood)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
return $default(_that.firstName,_that.lastName,_that.phoneNumber,_that.dob,_that.gender,_that.address,_that.profilePicture,_that.bio,_that.countryId,_that.stateId,_that.cityId,_that.neighborhoodId,_that.country,_that.state,_that.city,_that.neighborhood);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _UserProfileModel implements UserProfileModel {
  const _UserProfileModel({@JsonKey(name: 'first_name') this.firstName, @JsonKey(name: 'last_name') this.lastName, @JsonKey(name: 'phone_number') this.phoneNumber, this.dob, this.gender, this.address, @JsonKey(name: 'profile_picture') this.profilePicture, this.bio, @JsonKey(name: 'country') this.countryId, @JsonKey(name: 'state') this.stateId, @JsonKey(name: 'city') this.cityId, @JsonKey(name: 'neighborhood') this.neighborhoodId, @JsonKey(name: 'countryDetails') this.country, @JsonKey(name: 'stateDetails') this.state, @JsonKey(name: 'cityDetails') this.city, @JsonKey(name: 'neighborhoodDetails') this.neighborhood});
  factory _UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);

@override@JsonKey(name: 'first_name') final  String? firstName;
@override@JsonKey(name: 'last_name') final  String? lastName;
@override@JsonKey(name: 'phone_number') final  String? phoneNumber;
@override final  String? dob;
@override final  String? gender;
@override final  String? address;
@override@JsonKey(name: 'profile_picture') final  String? profilePicture;
@override final  String? bio;
@override@JsonKey(name: 'country') final  int? countryId;
@override@JsonKey(name: 'state') final  int? stateId;
@override@JsonKey(name: 'city') final  int? cityId;
@override@JsonKey(name: 'neighborhood') final  int? neighborhoodId;
@override@JsonKey(name: 'countryDetails') final  Country? country;
@override@JsonKey(name: 'stateDetails') final  StateData? state;
@override@JsonKey(name: 'cityDetails') final  City? city;
@override@JsonKey(name: 'neighborhoodDetails') final  Neighborhood? neighborhood;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileModelCopyWith<_UserProfileModel> get copyWith => __$UserProfileModelCopyWithImpl<_UserProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileModel&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.address, address) || other.address == address)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.countryId, countryId) || other.countryId == countryId)&&(identical(other.stateId, stateId) || other.stateId == stateId)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.neighborhoodId, neighborhoodId) || other.neighborhoodId == neighborhoodId)&&(identical(other.country, country) || other.country == country)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,phoneNumber,dob,gender,address,profilePicture,bio,countryId,stateId,cityId,neighborhoodId,country,state,city,neighborhood);

@override
String toString() {
  return 'UserProfileModel(firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, dob: $dob, gender: $gender, address: $address, profilePicture: $profilePicture, bio: $bio, countryId: $countryId, stateId: $stateId, cityId: $cityId, neighborhoodId: $neighborhoodId, country: $country, state: $state, city: $city, neighborhood: $neighborhood)';
}


}

/// @nodoc
abstract mixin class _$UserProfileModelCopyWith<$Res> implements $UserProfileModelCopyWith<$Res> {
  factory _$UserProfileModelCopyWith(_UserProfileModel value, $Res Function(_UserProfileModel) _then) = __$UserProfileModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'first_name') String? firstName,@JsonKey(name: 'last_name') String? lastName,@JsonKey(name: 'phone_number') String? phoneNumber, String? dob, String? gender, String? address,@JsonKey(name: 'profile_picture') String? profilePicture, String? bio,@JsonKey(name: 'country') int? countryId,@JsonKey(name: 'state') int? stateId,@JsonKey(name: 'city') int? cityId,@JsonKey(name: 'neighborhood') int? neighborhoodId,@JsonKey(name: 'countryDetails') Country? country,@JsonKey(name: 'stateDetails') StateData? state,@JsonKey(name: 'cityDetails') City? city,@JsonKey(name: 'neighborhoodDetails') Neighborhood? neighborhood
});


@override $CountryCopyWith<$Res>? get country;@override $StateDataCopyWith<$Res>? get state;@override $CityCopyWith<$Res>? get city;@override $NeighborhoodCopyWith<$Res>? get neighborhood;

}
/// @nodoc
class __$UserProfileModelCopyWithImpl<$Res>
    implements _$UserProfileModelCopyWith<$Res> {
  __$UserProfileModelCopyWithImpl(this._self, this._then);

  final _UserProfileModel _self;
  final $Res Function(_UserProfileModel) _then;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = freezed,Object? lastName = freezed,Object? phoneNumber = freezed,Object? dob = freezed,Object? gender = freezed,Object? address = freezed,Object? profilePicture = freezed,Object? bio = freezed,Object? countryId = freezed,Object? stateId = freezed,Object? cityId = freezed,Object? neighborhoodId = freezed,Object? country = freezed,Object? state = freezed,Object? city = freezed,Object? neighborhood = freezed,}) {
  return _then(_UserProfileModel(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,countryId: freezed == countryId ? _self.countryId : countryId // ignore: cast_nullable_to_non_nullable
as int?,stateId: freezed == stateId ? _self.stateId : stateId // ignore: cast_nullable_to_non_nullable
as int?,cityId: freezed == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as int?,neighborhoodId: freezed == neighborhoodId ? _self.neighborhoodId : neighborhoodId // ignore: cast_nullable_to_non_nullable
as int?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as StateData?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as City?,neighborhood: freezed == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as Neighborhood?,
  ));
}

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CountryCopyWith<$Res>? get country {
    if (_self.country == null) {
    return null;
  }

  return $CountryCopyWith<$Res>(_self.country!, (value) {
    return _then(_self.copyWith(country: value));
  });
}/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateDataCopyWith<$Res>? get state {
    if (_self.state == null) {
    return null;
  }

  return $StateDataCopyWith<$Res>(_self.state!, (value) {
    return _then(_self.copyWith(state: value));
  });
}/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CityCopyWith<$Res>? get city {
    if (_self.city == null) {
    return null;
  }

  return $CityCopyWith<$Res>(_self.city!, (value) {
    return _then(_self.copyWith(city: value));
  });
}/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NeighborhoodCopyWith<$Res>? get neighborhood {
    if (_self.neighborhood == null) {
    return null;
  }

  return $NeighborhoodCopyWith<$Res>(_self.neighborhood!, (value) {
    return _then(_self.copyWith(neighborhood: value));
  });
}
}

// dart format on
