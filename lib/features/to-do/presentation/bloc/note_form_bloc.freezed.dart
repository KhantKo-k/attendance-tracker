// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_form_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoteFormEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteFormEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NoteFormEvent()';
}


}

/// @nodoc
class $NoteFormEventCopyWith<$Res>  {
$NoteFormEventCopyWith(NoteFormEvent _, $Res Function(NoteFormEvent) __);
}


/// Adds pattern-matching-related methods to [NoteFormEvent].
extension NoteFormEventPatterns on NoteFormEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadNote value)?  loadNote,TResult Function( _NewNote value)?  newNote,TResult Function( _TitleChanged value)?  titleChanged,TResult Function( _ContentChanged value)?  contentChanged,TResult Function( _SaveRequested value)?  saveRequested,TResult Function( _SaveFailureHandled value)?  saveFailureHandled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadNote() when loadNote != null:
return loadNote(_that);case _NewNote() when newNote != null:
return newNote(_that);case _TitleChanged() when titleChanged != null:
return titleChanged(_that);case _ContentChanged() when contentChanged != null:
return contentChanged(_that);case _SaveRequested() when saveRequested != null:
return saveRequested(_that);case _SaveFailureHandled() when saveFailureHandled != null:
return saveFailureHandled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadNote value)  loadNote,required TResult Function( _NewNote value)  newNote,required TResult Function( _TitleChanged value)  titleChanged,required TResult Function( _ContentChanged value)  contentChanged,required TResult Function( _SaveRequested value)  saveRequested,required TResult Function( _SaveFailureHandled value)  saveFailureHandled,}){
final _that = this;
switch (_that) {
case _LoadNote():
return loadNote(_that);case _NewNote():
return newNote(_that);case _TitleChanged():
return titleChanged(_that);case _ContentChanged():
return contentChanged(_that);case _SaveRequested():
return saveRequested(_that);case _SaveFailureHandled():
return saveFailureHandled(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadNote value)?  loadNote,TResult? Function( _NewNote value)?  newNote,TResult? Function( _TitleChanged value)?  titleChanged,TResult? Function( _ContentChanged value)?  contentChanged,TResult? Function( _SaveRequested value)?  saveRequested,TResult? Function( _SaveFailureHandled value)?  saveFailureHandled,}){
final _that = this;
switch (_that) {
case _LoadNote() when loadNote != null:
return loadNote(_that);case _NewNote() when newNote != null:
return newNote(_that);case _TitleChanged() when titleChanged != null:
return titleChanged(_that);case _ContentChanged() when contentChanged != null:
return contentChanged(_that);case _SaveRequested() when saveRequested != null:
return saveRequested(_that);case _SaveFailureHandled() when saveFailureHandled != null:
return saveFailureHandled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String noteId)?  loadNote,TResult Function()?  newNote,TResult Function( String title)?  titleChanged,TResult Function( String content)?  contentChanged,TResult Function()?  saveRequested,TResult Function()?  saveFailureHandled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadNote() when loadNote != null:
return loadNote(_that.noteId);case _NewNote() when newNote != null:
return newNote();case _TitleChanged() when titleChanged != null:
return titleChanged(_that.title);case _ContentChanged() when contentChanged != null:
return contentChanged(_that.content);case _SaveRequested() when saveRequested != null:
return saveRequested();case _SaveFailureHandled() when saveFailureHandled != null:
return saveFailureHandled();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String noteId)  loadNote,required TResult Function()  newNote,required TResult Function( String title)  titleChanged,required TResult Function( String content)  contentChanged,required TResult Function()  saveRequested,required TResult Function()  saveFailureHandled,}) {final _that = this;
switch (_that) {
case _LoadNote():
return loadNote(_that.noteId);case _NewNote():
return newNote();case _TitleChanged():
return titleChanged(_that.title);case _ContentChanged():
return contentChanged(_that.content);case _SaveRequested():
return saveRequested();case _SaveFailureHandled():
return saveFailureHandled();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String noteId)?  loadNote,TResult? Function()?  newNote,TResult? Function( String title)?  titleChanged,TResult? Function( String content)?  contentChanged,TResult? Function()?  saveRequested,TResult? Function()?  saveFailureHandled,}) {final _that = this;
switch (_that) {
case _LoadNote() when loadNote != null:
return loadNote(_that.noteId);case _NewNote() when newNote != null:
return newNote();case _TitleChanged() when titleChanged != null:
return titleChanged(_that.title);case _ContentChanged() when contentChanged != null:
return contentChanged(_that.content);case _SaveRequested() when saveRequested != null:
return saveRequested();case _SaveFailureHandled() when saveFailureHandled != null:
return saveFailureHandled();case _:
  return null;

}
}

}

/// @nodoc


class _LoadNote implements NoteFormEvent {
  const _LoadNote(this.noteId);
  

