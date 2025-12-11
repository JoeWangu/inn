// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'house_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HouseModel {

 int get id;// The ID reference to the image (int)
 int get image; double get price;@JsonKey(name: 'total_units') int get totalUnits; String get title; String get description; String get category;// Dates are automatically parsed if in YYYY-MM-DD format
@JsonKey(name: 'date_posted') DateTime get datePosted;@JsonKey(name: 'date_modified') DateTime get dateModified;// Times are usually safer as Strings unless you combine them with dates
@JsonKey(name: 'time_posted') String get timePosted;@JsonKey(name: 'time_modified') String get timeModified; bool get available;@JsonKey(name: 'is_active') bool get isActive;// Nested Objects
@JsonKey(name: 'author_detail') AuthorDetail get authorDetail;@JsonKey(name: 'image_detail') ImageDetail get imageDetail;// Rating
@JsonKey(name: 'avg_rating') num get avgRating;// num handles int or double
// Location Objects (Nullable based on your JSON item #2)
 Country? get country; StateData? get state;// 'State' is a Flutter keyword, so we rename the class
 City? get city; Neighborhood? get neighborhood;// The flat username string
 String get author;
/// Create a copy of HouseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HouseModelCopyWith<HouseModel> get copyWith => _$HouseModelCopyWithImpl<HouseModel>(this as HouseModel, _$identity);

  /// Serializes this HouseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HouseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.image, image) || other.image == image)&&(identical(other.price, price) || other.price == price)&&(identical(other.totalUnits, totalUnits) || other.totalUnits == totalUnits)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.datePosted, datePosted) || other.datePosted == datePosted)&&(identical(other.dateModified, dateModified) || other.dateModified == dateModified)&&(identical(other.timePosted, timePosted) || other.timePosted == timePosted)&&(identical(other.timeModified, timeModified) || other.timeModified == timeModified)&&(identical(other.available, available) || other.available == available)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.authorDetail, authorDetail) || other.authorDetail == authorDetail)&&(identical(other.imageDetail, imageDetail) || other.imageDetail == imageDetail)&&(identical(other.avgRating, avgRating) || other.avgRating == avgRating)&&(identical(other.country, country) || other.country == country)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.author, author) || other.author == author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,image,price,totalUnits,title,description,category,datePosted,dateModified,timePosted,timeModified,available,isActive,authorDetail,imageDetail,avgRating,country,state,city,neighborhood,author]);

@override
String toString() {
  return 'HouseModel(id: $id, image: $image, price: $price, totalUnits: $totalUnits, title: $title, description: $description, category: $category, datePosted: $datePosted, dateModified: $dateModified, timePosted: $timePosted, timeModified: $timeModified, available: $available, isActive: $isActive, authorDetail: $authorDetail, imageDetail: $imageDetail, avgRating: $avgRating, country: $country, state: $state, city: $city, neighborhood: $neighborhood, author: $author)';
}


}

/// @nodoc
abstract mixin class $HouseModelCopyWith<$Res>  {
  factory $HouseModelCopyWith(HouseModel value, $Res Function(HouseModel) _then) = _$HouseModelCopyWithImpl;
@useResult
$Res call({
 int id, int image, double price,@JsonKey(name: 'total_units') int totalUnits, String title, String description, String category,@JsonKey(name: 'date_posted') DateTime datePosted,@JsonKey(name: 'date_modified') DateTime dateModified,@JsonKey(name: 'time_posted') String timePosted,@JsonKey(name: 'time_modified') String timeModified, bool available,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'author_detail') AuthorDetail authorDetail,@JsonKey(name: 'image_detail') ImageDetail imageDetail,@JsonKey(name: 'avg_rating') num avgRating, Country? country, StateData? state, City? city, Neighborhood? neighborhood, String author
});


