// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductDto {

 int? get id; String? get title; String? get description; String? get category; double? get price; double? get discountPercentage; double? get rating; int? get stock; List<String>? get tags; String? get brand; String? get sku; ProductDimensionDto? get dimensions; String? get warrantyInformation; String? get shippingInformation; String? get availabilityStatus; List<ProductReviewDto>? get reviews; String? get returnPolicy; int? get minimumOrderQuantity; Map<String, dynamic>? get meta; String? get thumbnail; List<String>? get images;
/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDtoCopyWith<ProductDto> get copyWith => _$ProductDtoCopyWithImpl<ProductDto>(this as ProductDto, _$identity);

  /// Serializes this ProductDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.stock, stock) || other.stock == stock)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.dimensions, dimensions) || other.dimensions == dimensions)&&(identical(other.warrantyInformation, warrantyInformation) || other.warrantyInformation == warrantyInformation)&&(identical(other.shippingInformation, shippingInformation) || other.shippingInformation == shippingInformation)&&(identical(other.availabilityStatus, availabilityStatus) || other.availabilityStatus == availabilityStatus)&&const DeepCollectionEquality().equals(other.reviews, reviews)&&(identical(other.returnPolicy, returnPolicy) || other.returnPolicy == returnPolicy)&&(identical(other.minimumOrderQuantity, minimumOrderQuantity) || other.minimumOrderQuantity == minimumOrderQuantity)&&const DeepCollectionEquality().equals(other.meta, meta)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&const DeepCollectionEquality().equals(other.images, images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,category,price,discountPercentage,rating,stock,const DeepCollectionEquality().hash(tags),brand,sku,dimensions,warrantyInformation,shippingInformation,availabilityStatus,const DeepCollectionEquality().hash(reviews),returnPolicy,minimumOrderQuantity,const DeepCollectionEquality().hash(meta),thumbnail,const DeepCollectionEquality().hash(images)]);

@override
String toString() {
  return 'ProductDto(id: $id, title: $title, description: $description, category: $category, price: $price, discountPercentage: $discountPercentage, rating: $rating, stock: $stock, tags: $tags, brand: $brand, sku: $sku, dimensions: $dimensions, warrantyInformation: $warrantyInformation, shippingInformation: $shippingInformation, availabilityStatus: $availabilityStatus, reviews: $reviews, returnPolicy: $returnPolicy, minimumOrderQuantity: $minimumOrderQuantity, meta: $meta, thumbnail: $thumbnail, images: $images)';
}


}

