// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_house_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateHouseRequest {

 String get title;@JsonKey(name: 'image') int? get image;// Assuming API accepts null or valid ID
 double get price; String get description; String get category; bool get available;@JsonKey(name: 'total_units') int get totalUnits;@JsonKey(name: 'is_active') bool get isActive;// Location IDs
 int? get country; int? get state; int? get city; int? get neighborhood;
/// Create a copy of CreateHouseRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateHouseRequestCopyWith<CreateHouseRequest> get copyWith => _$CreateHouseRequestCopyWithImpl<CreateHouseRequest>(this as CreateHouseRequest, _$identity);

  /// Serializes this CreateHouseRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateHouseRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.image, image) || other.image == image)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.available, available) || other.available == available)&&(identical(other.totalUnits, totalUnits) || other.totalUnits == totalUnits)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.country, country) || other.country == country)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,image,price,description,category,available,totalUnits,isActive,country,state,city,neighborhood);

@override
String toString() {
  return 'CreateHouseRequest(title: $title, image: $image, price: $price, description: $description, category: $category, available: $available, totalUnits: $totalUnits, isActive: $isActive, country: $country, state: $state, city: $city, neighborhood: $neighborhood)';
}


}

/// @nodoc
abstract mixin class $CreateHouseRequestCopyWith<$Res>  {
  factory $CreateHouseRequestCopyWith(CreateHouseRequest value, $Res Function(CreateHouseRequest) _then) = _$CreateHouseRequestCopyWithImpl;
@useResult
$Res call({
 String title,@JsonKey(name: 'image') int? image, double price, String description, String category, bool available,@JsonKey(name: 'total_units') int totalUnits,@JsonKey(name: 'is_active') bool isActive, int? country, int? state, int? city, int? neighborhood
});




}
/// @nodoc
class _$CreateHouseRequestCopyWithImpl<$Res>
    implements $CreateHouseRequestCopyWith<$Res> {
  _$CreateHouseRequestCopyWithImpl(this._self, this._then);

  final CreateHouseRequest _self;
  final $Res Function(CreateHouseRequest) _then;

/// Create a copy of CreateHouseRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? image = freezed,Object? price = null,Object? description = null,Object? category = null,Object? available = null,Object? totalUnits = null,Object? isActive = null,Object? country = freezed,Object? state = freezed,Object? city = freezed,Object? neighborhood = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as int?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,totalUnits: null == totalUnits ? _self.totalUnits : totalUnits // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as int?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as int?,neighborhood: freezed == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateHouseRequest].
extension CreateHouseRequestPatterns on CreateHouseRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateHouseRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateHouseRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateHouseRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateHouseRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateHouseRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateHouseRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title, @JsonKey(name: 'image')  int? image,  double price,  String description,  String category,  bool available, @JsonKey(name: 'total_units')  int totalUnits, @JsonKey(name: 'is_active')  bool isActive,  int? country,  int? state,  int? city,  int? neighborhood)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateHouseRequest() when $default != null:
return $default(_that.title,_that.image,_that.price,_that.description,_that.category,_that.available,_that.totalUnits,_that.isActive,_that.country,_that.state,_that.city,_that.neighborhood);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title, @JsonKey(name: 'image')  int? image,  double price,  String description,  String category,  bool available, @JsonKey(name: 'total_units')  int totalUnits, @JsonKey(name: 'is_active')  bool isActive,  int? country,  int? state,  int? city,  int? neighborhood)  $default,) {final _that = this;
switch (_that) {
case _CreateHouseRequest():
return $default(_that.title,_that.image,_that.price,_that.description,_that.category,_that.available,_that.totalUnits,_that.isActive,_that.country,_that.state,_that.city,_that.neighborhood);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title, @JsonKey(name: 'image')  int? image,  double price,  String description,  String category,  bool available, @JsonKey(name: 'total_units')  int totalUnits, @JsonKey(name: 'is_active')  bool isActive,  int? country,  int? state,  int? city,  int? neighborhood)?  $default,) {final _that = this;
switch (_that) {
case _CreateHouseRequest() when $default != null:
return $default(_that.title,_that.image,_that.price,_that.description,_that.category,_that.available,_that.totalUnits,_that.isActive,_that.country,_that.state,_that.city,_that.neighborhood);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: true)
class _CreateHouseRequest implements CreateHouseRequest {
  const _CreateHouseRequest({required this.title, @JsonKey(name: 'image') this.image, required this.price, required this.description, required this.category, required this.available, @JsonKey(name: 'total_units') required this.totalUnits, @JsonKey(name: 'is_active') required this.isActive, this.country, this.state, this.city, this.neighborhood});
  factory _CreateHouseRequest.fromJson(Map<String, dynamic> json) => _$CreateHouseRequestFromJson(json);

@override final  String title;
@override@JsonKey(name: 'image') final  int? image;
// Assuming API accepts null or valid ID
@override final  double price;
@override final  String description;
@override final  String category;
@override final  bool available;
@override@JsonKey(name: 'total_units') final  int totalUnits;
@override@JsonKey(name: 'is_active') final  bool isActive;
// Location IDs
@override final  int? country;
@override final  int? state;
@override final  int? city;
@override final  int? neighborhood;

/// Create a copy of CreateHouseRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateHouseRequestCopyWith<_CreateHouseRequest> get copyWith => __$CreateHouseRequestCopyWithImpl<_CreateHouseRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateHouseRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateHouseRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.image, image) || other.image == image)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.available, available) || other.available == available)&&(identical(other.totalUnits, totalUnits) || other.totalUnits == totalUnits)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.country, country) || other.country == country)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,image,price,description,category,available,totalUnits,isActive,country,state,city,neighborhood);

@override
String toString() {
  return 'CreateHouseRequest(title: $title, image: $image, price: $price, description: $description, category: $category, available: $available, totalUnits: $totalUnits, isActive: $isActive, country: $country, state: $state, city: $city, neighborhood: $neighborhood)';
}


}

/// @nodoc
abstract mixin class _$CreateHouseRequestCopyWith<$Res> implements $CreateHouseRequestCopyWith<$Res> {
  factory _$CreateHouseRequestCopyWith(_CreateHouseRequest value, $Res Function(_CreateHouseRequest) _then) = __$CreateHouseRequestCopyWithImpl;
@override @useResult
$Res call({
 String title,@JsonKey(name: 'image') int? image, double price, String description, String category, bool available,@JsonKey(name: 'total_units') int totalUnits,@JsonKey(name: 'is_active') bool isActive, int? country, int? state, int? city, int? neighborhood
});




}
/// @nodoc
class __$CreateHouseRequestCopyWithImpl<$Res>
    implements _$CreateHouseRequestCopyWith<$Res> {
  __$CreateHouseRequestCopyWithImpl(this._self, this._then);

  final _CreateHouseRequest _self;
  final $Res Function(_CreateHouseRequest) _then;

/// Create a copy of CreateHouseRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? image = freezed,Object? price = null,Object? description = null,Object? category = null,Object? available = null,Object? totalUnits = null,Object? isActive = null,Object? country = freezed,Object? state = freezed,Object? city = freezed,Object? neighborhood = freezed,}) {
  return _then(_CreateHouseRequest(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as int?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,totalUnits: null == totalUnits ? _self.totalUnits : totalUnits // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as int?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as int?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as int?,neighborhood: freezed == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