$AuthorDetailCopyWith<$Res> get authorDetail;$ImageDetailCopyWith<$Res> get imageDetail;$CountryCopyWith<$Res>? get country;$StateDataCopyWith<$Res>? get state;$CityCopyWith<$Res>? get city;$NeighborhoodCopyWith<$Res>? get neighborhood;

}
/// @nodoc
class _$HouseModelCopyWithImpl<$Res>
    implements $HouseModelCopyWith<$Res> {
  _$HouseModelCopyWithImpl(this._self, this._then);

  final HouseModel _self;
  final $Res Function(HouseModel) _then;

/// Create a copy of HouseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? image = null,Object? price = null,Object? totalUnits = null,Object? title = null,Object? description = null,Object? category = null,Object? datePosted = null,Object? dateModified = null,Object? timePosted = null,Object? timeModified = null,Object? available = null,Object? isActive = null,Object? authorDetail = null,Object? imageDetail = null,Object? avgRating = null,Object? country = freezed,Object? state = freezed,Object? city = freezed,Object? neighborhood = freezed,Object? author = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,totalUnits: null == totalUnits ? _self.totalUnits : totalUnits // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,datePosted: null == datePosted ? _self.datePosted : datePosted // ignore: cast_nullable_to_non_nullable
as DateTime,dateModified: null == dateModified ? _self.dateModified : dateModified // ignore: cast_nullable_to_non_nullable
as DateTime,timePosted: null == timePosted ? _self.timePosted : timePosted // ignore: cast_nullable_to_non_nullable
as String,timeModified: null == timeModified ? _self.timeModified : timeModified // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,authorDetail: null == authorDetail ? _self.authorDetail : authorDetail // ignore: cast_nullable_to_non_nullable
as AuthorDetail,imageDetail: null == imageDetail ? _self.imageDetail : imageDetail // ignore: cast_nullable_to_non_nullable
as ImageDetail,avgRating: null == avgRating ? _self.avgRating : avgRating // ignore: cast_nullable_to_non_nullable
as num,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as StateData?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as City?,neighborhood: freezed == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as Neighborhood?,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of HouseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthorDetailCopyWith<$Res> get authorDetail {
  
  return $AuthorDetailCopyWith<$Res>(_self.authorDetail, (value) {
    return _then(_self.copyWith(authorDetail: value));
  });
}/// Create a copy of HouseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImageDetailCopyWith<$Res> get imageDetail {
  
  return $ImageDetailCopyWith<$Res>(_self.imageDetail, (value) {
    return _then(_self.copyWith(imageDetail: value));
  });
}/// Create a copy of HouseModel
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
}/// Create a copy of HouseModel
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
}/// Create a copy of HouseModel
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
}/// Create a copy of HouseModel
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


