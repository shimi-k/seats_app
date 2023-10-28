import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seats_app/model/student_model.dart';

//生徒名
class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier() : super([]);

  void addStudent(String section, String name) {
    int id = (state.isEmpty) ? 1 : state.last.id + 1;
    state = [
      ...state,
      Student(id: id, section: section, name: name),
    ];
    debugPrint(
        'add Student ${Student(id: id, section: section, name: name)} 一覧$state');
  }

  void editStudent(Student newStudent) {
    //引数のStudent.idと一致する要素を編集されたテキスト内容に変更する
    state = state
        .map((student) => Student(
              id: student.id,
              section: (student.id == newStudent.id)
                  ? newStudent.section
                  : student.section,
              name: (student.id == newStudent.id)
                  ? newStudent.name
                  : student.name,
            ))
        .toList();
    debugPrint('edit Student New:${newStudent}');
  }

  void removeStudent(int id) {
    state = state.where((student) => student.id != id).toList();
    debugPrint('remove Student id:$id 残りのリスト$state');
  }
}

final studentsProvider = StateNotifierProvider<StudentsNotifier, List<Student>>(
    (ref) => StudentsNotifier());