 final  String noteId;

/// Create a copy of NoteFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadNoteCopyWith<_LoadNote> get copyWith => __$LoadNoteCopyWithImpl<_LoadNote>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadNote&&(identical(other.noteId, noteId) || other.noteId == noteId));
}


@override
int get hashCode => Object.hash(runtimeType,noteId);

@override
String toString() {
  return 'NoteFormEvent.loadNote(noteId: $noteId)';
}


}

/// @nodoc
abstract mixin class _$LoadNoteCopyWith<$Res> implements $NoteFormEventCopyWith<$Res> {
  factory _$LoadNoteCopyWith(_LoadNote value, $Res Function(_LoadNote) _then) = __$LoadNoteCopyWithImpl;
@useResult
$Res call({
 String noteId
});




}
/// @nodoc
class __$LoadNoteCopyWithImpl<$Res>
    implements _$LoadNoteCopyWith<$Res> {
  __$LoadNoteCopyWithImpl(this._self, this._then);

  final _LoadNote _self;
  final $Res Function(_LoadNote) _then;

/// Create a copy of NoteFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? noteId = null,}) {
  return _then(_LoadNote(
null == noteId ? _self.noteId : noteId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _NewNote implements NoteFormEvent {
  const _NewNote();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewNote);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NoteFormEvent.newNote()';
}


}




/// @nodoc


class _TitleChanged implements NoteFormEvent {
  const _TitleChanged(this.title);
  

 final  String title;

/// Create a copy of NoteFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TitleChangedCopyWith<_TitleChanged> get copyWith => __$TitleChangedCopyWithImpl<_TitleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TitleChanged&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,title);

@override
String toString() {
  return 'NoteFormEvent.titleChanged(title: $title)';
}


}

/// @nodoc
abstract mixin class _$TitleChangedCopyWith<$Res> implements $NoteFormEventCopyWith<$Res> {
  factory _$TitleChangedCopyWith(_TitleChanged value, $Res Function(_TitleChanged) _then) = __$TitleChangedCopyWithImpl;
@useResult
$Res call({
 String title
});




}
/// @nodoc
class __$TitleChangedCopyWithImpl<$Res>
    implements _$TitleChangedCopyWith<$Res> {
  __$TitleChangedCopyWithImpl(this._self, this._then);

  final _TitleChanged _self;
  final $Res Function(_TitleChanged) _then;

/// Create a copy of NoteFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,}) {
  return _then(_TitleChanged(
null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ContentChanged implements NoteFormEvent {
  const _ContentChanged(this.content);
  

 final  String content;

/// Create a copy of NoteFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentChangedCopyWith<_ContentChanged> get copyWith => __$ContentChangedCopyWithImpl<_ContentChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentChanged&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,content);

@override
String toString() {
  return 'NoteFormEvent.contentChanged(content: $content)';
}


}

/// @nodoc
abstract mixin class _$ContentChangedCopyWith<$Res> implements $NoteFormEventCopyWith<$Res> {
  factory _$ContentChangedCopyWith(_ContentChanged value, $Res Function(_ContentChanged) _then) = __$ContentChangedCopyWithImpl;
@useResult
$Res call({
 String content
});




}
/// @nodoc
class __$ContentChangedCopyWithImpl<$Res>
    implements _$ContentChangedCopyWith<$Res> {
  __$ContentChangedCopyWithImpl(this._self, this._then);

  final _ContentChanged _self;
  final $Res Function(_ContentChanged) _then;

/// Create a copy of NoteFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? content = null,}) {
  return _then(_ContentChanged(
null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SaveRequested implements NoteFormEvent {
  const _SaveRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NoteFormEvent.saveRequested()';
}


}




/// @nodoc


class _SaveFailureHandled implements NoteFormEvent {
  const _SaveFailureHandled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveFailureHandled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NoteFormEvent.saveFailureHandled()';
}


}




/// @nodoc
mixin _$NoteFormState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteFormState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NoteFormState()';
}


}

/// @nodoc
class $NoteFormStateCopyWith<$Res>  {
$NoteFormStateCopyWith(NoteFormState _, $Res Function(NoteFormState) __);
}


/// Adds pattern-matching-related methods to [NoteFormState].
extension NoteFormStatePatterns on NoteFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _NoteFormInitial value)?  initial,TResult Function( _NoteFormLoading value)?  loading,TResult Function( _NoteFormEditing value)?  editing,TResult Function( _NoteFormFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteFormInitial() when initial != null:
return initial(_that);case _NoteFormLoading() when loading != null:
return loading(_that);case _NoteFormEditing() when editing != null:
return editing(_that);case _NoteFormFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _NoteFormInitial value)  initial,required TResult Function( _NoteFormLoading value)  loading,required TResult Function( _NoteFormEditing value)  editing,required TResult Function( _NoteFormFailure value)  failure,}){
final _that = this;
switch (_that) {
case _NoteFormInitial():
return initial(_that);case _NoteFormLoading():
return loading(_that);case _NoteFormEditing():
return editing(_that);case _NoteFormFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _NoteFormInitial value)?  initial,TResult? Function( _NoteFormLoading value)?  loading,TResult? Function( _NoteFormEditing value)?  editing,TResult? Function( _NoteFormFailure value)?  failure,}){
final _that = this;
switch (_that) {
case _NoteFormInitial() when initial != null:
return initial(_that);case _NoteFormLoading() when loading != null:
return loading(_that);case _NoteFormEditing() when editing != null:
return editing(_that);case _NoteFormFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( NoteEntity note,  bool isSaving,  bool isDirty,  Failure? saveFailure)?  editing,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteFormInitial() when initial != null:
return initial();case _NoteFormLoading() when loading != null:
return loading();case _NoteFormEditing() when editing != null:
return editing(_that.note,_that.isSaving,_that.isDirty,_that.saveFailure);case _NoteFormFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( NoteEntity note,  bool isSaving,  bool isDirty,  Failure? saveFailure)  editing,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _NoteFormInitial():
return initial();case _NoteFormLoading():
return loading();case _NoteFormEditing():
return editing(_that.note,_that.isSaving,_that.isDirty,_that.saveFailure);case _NoteFormFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( NoteEntity note,  bool isSaving,  bool isDirty,  Failure? saveFailure)?  editing,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _NoteFormInitial() when initial != null:
return initial();case _NoteFormLoading() when loading != null:
return loading();case _NoteFormEditing() when editing != null:
return editing(_that.note,_that.isSaving,_that.isDirty,_that.saveFailure);case _NoteFormFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _NoteFormInitial implements NoteFormState {
  const _NoteFormInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteFormInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NoteFormState.initial()';
}


}




/// @nodoc


class _NoteFormLoading implements NoteFormState {
  const _NoteFormLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteFormLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NoteFormState.loading()';
}


}