/// Adds pattern-matching-related methods to [HouseModel].
extension HouseModelPatterns on HouseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HouseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HouseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HouseModel value)  $default,){
final _that = this;
switch (_that) {
case _HouseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HouseModel value)?  $default,){
final _that = this;
switch (_that) {
case _HouseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int image,  double price, @JsonKey(name: 'total_units')  int totalUnits,  String title,  String description,  String category, @JsonKey(name: 'date_posted')  DateTime datePosted, @JsonKey(name: 'date_modified')  DateTime dateModified, @JsonKey(name: 'time_posted')  String timePosted, @JsonKey(name: 'time_modified')  String timeModified,  bool available, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'author_detail')  AuthorDetail authorDetail, @JsonKey(name: 'image_detail')  ImageDetail imageDetail, @JsonKey(name: 'avg_rating')  num avgRating,  Country? country,  StateData? state,  City? city,  Neighborhood? neighborhood,  String author)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HouseModel() when $default != null:
return $default(_that.id,_that.image,_that.price,_that.totalUnits,_that.title,_that.description,_that.category,_that.datePosted,_that.dateModified,_that.timePosted,_that.timeModified,_that.available,_that.isActive,_that.authorDetail,_that.imageDetail,_that.avgRating,_that.country,_that.state,_that.city,_that.neighborhood,_that.author);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int image,  double price, @JsonKey(name: 'total_units')  int totalUnits,  String title,  String description,  String category, @JsonKey(name: 'date_posted')  DateTime datePosted, @JsonKey(name: 'date_modified')  DateTime dateModified, @JsonKey(name: 'time_posted')  String timePosted, @JsonKey(name: 'time_modified')  String timeModified,  bool available, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'author_detail')  AuthorDetail authorDetail, @JsonKey(name: 'image_detail')  ImageDetail imageDetail, @JsonKey(name: 'avg_rating')  num avgRating,  Country? country,  StateData? state,  City? city,  Neighborhood? neighborhood,  String author)  $default,) {final _that = this;
switch (_that) {
case _HouseModel():
return $default(_that.id,_that.image,_that.price,_that.totalUnits,_that.title,_that.description,_that.category,_that.datePosted,_that.dateModified,_that.timePosted,_that.timeModified,_that.available,_that.isActive,_that.authorDetail,_that.imageDetail,_that.avgRating,_that.country,_that.state,_that.city,_that.neighborhood,_that.author);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int image,  double price, @JsonKey(name: 'total_units')  int totalUnits,  String title,  String description,  String category, @JsonKey(name: 'date_posted')  DateTime datePosted, @JsonKey(name: 'date_modified')  DateTime dateModified, @JsonKey(name: 'time_posted')  String timePosted, @JsonKey(name: 'time_modified')  String timeModified,  bool available, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'author_detail')  AuthorDetail authorDetail, @JsonKey(name: 'image_detail')  ImageDetail imageDetail, @JsonKey(name: 'avg_rating')  num avgRating,  Country? country,  StateData? state,  City? city,  Neighborhood? neighborhood,  String author)?  $default,) {final _that = this;
switch (_that) {
case _HouseModel() when $default != null:
return $default(_that.id,_that.image,_that.price,_that.totalUnits,_that.title,_that.description,_that.category,_that.datePosted,_that.dateModified,_that.timePosted,_that.timeModified,_that.available,_that.isActive,_that.authorDetail,_that.imageDetail,_that.avgRating,_that.country,_that.state,_that.city,_that.neighborhood,_that.author);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _HouseModel implements HouseModel {
  const _HouseModel({required this.id, required this.image, required this.price, @JsonKey(name: 'total_units') required this.totalUnits, required this.title, required this.description, required this.category, @JsonKey(name: 'date_posted') required this.datePosted, @JsonKey(name: 'date_modified') required this.dateModified, @JsonKey(name: 'time_posted') required this.timePosted, @JsonKey(name: 'time_modified') required this.timeModified, required this.available, @JsonKey(name: 'is_active') required this.isActive, @JsonKey(name: 'author_detail') required this.authorDetail, @JsonKey(name: 'image_detail') required this.imageDetail, @JsonKey(name: 'avg_rating') required this.avgRating, this.country, this.state, this.city, this.neighborhood, required this.author});
  factory _HouseModel.fromJson(Map<String, dynamic> json) => _$HouseModelFromJson(json);

@override final  int id;
// The ID reference to the image (int)
@override final  int image;
@override final  double price;
@override@JsonKey(name: 'total_units') final  int totalUnits;
@override final  String title;
@override final  String description;
@override final  String category;
// Dates are automatically parsed if in YYYY-MM-DD format
@override@JsonKey(name: 'date_posted') final  DateTime datePosted;
@override@JsonKey(name: 'date_modified') final  DateTime dateModified;
// Times are usually safer as Strings unless you combine them with dates
@override@JsonKey(name: 'time_posted') final  String timePosted;
@override@JsonKey(name: 'time_modified') final  String timeModified;
@override final  bool available;
@override@JsonKey(name: 'is_active') final  bool isActive;
// Nested Objects
@override@JsonKey(name: 'author_detail') final  AuthorDetail authorDetail;
@override@JsonKey(name: 'image_detail') final  ImageDetail imageDetail;
// Rating
@override@JsonKey(name: 'avg_rating') final  num avgRating;
// num handles int or double
// Location Objects (Nullable based on your JSON item #2)
@override final  Country? country;
@override final  StateData? state;
// 'State' is a Flutter keyword, so we rename the class
@override final  City? city;
@override final  Neighborhood? neighborhood;
// The flat username string
@override final  String author;

/// Create a copy of HouseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HouseModelCopyWith<_HouseModel> get copyWith => __$HouseModelCopyWithImpl<_HouseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HouseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HouseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.image, image) || other.image == image)&&(identical(other.price, price) || other.price == price)&&(identical(other.totalUnits, totalUnits) || other.totalUnits == totalUnits)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.datePosted, datePosted) || other.datePosted == datePosted)&&(identical(other.dateModified, dateModified) || other.dateModified == dateModified)&&(identical(other.timePosted, timePosted) || other.timePosted == timePosted)&&(identical(other.timeModified, timeModified) || other.timeModified == timeModified)&&(identical(other.available, available) || other.available == available)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.authorDetail, authorDetail) || other.authorDetail == authorDetail)&&(identical(other.imageDetail, imageDetail) || other.imageDetail == imageDetail)&&(identical(other.avgRating, avgRating) || other.avgRating == avgRating)&&(identical(other.country, country) || other.country == country)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.author, author) || other.author == author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,image,price,totalUnits,title,description,category,datePosted,dateModified,timePosted,timeModified,available,isActive,authorDetail,imageDetail,avgRating,country,state,city,neighborhood,author]);

@override
String toString() {
  return 'HouseModel(id: $id, image: $image, price: $price, totalUnits: $totalUnits, title: $title, description: $description, category: $category, datePosted: $datePosted, dateModified: $dateModified, timePosted: $timePosted, timeModified: $timeModified, available: $available, isActive: $isActive, authorDetail: $authorDetail, imageDetail: $imageDetail, avgRating: $avgRating, country: $country, state: $state, city: $city, neighborhood: $neighborhood, author: $author)';
}


}

/// @nodoc
abstract mixin class _$HouseModelCopyWith<$Res> implements $HouseModelCopyWith<$Res> {
  factory _$HouseModelCopyWith(_HouseModel value, $Res Function(_HouseModel) _then) = __$HouseModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int image, double price,@JsonKey(name: 'total_units') int totalUnits, String title, String description, String category,@JsonKey(name: 'date_posted') DateTime datePosted,@JsonKey(name: 'date_modified') DateTime dateModified,@JsonKey(name: 'time_posted') String timePosted,@JsonKey(name: 'time_modified') String timeModified, bool available,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'author_detail') AuthorDetail authorDetail,@JsonKey(name: 'image_detail') ImageDetail imageDetail,@JsonKey(name: 'avg_rating') num avgRating, Country? country, StateData? state, City? city, Neighborhood? neighborhood, String author
});