/// @nodoc
abstract mixin class $ProductDtoCopyWith<$Res>  {
  factory $ProductDtoCopyWith(ProductDto value, $Res Function(ProductDto) _then) = _$ProductDtoCopyWithImpl;
@useResult
$Res call({
 int? id, String? title, String? description, String? category, double? price, double? discountPercentage, double? rating, int? stock, List<String>? tags, String? brand, String? sku, ProductDimensionDto? dimensions, String? warrantyInformation, String? shippingInformation, String? availabilityStatus, List<ProductReviewDto>? reviews, String? returnPolicy, int? minimumOrderQuantity, Map<String, dynamic>? meta, String? thumbnail, List<String>? images
});


$ProductDimensionDtoCopyWith<$Res>? get dimensions;

}
/// @nodoc
class _$ProductDtoCopyWithImpl<$Res>
    implements $ProductDtoCopyWith<$Res> {
  _$ProductDtoCopyWithImpl(this._self, this._then);

  final ProductDto _self;
  final $Res Function(ProductDto) _then;

/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = freezed,Object? description = freezed,Object? category = freezed,Object? price = freezed,Object? discountPercentage = freezed,Object? rating = freezed,Object? stock = freezed,Object? tags = freezed,Object? brand = freezed,Object? sku = freezed,Object? dimensions = freezed,Object? warrantyInformation = freezed,Object? shippingInformation = freezed,Object? availabilityStatus = freezed,Object? reviews = freezed,Object? returnPolicy = freezed,Object? minimumOrderQuantity = freezed,Object? meta = freezed,Object? thumbnail = freezed,Object? images = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,dimensions: freezed == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as ProductDimensionDto?,warrantyInformation: freezed == warrantyInformation ? _self.warrantyInformation : warrantyInformation // ignore: cast_nullable_to_non_nullable
as String?,shippingInformation: freezed == shippingInformation ? _self.shippingInformation : shippingInformation // ignore: cast_nullable_to_non_nullable
as String?,availabilityStatus: freezed == availabilityStatus ? _self.availabilityStatus : availabilityStatus // ignore: cast_nullable_to_non_nullable
as String?,reviews: freezed == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ProductReviewDto>?,returnPolicy: freezed == returnPolicy ? _self.returnPolicy : returnPolicy // ignore: cast_nullable_to_non_nullable
as String?,minimumOrderQuantity: freezed == minimumOrderQuantity ? _self.minimumOrderQuantity : minimumOrderQuantity // ignore: cast_nullable_to_non_nullable
as int?,meta: freezed == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,thumbnail: freezed == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String?,images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}
/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductDimensionDtoCopyWith<$Res>? get dimensions {
    if (_self.dimensions == null) {
    return null;
  }

  return $ProductDimensionDtoCopyWith<$Res>(_self.dimensions!, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProductDto].
extension ProductDtoPatterns on ProductDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductDto value)  $default,){
final _that = this;
switch (_that) {
case _ProductDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? title,  String? description,  String? category,  double? price,  double? discountPercentage,  double? rating,  int? stock,  List<String>? tags,  String? brand,  String? sku,  ProductDimensionDto? dimensions,  String? warrantyInformation,  String? shippingInformation,  String? availabilityStatus,  List<ProductReviewDto>? reviews,  String? returnPolicy,  int? minimumOrderQuantity,  Map<String, dynamic>? meta,  String? thumbnail,  List<String>? images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.price,_that.discountPercentage,_that.rating,_that.stock,_that.tags,_that.brand,_that.sku,_that.dimensions,_that.warrantyInformation,_that.shippingInformation,_that.availabilityStatus,_that.reviews,_that.returnPolicy,_that.minimumOrderQuantity,_that.meta,_that.thumbnail,_that.images);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? title,  String? description,  String? category,  double? price,  double? discountPercentage,  double? rating,  int? stock,  List<String>? tags,  String? brand,  String? sku,  ProductDimensionDto? dimensions,  String? warrantyInformation,  String? shippingInformation,  String? availabilityStatus,  List<ProductReviewDto>? reviews,  String? returnPolicy,  int? minimumOrderQuantity,  Map<String, dynamic>? meta,  String? thumbnail,  List<String>? images)  $default,) {final _that = this;
switch (_that) {
case _ProductDto():
return $default(_that.id,_that.title,_that.description,_that.category,_that.price,_that.discountPercentage,_that.rating,_that.stock,_that.tags,_that.brand,_that.sku,_that.dimensions,_that.warrantyInformation,_that.shippingInformation,_that.availabilityStatus,_that.reviews,_that.returnPolicy,_that.minimumOrderQuantity,_that.meta,_that.thumbnail,_that.images);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? title,  String? description,  String? category,  double? price,  double? discountPercentage,  double? rating,  int? stock,  List<String>? tags,  String? brand,  String? sku,  ProductDimensionDto? dimensions,  String? warrantyInformation,  String? shippingInformation,  String? availabilityStatus,  List<ProductReviewDto>? reviews,  String? returnPolicy,  int? minimumOrderQuantity,  Map<String, dynamic>? meta,  String? thumbnail,  List<String>? images)?  $default,) {final _that = this;
switch (_that) {
case _ProductDto() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.price,_that.discountPercentage,_that.rating,_that.stock,_that.tags,_that.brand,_that.sku,_that.dimensions,_that.warrantyInformation,_that.shippingInformation,_that.availabilityStatus,_that.reviews,_that.returnPolicy,_that.minimumOrderQuantity,_that.meta,_that.thumbnail,_that.images);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductDto implements ProductDto {
  const _ProductDto({this.id, this.title, this.description, this.category, this.price, this.discountPercentage, this.rating, this.stock, final  List<String>? tags, this.brand, this.sku, this.dimensions, this.warrantyInformation, this.shippingInformation, this.availabilityStatus, final  List<ProductReviewDto>? reviews, this.returnPolicy, this.minimumOrderQuantity, final  Map<String, dynamic>? meta, this.thumbnail, final  List<String>? images}): _tags = tags,_reviews = reviews,_meta = meta,_images = images;
  factory _ProductDto.fromJson(Map<String, dynamic> json) => _$ProductDtoFromJson(json);

@override final  int? id;
@override final  String? title;
@override final  String? description;
@override final  String? category;
@override final  double? price;
@override final  double? discountPercentage;
@override final  double? rating;
@override final  int? stock;
 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? brand;
@override final  String? sku;
@override final  ProductDimensionDto? dimensions;
@override final  String? warrantyInformation;
@override final  String? shippingInformation;
@override final  String? availabilityStatus;
 final  List<ProductReviewDto>? _reviews;
@override List<ProductReviewDto>? get reviews {
  final value = _reviews;
  if (value == null) return null;
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? returnPolicy;
@override final  int? minimumOrderQuantity;
 final  Map<String, dynamic>? _meta;
@override Map<String, dynamic>? get meta {
  final value = _meta;
  if (value == null) return null;
  if (_meta is EqualUnmodifiableMapView) return _meta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? thumbnail;
 final  List<String>? _images;
@override List<String>? get images {
  final value = _images;
  if (value == null) return null;
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDtoCopyWith<_ProductDto> get copyWith => __$ProductDtoCopyWithImpl<_ProductDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.stock, stock) || other.stock == stock)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.dimensions, dimensions) || other.dimensions == dimensions)&&(identical(other.warrantyInformation, warrantyInformation) || other.warrantyInformation == warrantyInformation)&&(identical(other.shippingInformation, shippingInformation) || other.shippingInformation == shippingInformation)&&(identical(other.availabilityStatus, availabilityStatus) || other.availabilityStatus == availabilityStatus)&&const DeepCollectionEquality().equals(other._reviews, _reviews)&&(identical(other.returnPolicy, returnPolicy) || other.returnPolicy == returnPolicy)&&(identical(other.minimumOrderQuantity, minimumOrderQuantity) || other.minimumOrderQuantity == minimumOrderQuantity)&&const DeepCollectionEquality().equals(other._meta, _meta)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&const DeepCollectionEquality().equals(other._images, _images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,category,price,discountPercentage,rating,stock,const DeepCollectionEquality().hash(_tags),brand,sku,dimensions,warrantyInformation,shippingInformation,availabilityStatus,const DeepCollectionEquality().hash(_reviews),returnPolicy,minimumOrderQuantity,const DeepCollectionEquality().hash(_meta),thumbnail,const DeepCollectionEquality().hash(_images)]);