/// @nodoc


class _NoteFormEditing implements NoteFormState {
  const _NoteFormEditing({required this.note, this.isSaving = false, this.isDirty = false, this.saveFailure});
  

 final  NoteEntity note;
@JsonKey() final  bool isSaving;
@JsonKey() final  bool isDirty;
 final  Failure? saveFailure;

/// Create a copy of NoteFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteFormEditingCopyWith<_NoteFormEditing> get copyWith => __$NoteFormEditingCopyWithImpl<_NoteFormEditing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteFormEditing&&(identical(other.note, note) || other.note == note)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty)&&(identical(other.saveFailure, saveFailure) || other.saveFailure == saveFailure));
}


@override
int get hashCode => Object.hash(runtimeType,note,isSaving,isDirty,saveFailure);

@override
String toString() {
  return 'NoteFormState.editing(note: $note, isSaving: $isSaving, isDirty: $isDirty, saveFailure: $saveFailure)';
}


}

/// @nodoc
abstract mixin class _$NoteFormEditingCopyWith<$Res> implements $NoteFormStateCopyWith<$Res> {
  factory _$NoteFormEditingCopyWith(_NoteFormEditing value, $Res Function(_NoteFormEditing) _then) = __$NoteFormEditingCopyWithImpl;
@useResult
$Res call({
 NoteEntity note, bool isSaving, bool isDirty, Failure? saveFailure
});


$NoteEntityCopyWith<$Res> get note;

}
/// @nodoc
class __$NoteFormEditingCopyWithImpl<$Res>
    implements _$NoteFormEditingCopyWith<$Res> {
  __$NoteFormEditingCopyWithImpl(this._self, this._then);

  final _NoteFormEditing _self;
  final $Res Function(_NoteFormEditing) _then;

/// Create a copy of NoteFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? note = null,Object? isSaving = null,Object? isDirty = null,Object? saveFailure = freezed,}) {
  return _then(_NoteFormEditing(
note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as NoteEntity,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,saveFailure: freezed == saveFailure ? _self.saveFailure : saveFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of NoteFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NoteEntityCopyWith<$Res> get note {
  
  return $NoteEntityCopyWith<$Res>(_self.note, (value) {
    return _then(_self.copyWith(note: value));
  });
}
}

/// @nodoc


class _NoteFormFailure implements NoteFormState {
  const _NoteFormFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of NoteFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteFormFailureCopyWith<_NoteFormFailure> get copyWith => __$NoteFormFailureCopyWithImpl<_NoteFormFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteFormFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'NoteFormState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$NoteFormFailureCopyWith<$Res> implements $NoteFormStateCopyWith<$Res> {
  factory _$NoteFormFailureCopyWith(_NoteFormFailure value, $Res Function(_NoteFormFailure) _then) = __$NoteFormFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class __$NoteFormFailureCopyWithImpl<$Res>
    implements _$NoteFormFailureCopyWith<$Res> {
  __$NoteFormFailureCopyWithImpl(this._self, this._then);

  final _NoteFormFailure _self;
  final $Res Function(_NoteFormFailure) _then;

/// Create a copy of NoteFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_NoteFormFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