@override $AuthorDetailCopyWith<$Res> get authorDetail;@override $ImageDetailCopyWith<$Res> get imageDetail;@override $CountryCopyWith<$Res>? get country;@override $StateDataCopyWith<$Res>? get state;@override $CityCopyWith<$Res>? get city;@override $NeighborhoodCopyWith<$Res>? get neighborhood;

}
/// @nodoc
class __$HouseModelCopyWithImpl<$Res>
    implements _$HouseModelCopyWith<$Res> {
  __$HouseModelCopyWithImpl(this._self, this._then);

  final _HouseModel _self;
  final $Res Function(_HouseModel) _then;

/// Create a copy of HouseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? image = null,Object? price = null,Object? totalUnits = null,Object? title = null,Object? description = null,Object? category = null,Object? datePosted = null,Object? dateModified = null,Object? timePosted = null,Object? timeModified = null,Object? available = null,Object? isActive = null,Object? authorDetail = null,Object? imageDetail = null,Object? avgRating = null,Object? country = freezed,Object? state = freezed,Object? city = freezed,Object? neighborhood = freezed,Object? author = null,}) {
  return _then(_HouseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,totalUnits: null == totalUnits ? _self.totalUnits : totalUnits // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,datePosted: null == datePosted ? _self.datePosted : datePosted // ignore: cast_nullable_to_non_nullable
as DateTime,dateModified: null == dateModified ? _self.dateModified : dateModified // ignore: cast_nullable_to_non_nullable
as DateTime,timePosted: null == timePosted ? _self.timePosted : timePosted // ignore: cast_nullable_to_non_nullable
as String,timeModified: null == timeModified ? _self.timeModified : timeModified // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,authorDetail: null == authorDetail ? _self.authorDetail : authorDetail // ignore: cast_nullable_to_non_nullable
as AuthorDetail,imageDetail: null == imageDetail ? _self.imageDetail : imageDetail // ignore: cast_nullable_to_non_nullable
as ImageDetail,avgRating: null == avgRating ? _self.avgRating : avgRating // ignore: cast_nullable_to_non_nullable
as num,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as StateData?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as City?,neighborhood: freezed == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as Neighborhood?,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of HouseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthorDetailCopyWith<$Res> get authorDetail {
  
  return $AuthorDetailCopyWith<$Res>(_self.authorDetail, (value) {
    return _then(_self.copyWith(authorDetail: value));
  });
}/// Create a copy of HouseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImageDetailCopyWith<$Res> get imageDetail {
  
  return $ImageDetailCopyWith<$Res>(_self.imageDetail, (value) {
    return _then(_self.copyWith(imageDetail: value));
  });
}/// Create a copy of HouseModel
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
}/// Create a copy of HouseModel
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
}/// Create a copy of HouseModel
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
}/// Create a copy of HouseModel
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


/// @nodoc
mixin _$AuthorDetail {

 int get id; String get username; String get email;@JsonKey(name: 'user_profile') UserProfile? get userProfile;
/// Create a copy of AuthorDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthorDetailCopyWith<AuthorDetail> get copyWith => _$AuthorDetailCopyWithImpl<AuthorDetail>(this as AuthorDetail, _$identity);

  /// Serializes this AuthorDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthorDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,email,userProfile);

@override
String toString() {
  return 'AuthorDetail(id: $id, username: $username, email: $email, userProfile: $userProfile)';
}


}

