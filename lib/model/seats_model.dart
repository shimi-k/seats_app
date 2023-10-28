import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seats_model.freezed.dart';

@freezed
class Seats with _$Seats {
  const factory Seats({
    required Widget seat,
  }) = _Seats;
}
