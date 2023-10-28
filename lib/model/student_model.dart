import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_model.freezed.dart';

@freezed
class Student with _$Student {
  const factory Student({
    required int id,
    required String section,
    required String name,
  }) = _Student;
}