/// @nodoc
abstract mixin class $AuthorDetailCopyWith<$Res>  {
  factory $AuthorDetailCopyWith(AuthorDetail value, $Res Function(AuthorDetail) _then) = _$AuthorDetailCopyWithImpl;
@useResult
$Res call({
 int id, String username, String email,@JsonKey(name: 'user_profile') UserProfile? userProfile
});


$UserProfileCopyWith<$Res>? get userProfile;

}
/// @nodoc
class _$AuthorDetailCopyWithImpl<$Res>
    implements $AuthorDetailCopyWith<$Res> {
  _$AuthorDetailCopyWithImpl(this._self, this._then);

  final AuthorDetail _self;
  final $Res Function(AuthorDetail) _then;

/// Create a copy of AuthorDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? email = null,Object? userProfile = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,userProfile: freezed == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as UserProfile?,
  ));
}
/// Create a copy of AuthorDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res>? get userProfile {
    if (_self.userProfile == null) {
    return null;
  }

  return $UserProfileCopyWith<$Res>(_self.userProfile!, (value) {
    return _then(_self.copyWith(userProfile: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthorDetail].
extension AuthorDetailPatterns on AuthorDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthorDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthorDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthorDetail value)  $default,){
final _that = this;
switch (_that) {
case _AuthorDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthorDetail value)?  $default,){
final _that = this;
switch (_that) {
case _AuthorDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String username,  String email, @JsonKey(name: 'user_profile')  UserProfile? userProfile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthorDetail() when $default != null:
return $default(_that.id,_that.username,_that.email,_that.userProfile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String username,  String email, @JsonKey(name: 'user_profile')  UserProfile? userProfile)  $default,) {final _that = this;
switch (_that) {
case _AuthorDetail():
return $default(_that.id,_that.username,_that.email,_that.userProfile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String username,  String email, @JsonKey(name: 'user_profile')  UserProfile? userProfile)?  $default,) {final _that = this;
switch (_that) {
case _AuthorDetail() when $default != null:
return $default(_that.id,_that.username,_that.email,_that.userProfile);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthorDetail implements AuthorDetail {
  const _AuthorDetail({required this.id, required this.username, required this.email, @JsonKey(name: 'user_profile') this.userProfile});
  factory _AuthorDetail.fromJson(Map<String, dynamic> json) => _$AuthorDetailFromJson(json);

@override final  int id;
@override final  String username;
@override final  String email;
@override@JsonKey(name: 'user_profile') final  UserProfile? userProfile;

/// Create a copy of AuthorDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthorDetailCopyWith<_AuthorDetail> get copyWith => __$AuthorDetailCopyWithImpl<_AuthorDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthorDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthorDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,email,userProfile);

@override
String toString() {
  return 'AuthorDetail(id: $id, username: $username, email: $email, userProfile: $userProfile)';
}


}

/// @nodoc
abstract mixin class _$AuthorDetailCopyWith<$Res> implements $AuthorDetailCopyWith<$Res> {
  factory _$AuthorDetailCopyWith(_AuthorDetail value, $Res Function(_AuthorDetail) _then) = __$AuthorDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String username, String email,@JsonKey(name: 'user_profile') UserProfile? userProfile
});


@override $UserProfileCopyWith<$Res>? get userProfile;

}
/// @nodoc
class __$AuthorDetailCopyWithImpl<$Res>
    implements _$AuthorDetailCopyWith<$Res> {
  __$AuthorDetailCopyWithImpl(this._self, this._then);

  final _AuthorDetail _self;
  final $Res Function(_AuthorDetail) _then;

/// Create a copy of AuthorDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? email = null,Object? userProfile = freezed,}) {
  return _then(_AuthorDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,userProfile: freezed == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as UserProfile?,
  ));
}

/// Create a copy of AuthorDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res>? get userProfile {
    if (_self.userProfile == null) {
    return null;
  }

  return $UserProfileCopyWith<$Res>(_self.userProfile!, (value) {
    return _then(_self.copyWith(userProfile: value));
  });
}
}


/// @nodoc
mixin _$UserProfile {

@JsonKey(name: 'phone_number') String get phoneNumber;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber);

@override
String toString() {
  return 'UserProfile(phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'phone_number') String phoneNumber
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'phone_number')  String phoneNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.phoneNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'phone_number')  String phoneNumber)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.phoneNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'phone_number')  String phoneNumber)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.phoneNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({@JsonKey(name: 'phone_number') required this.phoneNumber});
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override@JsonKey(name: 'phone_number') final  String phoneNumber;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber);

