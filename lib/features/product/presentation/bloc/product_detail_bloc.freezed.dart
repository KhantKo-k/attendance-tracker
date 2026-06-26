// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductDetailEvent {

 String get id;
/// Create a copy of ProductDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailEventCopyWith<ProductDetailEvent> get copyWith => _$ProductDetailEventCopyWithImpl<ProductDetailEvent>(this as ProductDetailEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailEvent&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ProductDetailEvent(id: $id)';
}


}

/// @nodoc
abstract mixin class $ProductDetailEventCopyWith<$Res>  {
  factory $ProductDetailEventCopyWith(ProductDetailEvent value, $Res Function(ProductDetailEvent) _then) = _$ProductDetailEventCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$ProductDetailEventCopyWithImpl<$Res>
    implements $ProductDetailEventCopyWith<$Res> {
  _$ProductDetailEventCopyWithImpl(this._self, this._then);

  final ProductDetailEvent _self;
  final $Res Function(ProductDetailEvent) _then;

/// Create a copy of ProductDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductDetailEvent].
extension ProductDetailEventPatterns on ProductDetailEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GetProduct value)?  getProduct,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetProduct() when getProduct != null:
return getProduct(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GetProduct value)  getProduct,}){
final _that = this;
switch (_that) {
case _GetProduct():
return getProduct(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GetProduct value)?  getProduct,}){
final _that = this;
switch (_that) {
case _GetProduct() when getProduct != null:
return getProduct(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id)?  getProduct,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetProduct() when getProduct != null:
return getProduct(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id)  getProduct,}) {final _that = this;
switch (_that) {
case _GetProduct():
return getProduct(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id)?  getProduct,}) {final _that = this;
switch (_that) {
case _GetProduct() when getProduct != null:
return getProduct(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class _GetProduct implements ProductDetailEvent {
  const _GetProduct(this.id);
  

@override final  String id;

/// Create a copy of ProductDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetProductCopyWith<_GetProduct> get copyWith => __$GetProductCopyWithImpl<_GetProduct>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetProduct&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ProductDetailEvent.getProduct(id: $id)';
}


}

/// @nodoc
abstract mixin class _$GetProductCopyWith<$Res> implements $ProductDetailEventCopyWith<$Res> {
  factory _$GetProductCopyWith(_GetProduct value, $Res Function(_GetProduct) _then) = __$GetProductCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$GetProductCopyWithImpl<$Res>
    implements _$GetProductCopyWith<$Res> {
  __$GetProductCopyWithImpl(this._self, this._then);

  final _GetProduct _self;
  final $Res Function(_GetProduct) _then;

/// Create a copy of ProductDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_GetProduct(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ProductDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductDetailState()';
}


}

/// @nodoc
class $ProductDetailStateCopyWith<$Res>  {
$ProductDetailStateCopyWith(ProductDetailState _, $Res Function(ProductDetailState) __);
}


/// Adds pattern-matching-related methods to [ProductDetailState].
extension ProductDetailStatePatterns on ProductDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProductDetailInitialState value)?  initial,TResult Function( ProductDetailLoadingState value)?  loading,TResult Function( ProductDetailLoadedState value)?  loaded,TResult Function( ProductDetailFailureState value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProductDetailInitialState() when initial != null:
return initial(_that);case ProductDetailLoadingState() when loading != null:
return loading(_that);case ProductDetailLoadedState() when loaded != null:
return loaded(_that);case ProductDetailFailureState() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProductDetailInitialState value)  initial,required TResult Function( ProductDetailLoadingState value)  loading,required TResult Function( ProductDetailLoadedState value)  loaded,required TResult Function( ProductDetailFailureState value)  failure,}){
final _that = this;
switch (_that) {
case ProductDetailInitialState():
return initial(_that);case ProductDetailLoadingState():
return loading(_that);case ProductDetailLoadedState():
return loaded(_that);case ProductDetailFailureState():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProductDetailInitialState value)?  initial,TResult? Function( ProductDetailLoadingState value)?  loading,TResult? Function( ProductDetailLoadedState value)?  loaded,TResult? Function( ProductDetailFailureState value)?  failure,}){
final _that = this;
switch (_that) {
case ProductDetailInitialState() when initial != null:
return initial(_that);case ProductDetailLoadingState() when loading != null:
return loading(_that);case ProductDetailLoadedState() when loaded != null:
return loaded(_that);case ProductDetailFailureState() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( Product product)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProductDetailInitialState() when initial != null:
return initial();case ProductDetailLoadingState() when loading != null:
return loading();case ProductDetailLoadedState() when loaded != null:
return loaded(_that.product);case ProductDetailFailureState() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( Product product)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case ProductDetailInitialState():
return initial();case ProductDetailLoadingState():
return loading();case ProductDetailLoadedState():
return loaded(_that.product);case ProductDetailFailureState():
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( Product product)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case ProductDetailInitialState() when initial != null:
return initial();case ProductDetailLoadingState() when loading != null:
return loading();case ProductDetailLoadedState() when loaded != null:
return loaded(_that.product);case ProductDetailFailureState() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ProductDetailInitialState implements ProductDetailState {
  const ProductDetailInitialState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailInitialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductDetailState.initial()';
}


}




/// @nodoc


class ProductDetailLoadingState implements ProductDetailState {
  const ProductDetailLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductDetailState.loading()';
}


}