@override
String toString() {
  return 'ProductDto(id: $id, title: $title, description: $description, category: $category, price: $price, discountPercentage: $discountPercentage, rating: $rating, stock: $stock, tags: $tags, brand: $brand, sku: $sku, dimensions: $dimensions, warrantyInformation: $warrantyInformation, shippingInformation: $shippingInformation, availabilityStatus: $availabilityStatus, reviews: $reviews, returnPolicy: $returnPolicy, minimumOrderQuantity: $minimumOrderQuantity, meta: $meta, thumbnail: $thumbnail, images: $images)';
}


}

/// @nodoc
abstract mixin class _$ProductDtoCopyWith<$Res> implements $ProductDtoCopyWith<$Res> {
  factory _$ProductDtoCopyWith(_ProductDto value, $Res Function(_ProductDto) _then) = __$ProductDtoCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? title, String? description, String? category, double? price, double? discountPercentage, double? rating, int? stock, List<String>? tags, String? brand, String? sku, ProductDimensionDto? dimensions, String? warrantyInformation, String? shippingInformation, String? availabilityStatus, List<ProductReviewDto>? reviews, String? returnPolicy, int? minimumOrderQuantity, Map<String, dynamic>? meta, String? thumbnail, List<String>? images
});


@override $ProductDimensionDtoCopyWith<$Res>? get dimensions;

}
/// @nodoc
class __$ProductDtoCopyWithImpl<$Res>
    implements _$ProductDtoCopyWith<$Res> {
  __$ProductDtoCopyWithImpl(this._self, this._then);

  final _ProductDto _self;
  final $Res Function(_ProductDto) _then;

/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = freezed,Object? description = freezed,Object? category = freezed,Object? price = freezed,Object? discountPercentage = freezed,Object? rating = freezed,Object? stock = freezed,Object? tags = freezed,Object? brand = freezed,Object? sku = freezed,Object? dimensions = freezed,Object? warrantyInformation = freezed,Object? shippingInformation = freezed,Object? availabilityStatus = freezed,Object? reviews = freezed,Object? returnPolicy = freezed,Object? minimumOrderQuantity = freezed,Object? meta = freezed,Object? thumbnail = freezed,Object? images = freezed,}) {
  return _then(_ProductDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,dimensions: freezed == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as ProductDimensionDto?,warrantyInformation: freezed == warrantyInformation ? _self.warrantyInformation : warrantyInformation // ignore: cast_nullable_to_non_nullable
as String?,shippingInformation: freezed == shippingInformation ? _self.shippingInformation : shippingInformation // ignore: cast_nullable_to_non_nullable
as String?,availabilityStatus: freezed == availabilityStatus ? _self.availabilityStatus : availabilityStatus // ignore: cast_nullable_to_non_nullable
as String?,reviews: freezed == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ProductReviewDto>?,returnPolicy: freezed == returnPolicy ? _self.returnPolicy : returnPolicy // ignore: cast_nullable_to_non_nullable
as String?,minimumOrderQuantity: freezed == minimumOrderQuantity ? _self.minimumOrderQuantity : minimumOrderQuantity // ignore: cast_nullable_to_non_nullable
as int?,meta: freezed == meta ? _self._meta : meta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,thumbnail: freezed == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String?,images: freezed == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

/// Create a copy of ProductDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductDimensionDtoCopyWith<$Res>? get dimensions {
    if (_self.dimensions == null) {
    return null;
  }

  return $ProductDimensionDtoCopyWith<$Res>(_self.dimensions!, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}
}


/// @nodoc
mixin _$ProductReviewDto {

 int? get rating; String? get comment; String? get date; String? get reviewerName; String? get reviewerEmail;
/// Create a copy of ProductReviewDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductReviewDtoCopyWith<ProductReviewDto> get copyWith => _$ProductReviewDtoCopyWithImpl<ProductReviewDto>(this as ProductReviewDto, _$identity);

  /// Serializes this ProductReviewDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductReviewDto&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.date, date) || other.date == date)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.reviewerEmail, reviewerEmail) || other.reviewerEmail == reviewerEmail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,comment,date,reviewerName,reviewerEmail);

@override
String toString() {
  return 'ProductReviewDto(rating: $rating, comment: $comment, date: $date, reviewerName: $reviewerName, reviewerEmail: $reviewerEmail)';
}


}

/// @nodoc
abstract mixin class $ProductReviewDtoCopyWith<$Res>  {
  factory $ProductReviewDtoCopyWith(ProductReviewDto value, $Res Function(ProductReviewDto) _then) = _$ProductReviewDtoCopyWithImpl;
@useResult
$Res call({
 int? rating, String? comment, String? date, String? reviewerName, String? reviewerEmail
});




}
/// @nodoc
class _$ProductReviewDtoCopyWithImpl<$Res>
    implements $ProductReviewDtoCopyWith<$Res> {
  _$ProductReviewDtoCopyWithImpl(this._self, this._then);

  final ProductReviewDto _self;
  final $Res Function(ProductReviewDto) _then;

/// Create a copy of ProductReviewDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rating = freezed,Object? comment = freezed,Object? date = freezed,Object? reviewerName = freezed,Object? reviewerEmail = freezed,}) {
  return _then(_self.copyWith(
rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,reviewerName: freezed == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String?,reviewerEmail: freezed == reviewerEmail ? _self.reviewerEmail : reviewerEmail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductReviewDto].
extension ProductReviewDtoPatterns on ProductReviewDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductReviewDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductReviewDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductReviewDto value)  $default,){
final _that = this;
switch (_that) {
case _ProductReviewDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductReviewDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProductReviewDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? rating,  String? comment,  String? date,  String? reviewerName,  String? reviewerEmail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductReviewDto() when $default != null:
return $default(_that.rating,_that.comment,_that.date,_that.reviewerName,_that.reviewerEmail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? rating,  String? comment,  String? date,  String? reviewerName,  String? reviewerEmail)  $default,) {final _that = this;
switch (_that) {
case _ProductReviewDto():
return $default(_that.rating,_that.comment,_that.date,_that.reviewerName,_that.reviewerEmail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? rating,  String? comment,  String? date,  String? reviewerName,  String? reviewerEmail)?  $default,) {final _that = this;
switch (_that) {
case _ProductReviewDto() when $default != null:
return $default(_that.rating,_that.comment,_that.date,_that.reviewerName,_that.reviewerEmail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductReviewDto implements ProductReviewDto {
  const _ProductReviewDto({this.rating, this.comment, this.date, this.reviewerName, this.reviewerEmail});
  factory _ProductReviewDto.fromJson(Map<String, dynamic> json) => _$ProductReviewDtoFromJson(json);

@override final  int? rating;
@override final  String? comment;
@override final  String? date;
@override final  String? reviewerName;
@override final  String? reviewerEmail;

/// Create a copy of ProductReviewDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductReviewDtoCopyWith<_ProductReviewDto> get copyWith => __$ProductReviewDtoCopyWithImpl<_ProductReviewDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductReviewDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductReviewDto&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.date, date) || other.date == date)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.reviewerEmail, reviewerEmail) || other.reviewerEmail == reviewerEmail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,comment,date,reviewerName,reviewerEmail);

@override
String toString() {
  return 'ProductReviewDto(rating: $rating, comment: $comment, date: $date, reviewerName: $reviewerName, reviewerEmail: $reviewerEmail)';
}


}

/// @nodoc
abstract mixin class _$ProductReviewDtoCopyWith<$Res> implements $ProductReviewDtoCopyWith<$Res> {
  factory _$ProductReviewDtoCopyWith(_ProductReviewDto value, $Res Function(_ProductReviewDto) _then) = __$ProductReviewDtoCopyWithImpl;
@override @useResult
$Res call({
 int? rating, String? comment, String? date, String? reviewerName, String? reviewerEmail
});




}
/// @nodoc
class __$ProductReviewDtoCopyWithImpl<$Res>
    implements _$ProductReviewDtoCopyWith<$Res> {
  __$ProductReviewDtoCopyWithImpl(this._self, this._then);

  final _ProductReviewDto _self;
  final $Res Function(_ProductReviewDto) _then;

/// Create a copy of ProductReviewDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rating = freezed,Object? comment = freezed,Object? date = freezed,Object? reviewerName = freezed,Object? reviewerEmail = freezed,}) {
  return _then(_ProductReviewDto(
rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,reviewerName: freezed == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String?,reviewerEmail: freezed == reviewerEmail ? _self.reviewerEmail : reviewerEmail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProductDimensionDto {

 double? get width; double? get height; double? get depth;
/// Create a copy of ProductDimensionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDimensionDtoCopyWith<ProductDimensionDto> get copyWith => _$ProductDimensionDtoCopyWithImpl<ProductDimensionDto>(this as ProductDimensionDto, _$identity);

  /// Serializes this ProductDimensionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDimensionDto&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.depth, depth) || other.depth == depth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,width,height,depth);

@override
String toString() {
  return 'ProductDimensionDto(width: $width, height: $height, depth: $depth)';
}


}

/// @nodoc
abstract mixin class $ProductDimensionDtoCopyWith<$Res>  {
  factory $ProductDimensionDtoCopyWith(ProductDimensionDto value, $Res Function(ProductDimensionDto) _then) = _$ProductDimensionDtoCopyWithImpl;
@useResult
$Res call({
 double? width, double? height, double? depth
});




}
/// @nodoc
class _$ProductDimensionDtoCopyWithImpl<$Res>
    implements $ProductDimensionDtoCopyWith<$Res> {
  _$ProductDimensionDtoCopyWithImpl(this._self, this._then);

  final ProductDimensionDto _self;
  final $Res Function(ProductDimensionDto) _then;

/// Create a copy of ProductDimensionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? width = freezed,Object? height = freezed,Object? depth = freezed,}) {
  return _then(_self.copyWith(
width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductDimensionDto].
extension ProductDimensionDtoPatterns on ProductDimensionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductDimensionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductDimensionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductDimensionDto value)  $default,){
final _that = this;
switch (_that) {
case _ProductDimensionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductDimensionDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProductDimensionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? width,  double? height,  double? depth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductDimensionDto() when $default != null:
return $default(_that.width,_that.height,_that.depth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? width,  double? height,  double? depth)  $default,) {final _that = this;
switch (_that) {
case _ProductDimensionDto():
return $default(_that.width,_that.height,_that.depth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? width,  double? height,  double? depth)?  $default,) {final _that = this;
switch (_that) {
case _ProductDimensionDto() when $default != null:
return $default(_that.width,_that.height,_that.depth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductDimensionDto implements ProductDimensionDto {
  const _ProductDimensionDto({this.width, this.height, this.depth});
  factory _ProductDimensionDto.fromJson(Map<String, dynamic> json) => _$ProductDimensionDtoFromJson(json);

@override final  double? width;
@override final  double? height;
@override final  double? depth;

/// Create a copy of ProductDimensionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDimensionDtoCopyWith<_ProductDimensionDto> get copyWith => __$ProductDimensionDtoCopyWithImpl<_ProductDimensionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductDimensionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDimensionDto&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.depth, depth) || other.depth == depth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,width,height,depth);

@override
String toString() {
  return 'ProductDimensionDto(width: $width, height: $height, depth: $depth)';
}


}

/// @nodoc
abstract mixin class _$ProductDimensionDtoCopyWith<$Res> implements $ProductDimensionDtoCopyWith<$Res> {
  factory _$ProductDimensionDtoCopyWith(_ProductDimensionDto value, $Res Function(_ProductDimensionDto) _then) = __$ProductDimensionDtoCopyWithImpl;
@override @useResult
$Res call({
 double? width, double? height, double? depth
});




}
/// @nodoc
class __$ProductDimensionDtoCopyWithImpl<$Res>
    implements _$ProductDimensionDtoCopyWith<$Res> {
  __$ProductDimensionDtoCopyWithImpl(this._self, this._then);

  final _ProductDimensionDto _self;
  final $Res Function(_ProductDimensionDto) _then;

/// Create a copy of ProductDimensionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? width = freezed,Object? height = freezed,Object? depth = freezed,}) {
  return _then(_ProductDimensionDto(
width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$ProductListDto {

 List<ProductDto>? get products; int? get total; int? get skip; int? get limit;
/// Create a copy of ProductListDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductListDtoCopyWith<ProductListDto> get copyWith => _$ProductListDtoCopyWithImpl<ProductListDto>(this as ProductListDto, _$identity);

  /// Serializes this ProductListDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductListDto&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(products),total,skip,limit);

@override
String toString() {
  return 'ProductListDto(products: $products, total: $total, skip: $skip, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $ProductListDtoCopyWith<$Res>  {
  factory $ProductListDtoCopyWith(ProductListDto value, $Res Function(ProductListDto) _then) = _$ProductListDtoCopyWithImpl;
@useResult
$Res call({
 List<ProductDto>? products, int? total, int? skip, int? limit
});




}
/// @nodoc
class _$ProductListDtoCopyWithImpl<$Res>
    implements $ProductListDtoCopyWith<$Res> {
  _$ProductListDtoCopyWithImpl(this._self, this._then);

  final ProductListDto _self;
  final $Res Function(ProductListDto) _then;

/// Create a copy of ProductListDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? products = freezed,Object? total = freezed,Object? skip = freezed,Object? limit = freezed,}) {
  return _then(_self.copyWith(
products: freezed == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductDto>?,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int?,skip: freezed == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductListDto].
extension ProductListDtoPatterns on ProductListDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductListDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductListDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductListDto value)  $default,){
final _that = this;
switch (_that) {
case _ProductListDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductListDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProductListDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProductDto>? products,  int? total,  int? skip,  int? limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductListDto() when $default != null:
return $default(_that.products,_that.total,_that.skip,_that.limit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProductDto>? products,  int? total,  int? skip,  int? limit)  $default,) {final _that = this;
switch (_that) {
case _ProductListDto():
return $default(_that.products,_that.total,_that.skip,_that.limit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProductDto>? products,  int? total,  int? skip,  int? limit)?  $default,) {final _that = this;
switch (_that) {
case _ProductListDto() when $default != null:
return $default(_that.products,_that.total,_that.skip,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductListDto implements ProductListDto {
  const _ProductListDto({final  List<ProductDto>? products, this.total, this.skip, this.limit}): _products = products;
  factory _ProductListDto.fromJson(Map<String, dynamic> json) => _$ProductListDtoFromJson(json);

 final  List<ProductDto>? _products;
@override List<ProductDto>? get products {
  final value = _products;
  if (value == null) return null;
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? total;
@override final  int? skip;
@override final  int? limit;

/// Create a copy of ProductListDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductListDtoCopyWith<_ProductListDto> get copyWith => __$ProductListDtoCopyWithImpl<_ProductListDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductListDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductListDto&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),total,skip,limit);

@override
String toString() {
  return 'ProductListDto(products: $products, total: $total, skip: $skip, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$ProductListDtoCopyWith<$Res> implements $ProductListDtoCopyWith<$Res> {
  factory _$ProductListDtoCopyWith(_ProductListDto value, $Res Function(_ProductListDto) _then) = __$ProductListDtoCopyWithImpl;
@override @useResult
$Res call({
 List<ProductDto>? products, int? total, int? skip, int? limit
});




}
/// @nodoc
class __$ProductListDtoCopyWithImpl<$Res>
    implements _$ProductListDtoCopyWith<$Res> {
  __$ProductListDtoCopyWithImpl(this._self, this._then);

  final _ProductListDto _self;
  final $Res Function(_ProductListDto) _then;

/// Create a copy of ProductListDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? products = freezed,Object? total = freezed,Object? skip = freezed,Object? limit = freezed,}) {
  return _then(_ProductListDto(
products: freezed == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductDto>?,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int?,skip: freezed == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$NewProductDto {

 String get title; String get description; String get category; double get price; double get discountPercentage; List<String> get tags; String get brand; String get sku; ProductDimensionDto? get dimensions; String? get warrantyInformation; String? get shippingInformation; String? get availabilityStatus; String? get returnPolicy; int get minimumOrderQuantity; Map<String, dynamic>? get meta; String get thumbnail; List<String> get images;
/// Create a copy of NewProductDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewProductDtoCopyWith<NewProductDto> get copyWith => _$NewProductDtoCopyWithImpl<NewProductDto>(this as NewProductDto, _$identity);

  /// Serializes this NewProductDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewProductDto&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.dimensions, dimensions) || other.dimensions == dimensions)&&(identical(other.warrantyInformation, warrantyInformation) || other.warrantyInformation == warrantyInformation)&&(identical(other.shippingInformation, shippingInformation) || other.shippingInformation == shippingInformation)&&(identical(other.availabilityStatus, availabilityStatus) || other.availabilityStatus == availabilityStatus)&&(identical(other.returnPolicy, returnPolicy) || other.returnPolicy == returnPolicy)&&(identical(other.minimumOrderQuantity, minimumOrderQuantity) || other.minimumOrderQuantity == minimumOrderQuantity)&&const DeepCollectionEquality().equals(other.meta, meta)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&const DeepCollectionEquality().equals(other.images, images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,category,price,discountPercentage,const DeepCollectionEquality().hash(tags),brand,sku,dimensions,warrantyInformation,shippingInformation,availabilityStatus,returnPolicy,minimumOrderQuantity,const DeepCollectionEquality().hash(meta),thumbnail,const DeepCollectionEquality().hash(images));

@override
String toString() {
  return 'NewProductDto(title: $title, description: $description, category: $category, price: $price, discountPercentage: $discountPercentage, tags: $tags, brand: $brand, sku: $sku, dimensions: $dimensions, warrantyInformation: $warrantyInformation, shippingInformation: $shippingInformation, availabilityStatus: $availabilityStatus, returnPolicy: $returnPolicy, minimumOrderQuantity: $minimumOrderQuantity, meta: $meta, thumbnail: $thumbnail, images: $images)';
}


}

/// @nodoc
abstract mixin class $NewProductDtoCopyWith<$Res>  {
  factory $NewProductDtoCopyWith(NewProductDto value, $Res Function(NewProductDto) _then) = _$NewProductDtoCopyWithImpl;
@useResult
$Res call({
 String title, String description, String category, double price, double discountPercentage, List<String> tags, String brand, String sku, ProductDimensionDto? dimensions, String? warrantyInformation, String? shippingInformation, String? availabilityStatus, String? returnPolicy, int minimumOrderQuantity, Map<String, dynamic>? meta, String thumbnail, List<String> images
});


$ProductDimensionDtoCopyWith<$Res>? get dimensions;

}
/// @nodoc
class _$NewProductDtoCopyWithImpl<$Res>
    implements $NewProductDtoCopyWith<$Res> {
  _$NewProductDtoCopyWithImpl(this._self, this._then);

  final NewProductDto _self;
  final $Res Function(NewProductDto) _then;

/// Create a copy of NewProductDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? category = null,Object? price = null,Object? discountPercentage = null,Object? tags = null,Object? brand = null,Object? sku = null,Object? dimensions = freezed,Object? warrantyInformation = freezed,Object? shippingInformation = freezed,Object? availabilityStatus = freezed,Object? returnPolicy = freezed,Object? minimumOrderQuantity = null,Object? meta = freezed,Object? thumbnail = null,Object? images = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,dimensions: freezed == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as ProductDimensionDto?,warrantyInformation: freezed == warrantyInformation ? _self.warrantyInformation : warrantyInformation // ignore: cast_nullable_to_non_nullable
as String?,shippingInformation: freezed == shippingInformation ? _self.shippingInformation : shippingInformation // ignore: cast_nullable_to_non_nullable
as String?,availabilityStatus: freezed == availabilityStatus ? _self.availabilityStatus : availabilityStatus // ignore: cast_nullable_to_non_nullable
as String?,returnPolicy: freezed == returnPolicy ? _self.returnPolicy : returnPolicy // ignore: cast_nullable_to_non_nullable
as String?,minimumOrderQuantity: null == minimumOrderQuantity ? _self.minimumOrderQuantity : minimumOrderQuantity // ignore: cast_nullable_to_non_nullable
as int,meta: freezed == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of NewProductDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductDimensionDtoCopyWith<$Res>? get dimensions {
    if (_self.dimensions == null) {
    return null;
  }

  return $ProductDimensionDtoCopyWith<$Res>(_self.dimensions!, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}
}


/// Adds pattern-matching-related methods to [NewProductDto].
extension NewProductDtoPatterns on NewProductDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewProductDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewProductDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewProductDto value)  $default,){
final _that = this;
switch (_that) {
case _NewProductDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewProductDto value)?  $default,){
final _that = this;
switch (_that) {
case _NewProductDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  String category,  double price,  double discountPercentage,  List<String> tags,  String brand,  String sku,  ProductDimensionDto? dimensions,  String? warrantyInformation,  String? shippingInformation,  String? availabilityStatus,  String? returnPolicy,  int minimumOrderQuantity,  Map<String, dynamic>? meta,  String thumbnail,  List<String> images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewProductDto() when $default != null:
return $default(_that.title,_that.description,_that.category,_that.price,_that.discountPercentage,_that.tags,_that.brand,_that.sku,_that.dimensions,_that.warrantyInformation,_that.shippingInformation,_that.availabilityStatus,_that.returnPolicy,_that.minimumOrderQuantity,_that.meta,_that.thumbnail,_that.images);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  String category,  double price,  double discountPercentage,  List<String> tags,  String brand,  String sku,  ProductDimensionDto? dimensions,  String? warrantyInformation,  String? shippingInformation,  String? availabilityStatus,  String? returnPolicy,  int minimumOrderQuantity,  Map<String, dynamic>? meta,  String thumbnail,  List<String> images)  $default,) {final _that = this;
switch (_that) {
case _NewProductDto():
return $default(_that.title,_that.description,_that.category,_that.price,_that.discountPercentage,_that.tags,_that.brand,_that.sku,_that.dimensions,_that.warrantyInformation,_that.shippingInformation,_that.availabilityStatus,_that.returnPolicy,_that.minimumOrderQuantity,_that.meta,_that.thumbnail,_that.images);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  String category,  double price,  double discountPercentage,  List<String> tags,  String brand,  String sku,  ProductDimensionDto? dimensions,  String? warrantyInformation,  String? shippingInformation,  String? availabilityStatus,  String? returnPolicy,  int minimumOrderQuantity,  Map<String, dynamic>? meta,  String thumbnail,  List<String> images)?  $default,) {final _that = this;
switch (_that) {
case _NewProductDto() when $default != null:
return $default(_that.title,_that.description,_that.category,_that.price,_that.discountPercentage,_that.tags,_that.brand,_that.sku,_that.dimensions,_that.warrantyInformation,_that.shippingInformation,_that.availabilityStatus,_that.returnPolicy,_that.minimumOrderQuantity,_that.meta,_that.thumbnail,_that.images);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewProductDto implements NewProductDto {
  const _NewProductDto({required this.title, required this.description, required this.category, this.price = 0.0, this.discountPercentage = 0.0, required final  List<String> tags, required this.brand, required this.sku, required this.dimensions, required this.warrantyInformation, required this.shippingInformation, required this.availabilityStatus, required this.returnPolicy, required this.minimumOrderQuantity, final  Map<String, dynamic>? meta, required this.thumbnail, required final  List<String> images}): _tags = tags,_meta = meta,_images = images;
  factory _NewProductDto.fromJson(Map<String, dynamic> json) => _$NewProductDtoFromJson(json);

@override final  String title;
@override final  String description;
@override final  String category;
@override@JsonKey() final  double price;
@override@JsonKey() final  double discountPercentage;
 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String brand;
@override final  String sku;
@override final  ProductDimensionDto? dimensions;
@override final  String? warrantyInformation;
@override final  String? shippingInformation;
@override final  String? availabilityStatus;
@override final  String? returnPolicy;
@override final  int minimumOrderQuantity;
 final  Map<String, dynamic>? _meta;
@override Map<String, dynamic>? get meta {
  final value = _meta;
  if (value == null) return null;
  if (_meta is EqualUnmodifiableMapView) return _meta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String thumbnail;
 final  List<String> _images;
@override List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}


/// Create a copy of NewProductDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewProductDtoCopyWith<_NewProductDto> get copyWith => __$NewProductDtoCopyWithImpl<_NewProductDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewProductDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewProductDto&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.dimensions, dimensions) || other.dimensions == dimensions)&&(identical(other.warrantyInformation, warrantyInformation) || other.warrantyInformation == warrantyInformation)&&(identical(other.shippingInformation, shippingInformation) || other.shippingInformation == shippingInformation)&&(identical(other.availabilityStatus, availabilityStatus) || other.availabilityStatus == availabilityStatus)&&(identical(other.returnPolicy, returnPolicy) || other.returnPolicy == returnPolicy)&&(identical(other.minimumOrderQuantity, minimumOrderQuantity) || other.minimumOrderQuantity == minimumOrderQuantity)&&const DeepCollectionEquality().equals(other._meta, _meta)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&const DeepCollectionEquality().equals(other._images, _images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,category,price,discountPercentage,const DeepCollectionEquality().hash(_tags),brand,sku,dimensions,warrantyInformation,shippingInformation,availabilityStatus,returnPolicy,minimumOrderQuantity,const DeepCollectionEquality().hash(_meta),thumbnail,const DeepCollectionEquality().hash(_images));

@override
String toString() {
  return 'NewProductDto(title: $title, description: $description, category: $category, price: $price, discountPercentage: $discountPercentage, tags: $tags, brand: $brand, sku: $sku, dimensions: $dimensions, warrantyInformation: $warrantyInformation, shippingInformation: $shippingInformation, availabilityStatus: $availabilityStatus, returnPolicy: $returnPolicy, minimumOrderQuantity: $minimumOrderQuantity, meta: $meta, thumbnail: $thumbnail, images: $images)';
}


}

/// @nodoc
abstract mixin class _$NewProductDtoCopyWith<$Res> implements $NewProductDtoCopyWith<$Res> {
  factory _$NewProductDtoCopyWith(_NewProductDto value, $Res Function(_NewProductDto) _then) = __$NewProductDtoCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String category, double price, double discountPercentage, List<String> tags, String brand, String sku, ProductDimensionDto? dimensions, String? warrantyInformation, String? shippingInformation, String? availabilityStatus, String? returnPolicy, int minimumOrderQuantity, Map<String, dynamic>? meta, String thumbnail, List<String> images
});


@override $ProductDimensionDtoCopyWith<$Res>? get dimensions;

}
/// @nodoc
class __$NewProductDtoCopyWithImpl<$Res>
    implements _$NewProductDtoCopyWith<$Res> {
  __$NewProductDtoCopyWithImpl(this._self, this._then);

  final _NewProductDto _self;
  final $Res Function(_NewProductDto) _then;

/// Create a copy of NewProductDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? category = null,Object? price = null,Object? discountPercentage = null,Object? tags = null,Object? brand = null,Object? sku = null,Object? dimensions = freezed,Object? warrantyInformation = freezed,Object? shippingInformation = freezed,Object? availabilityStatus = freezed,Object? returnPolicy = freezed,Object? minimumOrderQuantity = null,Object? meta = freezed,Object? thumbnail = null,Object? images = null,}) {
  return _then(_NewProductDto(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,dimensions: freezed == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as ProductDimensionDto?,warrantyInformation: freezed == warrantyInformation ? _self.warrantyInformation : warrantyInformation // ignore: cast_nullable_to_non_nullable
as String?,shippingInformation: freezed == shippingInformation ? _self.shippingInformation : shippingInformation // ignore: cast_nullable_to_non_nullable
as String?,availabilityStatus: freezed == availabilityStatus ? _self.availabilityStatus : availabilityStatus // ignore: cast_nullable_to_non_nullable
as String?,returnPolicy: freezed == returnPolicy ? _self.returnPolicy : returnPolicy // ignore: cast_nullable_to_non_nullable
as String?,minimumOrderQuantity: null == minimumOrderQuantity ? _self.minimumOrderQuantity : minimumOrderQuantity // ignore: cast_nullable_to_non_nullable
as int,meta: freezed == meta ? _self._meta : meta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of NewProductDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductDimensionDtoCopyWith<$Res>? get dimensions {
    if (_self.dimensions == null) {
    return null;
  }

  return $ProductDimensionDtoCopyWith<$Res>(_self.dimensions!, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}
}

// dart format on