@override
String toString() {
  return 'UserProfile(phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'phone_number') String phoneNumber
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,}) {
  return _then(_UserProfile(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ImageDetail {

 int get id;@JsonKey(name: 'image_name') String get imageName; String get image;// This is the full URL
 String get author;
/// Create a copy of ImageDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageDetailCopyWith<ImageDetail> get copyWith => _$ImageDetailCopyWithImpl<ImageDetail>(this as ImageDetail, _$identity);

  /// Serializes this ImageDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.imageName, imageName) || other.imageName == imageName)&&(identical(other.image, image) || other.image == image)&&(identical(other.author, author) || other.author == author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imageName,image,author);

@override
String toString() {
  return 'ImageDetail(id: $id, imageName: $imageName, image: $image, author: $author)';
}


}

/// @nodoc
abstract mixin class $ImageDetailCopyWith<$Res>  {
  factory $ImageDetailCopyWith(ImageDetail value, $Res Function(ImageDetail) _then) = _$ImageDetailCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'image_name') String imageName, String image, String author
});




}
/// @nodoc
class _$ImageDetailCopyWithImpl<$Res>
    implements $ImageDetailCopyWith<$Res> {
  _$ImageDetailCopyWithImpl(this._self, this._then);

  final ImageDetail _self;
  final $Res Function(ImageDetail) _then;

/// Create a copy of ImageDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imageName = null,Object? image = null,Object? author = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,imageName: null == imageName ? _self.imageName : imageName // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageDetail].
extension ImageDetailPatterns on ImageDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageDetail value)  $default,){
final _that = this;
switch (_that) {
case _ImageDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageDetail value)?  $default,){
final _that = this;
switch (_that) {
case _ImageDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'image_name')  String imageName,  String image,  String author)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageDetail() when $default != null:
return $default(_that.id,_that.imageName,_that.image,_that.author);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'image_name')  String imageName,  String image,  String author)  $default,) {final _that = this;
switch (_that) {
case _ImageDetail():
return $default(_that.id,_that.imageName,_that.image,_that.author);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'image_name')  String imageName,  String image,  String author)?  $default,) {final _that = this;
switch (_that) {
case _ImageDetail() when $default != null:
return $default(_that.id,_that.imageName,_that.image,_that.author);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageDetail implements ImageDetail {
  const _ImageDetail({required this.id, @JsonKey(name: 'image_name') required this.imageName, required this.image, required this.author});
  factory _ImageDetail.fromJson(Map<String, dynamic> json) => _$ImageDetailFromJson(json);

@override final  int id;
@override@JsonKey(name: 'image_name') final  String imageName;
@override final  String image;
// This is the full URL
@override final  String author;

/// Create a copy of ImageDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageDetailCopyWith<_ImageDetail> get copyWith => __$ImageDetailCopyWithImpl<_ImageDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.imageName, imageName) || other.imageName == imageName)&&(identical(other.image, image) || other.image == image)&&(identical(other.author, author) || other.author == author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imageName,image,author);

@override
String toString() {
  return 'ImageDetail(id: $id, imageName: $imageName, image: $image, author: $author)';
}


}

/// @nodoc
abstract mixin class _$ImageDetailCopyWith<$Res> implements $ImageDetailCopyWith<$Res> {
  factory _$ImageDetailCopyWith(_ImageDetail value, $Res Function(_ImageDetail) _then) = __$ImageDetailCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'image_name') String imageName, String image, String author
});




}
/// @nodoc
class __$ImageDetailCopyWithImpl<$Res>
    implements _$ImageDetailCopyWith<$Res> {
  __$ImageDetailCopyWithImpl(this._self, this._then);

  final _ImageDetail _self;
  final $Res Function(_ImageDetail) _then;

/// Create a copy of ImageDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imageName = null,Object? image = null,Object? author = null,}) {
  return _then(_ImageDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,imageName: null == imageName ? _self.imageName : imageName // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Country {

 int get id; String get name; String get code;
/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CountryCopyWith<Country> get copyWith => _$CountryCopyWithImpl<Country>(this as Country, _$identity);

  /// Serializes this Country to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Country&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code);

@override
String toString() {
  return 'Country(id: $id, name: $name, code: $code)';
}


}

/// @nodoc
abstract mixin class $CountryCopyWith<$Res>  {
  factory $CountryCopyWith(Country value, $Res Function(Country) _then) = _$CountryCopyWithImpl;
@useResult
$Res call({
 int id, String name, String code
});




}
/// @nodoc
class _$CountryCopyWithImpl<$Res>
    implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._self, this._then);

  final Country _self;
  final $Res Function(Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Country].