/// @nodoc


class ProductDetailLoadedState implements ProductDetailState {
  const ProductDetailLoadedState(this.product);
  

 final  Product product;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailLoadedStateCopyWith<ProductDetailLoadedState> get copyWith => _$ProductDetailLoadedStateCopyWithImpl<ProductDetailLoadedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailLoadedState&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode => Object.hash(runtimeType,product);

@override
String toString() {
  return 'ProductDetailState.loaded(product: $product)';
}


}

/// @nodoc
abstract mixin class $ProductDetailLoadedStateCopyWith<$Res> implements $ProductDetailStateCopyWith<$Res> {
  factory $ProductDetailLoadedStateCopyWith(ProductDetailLoadedState value, $Res Function(ProductDetailLoadedState) _then) = _$ProductDetailLoadedStateCopyWithImpl;
@useResult
$Res call({
 Product product
});


$ProductCopyWith<$Res> get product;

}
/// @nodoc
class _$ProductDetailLoadedStateCopyWithImpl<$Res>
    implements $ProductDetailLoadedStateCopyWith<$Res> {
  _$ProductDetailLoadedStateCopyWithImpl(this._self, this._then);

  final ProductDetailLoadedState _self;
  final $Res Function(ProductDetailLoadedState) _then;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,}) {
  return _then(ProductDetailLoadedState(
null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,
  ));
}

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductCopyWith<$Res> get product {
  
  return $ProductCopyWith<$Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}

/// @nodoc


class ProductDetailFailureState implements ProductDetailState {
  const ProductDetailFailureState(this.failure);
  

 final  Failure failure;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailFailureStateCopyWith<ProductDetailFailureState> get copyWith => _$ProductDetailFailureStateCopyWithImpl<ProductDetailFailureState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailFailureState&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'ProductDetailState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ProductDetailFailureStateCopyWith<$Res> implements $ProductDetailStateCopyWith<$Res> {
  factory $ProductDetailFailureStateCopyWith(ProductDetailFailureState value, $Res Function(ProductDetailFailureState) _then) = _$ProductDetailFailureStateCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$ProductDetailFailureStateCopyWithImpl<$Res>
    implements $ProductDetailFailureStateCopyWith<$Res> {
  _$ProductDetailFailureStateCopyWithImpl(this._self, this._then);

  final ProductDetailFailureState _self;
  final $Res Function(ProductDetailFailureState) _then;

/// Create a copy of ProductDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ProductDetailFailureState(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
