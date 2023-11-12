import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seats_app/model/student_model.dart';

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
    debugPrint('edit Student New:$newStudent');
  }

  void removeStudent(int id) {
    state = state.where((student) => student.id != id).toList();
    debugPrint('remove Student id:$id 残りのリスト$state');
  }
}

//入力された組、氏名情報を保持する
final studentsProvider = StateNotifierProvider<StudentsNotifier, List<Student>>(
    (ref) => StudentsNotifier());

//組の入力値を一時的に保持する
final sectionTextProvider =
    StateProvider.autoDispose((ref) => TextEditingController());

//氏名の入力値を一時的に保持する
final studentNameTextProvider =
    StateProvider.autoDispose((ref) => TextEditingController());

//組の入力値を一時的に保持する(編集ダイアログ)
final sectionTextEditProvider =
    StateProvider.autoDispose((ref) => TextEditingController());

//氏名の入力値を一時的に保持する(編集ダイアログ)
final studentNameTextEditProvider =
    StateProvider.autoDispose((ref) => TextEditingController());