extension CountryPatterns on Country {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Country value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Country() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Country value)  $default,){
final _that = this;
switch (_that) {
case _Country():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Country value)?  $default,){
final _that = this;
switch (_that) {
case _Country() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Country() when $default != null:
return $default(_that.id,_that.name,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String code)  $default,) {final _that = this;
switch (_that) {
case _Country():
return $default(_that.id,_that.name,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String code)?  $default,) {final _that = this;
switch (_that) {
case _Country() when $default != null:
return $default(_that.id,_that.name,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Country implements Country {
  const _Country({required this.id, required this.name, required this.code});
  factory _Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

@override final  int id;
@override final  String name;
@override final  String code;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountryCopyWith<_Country> get copyWith => __$CountryCopyWithImpl<_Country>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CountryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Country&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code);

@override
String toString() {
  return 'Country(id: $id, name: $name, code: $code)';
}


}

/// @nodoc
abstract mixin class _$CountryCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$CountryCopyWith(_Country value, $Res Function(_Country) _then) = __$CountryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String code
});




}
/// @nodoc
class __$CountryCopyWithImpl<$Res>
    implements _$CountryCopyWith<$Res> {
  __$CountryCopyWithImpl(this._self, this._then);

  final _Country _self;
  final $Res Function(_Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = null,}) {
  return _then(_Country(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$City {

 int get id; String get name;// 'state' might be an ID or object here? JSON shows null, assuming int? or object?
// Kept dynamic/nullable to be safe
 Object? get state; int get country;
/// Create a copy of City
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityCopyWith<City> get copyWith => _$CityCopyWithImpl<City>(this as City, _$identity);

  /// Serializes this City to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is City&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.state, state)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(state),country);

@override
String toString() {
  return 'City(id: $id, name: $name, state: $state, country: $country)';
}


}

/// @nodoc
abstract mixin class $CityCopyWith<$Res>  {
  factory $CityCopyWith(City value, $Res Function(City) _then) = _$CityCopyWithImpl;
@useResult
$Res call({
 int id, String name, Object? state, int country
});




}
/// @nodoc
class _$CityCopyWithImpl<$Res>
    implements $CityCopyWith<$Res> {
  _$CityCopyWithImpl(this._self, this._then);

  final City _self;
  final $Res Function(City) _then;

/// Create a copy of City
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? state = freezed,Object? country = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,state: freezed == state ? _self.state : state ,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [City].
extension CityPatterns on City {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _City value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _City() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _City value)  $default,){
final _that = this;
switch (_that) {
case _City():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _City value)?  $default,){
final _that = this;
switch (_that) {
case _City() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  Object? state,  int country)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _City() when $default != null:
return $default(_that.id,_that.name,_that.state,_that.country);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  Object? state,  int country)  $default,) {final _that = this;
switch (_that) {
case _City():
return $default(_that.id,_that.name,_that.state,_that.country);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  Object? state,  int country)?  $default,) {final _that = this;
switch (_that) {
case _City() when $default != null:
return $default(_that.id,_that.name,_that.state,_that.country);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _City implements City {
  const _City({required this.id, required this.name, this.state, required this.country});
  factory _City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

@override final  int id;
@override final  String name;
// 'state' might be an ID or object here? JSON shows null, assuming int? or object?
// Kept dynamic/nullable to be safe
@override final  Object? state;
@override final  int country;

/// Create a copy of City
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityCopyWith<_City> get copyWith => __$CityCopyWithImpl<_City>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _City&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.state, state)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(state),country);

@override
String toString() {
  return 'City(id: $id, name: $name, state: $state, country: $country)';
}


}

/// @nodoc
abstract mixin class _$CityCopyWith<$Res> implements $CityCopyWith<$Res> {
  factory _$CityCopyWith(_City value, $Res Function(_City) _then) = __$CityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, Object? state, int country
});




}
/// @nodoc
class __$CityCopyWithImpl<$Res>
    implements _$CityCopyWith<$Res> {
  __$CityCopyWithImpl(this._self, this._then);

  final _City _self;
  final $Res Function(_City) _then;

/// Create a copy of City
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? state = freezed,Object? country = null,}) {
  return _then(_City(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,state: freezed == state ? _self.state : state ,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Neighborhood {

 int get id; String get name; int get city;
/// Create a copy of Neighborhood
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NeighborhoodCopyWith<Neighborhood> get copyWith => _$NeighborhoodCopyWithImpl<Neighborhood>(this as Neighborhood, _$identity);

  /// Serializes this Neighborhood to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Neighborhood&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,city);

@override
String toString() {
  return 'Neighborhood(id: $id, name: $name, city: $city)';
}


}

/// @nodoc
abstract mixin class $NeighborhoodCopyWith<$Res>  {
  factory $NeighborhoodCopyWith(Neighborhood value, $Res Function(Neighborhood) _then) = _$NeighborhoodCopyWithImpl;
@useResult
$Res call({
 int id, String name, int city
});




}
/// @nodoc
class _$NeighborhoodCopyWithImpl<$Res>
    implements $NeighborhoodCopyWith<$Res> {
  _$NeighborhoodCopyWithImpl(this._self, this._then);

  final Neighborhood _self;
  final $Res Function(Neighborhood) _then;

/// Create a copy of Neighborhood
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? city = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Neighborhood].
extension NeighborhoodPatterns on Neighborhood {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Neighborhood value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Neighborhood() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Neighborhood value)  $default,){
final _that = this;
switch (_that) {
case _Neighborhood():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Neighborhood value)?  $default,){
final _that = this;
switch (_that) {
case _Neighborhood() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int city)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Neighborhood() when $default != null:
return $default(_that.id,_that.name,_that.city);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int city)  $default,) {final _that = this;
switch (_that) {
case _Neighborhood():
return $default(_that.id,_that.name,_that.city);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int city)?  $default,) {final _that = this;
switch (_that) {
case _Neighborhood() when $default != null:
return $default(_that.id,_that.name,_that.city);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Neighborhood implements Neighborhood {
  const _Neighborhood({required this.id, required this.name, required this.city});
  factory _Neighborhood.fromJson(Map<String, dynamic> json) => _$NeighborhoodFromJson(json);

@override final  int id;
@override final  String name;
@override final  int city;

/// Create a copy of Neighborhood
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NeighborhoodCopyWith<_Neighborhood> get copyWith => __$NeighborhoodCopyWithImpl<_Neighborhood>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NeighborhoodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Neighborhood&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,city);

@override
String toString() {
  return 'Neighborhood(id: $id, name: $name, city: $city)';
}


}

/// @nodoc
abstract mixin class _$NeighborhoodCopyWith<$Res> implements $NeighborhoodCopyWith<$Res> {
  factory _$NeighborhoodCopyWith(_Neighborhood value, $Res Function(_Neighborhood) _then) = __$NeighborhoodCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int city
});




}
/// @nodoc
class __$NeighborhoodCopyWithImpl<$Res>
    implements _$NeighborhoodCopyWith<$Res> {
  __$NeighborhoodCopyWithImpl(this._self, this._then);

  final _Neighborhood _self;
  final $Res Function(_Neighborhood) _then;

/// Create a copy of Neighborhood
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? city = null,}) {
  return _then(_Neighborhood(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$StateData {

 int get id; String get name;
/// Create a copy of StateData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StateDataCopyWith<StateData> get copyWith => _$StateDataCopyWithImpl<StateData>(this as StateData, _$identity);

  /// Serializes this StateData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StateData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'StateData(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $StateDataCopyWith<$Res>  {
  factory $StateDataCopyWith(StateData value, $Res Function(StateData) _then) = _$StateDataCopyWithImpl;
@useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class _$StateDataCopyWithImpl<$Res>
    implements $StateDataCopyWith<$Res> {
  _$StateDataCopyWithImpl(this._self, this._then);

  final StateData _self;
  final $Res Function(StateData) _then;

/// Create a copy of StateData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StateData].
extension StateDataPatterns on StateData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StateData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StateData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StateData value)  $default,){
final _that = this;
switch (_that) {
case _StateData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StateData value)?  $default,){
final _that = this;
switch (_that) {
case _StateData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StateData() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name)  $default,) {final _that = this;
switch (_that) {
case _StateData():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _StateData() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StateData implements StateData {
  const _StateData({required this.id, required this.name});
  factory _StateData.fromJson(Map<String, dynamic> json) => _$StateDataFromJson(json);

@override final  int id;
@override final  String name;

/// Create a copy of StateData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateDataCopyWith<_StateData> get copyWith => __$StateDataCopyWithImpl<_StateData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StateDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'StateData(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$StateDataCopyWith<$Res> implements $StateDataCopyWith<$Res> {
  factory _$StateDataCopyWith(_StateData value, $Res Function(_StateData) _then) = __$StateDataCopyWithImpl;
@override @useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class __$StateDataCopyWithImpl<$Res>
    implements _$StateDataCopyWith<$Res> {
  __$StateDataCopyWithImpl(this._self, this._then);

  final _StateData _self;
  final $Res Function(_StateData) _then;

/// Create a copy of StateData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_StateData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
