// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extra_image_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExtraImageModel {

 int get id; String get image; int get rental;
/// Create a copy of ExtraImageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExtraImageModelCopyWith<ExtraImageModel> get copyWith => _$ExtraImageModelCopyWithImpl<ExtraImageModel>(this as ExtraImageModel, _$identity);

  /// Serializes this ExtraImageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExtraImageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.image, image) || other.image == image)&&(identical(other.rental, rental) || other.rental == rental));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,image,rental);

@override
String toString() {
  return 'ExtraImageModel(id: $id, image: $image, rental: $rental)';
}


}

/// @nodoc
abstract mixin class $ExtraImageModelCopyWith<$Res>  {
  factory $ExtraImageModelCopyWith(ExtraImageModel value, $Res Function(ExtraImageModel) _then) = _$ExtraImageModelCopyWithImpl;
@useResult
$Res call({
 int id, String image, int rental
});




}
/// @nodoc
class _$ExtraImageModelCopyWithImpl<$Res>
    implements $ExtraImageModelCopyWith<$Res> {
  _$ExtraImageModelCopyWithImpl(this._self, this._then);

  final ExtraImageModel _self;
  final $Res Function(ExtraImageModel) _then;

/// Create a copy of ExtraImageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? image = null,Object? rental = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,rental: null == rental ? _self.rental : rental // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ExtraImageModel].
extension ExtraImageModelPatterns on ExtraImageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExtraImageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExtraImageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExtraImageModel value)  $default,){
final _that = this;
switch (_that) {
case _ExtraImageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExtraImageModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExtraImageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String image,  int rental)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExtraImageModel() when $default != null:
return $default(_that.id,_that.image,_that.rental);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String image,  int rental)  $default,) {final _that = this;
switch (_that) {
case _ExtraImageModel():
return $default(_that.id,_that.image,_that.rental);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String image,  int rental)?  $default,) {final _that = this;
switch (_that) {
case _ExtraImageModel() when $default != null:
return $default(_that.id,_that.image,_that.rental);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExtraImageModel implements ExtraImageModel {
  const _ExtraImageModel({required this.id, required this.image, required this.rental});
  factory _ExtraImageModel.fromJson(Map<String, dynamic> json) => _$ExtraImageModelFromJson(json);

@override final  int id;
@override final  String image;
@override final  int rental;

/// Create a copy of ExtraImageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExtraImageModelCopyWith<_ExtraImageModel> get copyWith => __$ExtraImageModelCopyWithImpl<_ExtraImageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExtraImageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExtraImageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.image, image) || other.image == image)&&(identical(other.rental, rental) || other.rental == rental));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,image,rental);

@override
String toString() {
  return 'ExtraImageModel(id: $id, image: $image, rental: $rental)';
}


}

/// @nodoc
abstract mixin class _$ExtraImageModelCopyWith<$Res> implements $ExtraImageModelCopyWith<$Res> {
  factory _$ExtraImageModelCopyWith(_ExtraImageModel value, $Res Function(_ExtraImageModel) _then) = __$ExtraImageModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String image, int rental
});




}
/// @nodoc
class __$ExtraImageModelCopyWithImpl<$Res>
    implements _$ExtraImageModelCopyWith<$Res> {
  __$ExtraImageModelCopyWithImpl(this._self, this._then);

  final _ExtraImageModel _self;
  final $Res Function(_ExtraImageModel) _then;

/// Create a copy of ExtraImageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? image = null,Object? rental = null,}) {
  return _then(_ExtraImageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,rental: null == rental ? _self.rental : rental // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
