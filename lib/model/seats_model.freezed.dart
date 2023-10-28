// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Seats {
  Widget get seat => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SeatsCopyWith<Seats> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatsCopyWith<$Res> {
  factory $SeatsCopyWith(Seats value, $Res Function(Seats) then) =
      _$SeatsCopyWithImpl<$Res, Seats>;
  @useResult
  $Res call({Widget seat});
}

/// @nodoc
class _$SeatsCopyWithImpl<$Res, $Val extends Seats>
    implements $SeatsCopyWith<$Res> {
  _$SeatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seat = null,
  }) {
    return _then(_value.copyWith(
      seat: null == seat
          ? _value.seat
          : seat // ignore: cast_nullable_to_non_nullable
              as Widget,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeatsImplCopyWith<$Res> implements $SeatsCopyWith<$Res> {
  factory _$$SeatsImplCopyWith(
          _$SeatsImpl value, $Res Function(_$SeatsImpl) then) =
      __$$SeatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Widget seat});
}

/// @nodoc
class __$$SeatsImplCopyWithImpl<$Res>
    extends _$SeatsCopyWithImpl<$Res, _$SeatsImpl>
    implements _$$SeatsImplCopyWith<$Res> {
  __$$SeatsImplCopyWithImpl(
      _$SeatsImpl _value, $Res Function(_$SeatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seat = null,
  }) {
    return _then(_$SeatsImpl(
      seat: null == seat
          ? _value.seat
          : seat // ignore: cast_nullable_to_non_nullable
              as Widget,
    ));
  }
}

/// @nodoc

class _$SeatsImpl implements _Seats {
  const _$SeatsImpl({required this.seat});

  @override
  final Widget seat;

  @override
  String toString() {
    return 'Seats(seat: $seat)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatsImpl &&
            (identical(other.seat, seat) || other.seat == seat));
  }

  @override
  int get hashCode => Object.hash(runtimeType, seat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatsImplCopyWith<_$SeatsImpl> get copyWith =>
      __$$SeatsImplCopyWithImpl<_$SeatsImpl>(this, _$identity);
}

abstract class _Seats implements Seats {
  const factory _Seats({required final Widget seat}) = _$SeatsImpl;

  @override
  Widget get seat;
  @override
  @JsonKey(ignore: true)
  _$$SeatsImplCopyWith<_$SeatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
