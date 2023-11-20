import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seats_app/model/student_model.dart';

class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier() : super([]);

  void addStudent(String section, String name) {
    int id;
    if (state.isEmpty) {
      id = 1;
    } else {
      //リストにあるStudent.idが最大値のidを取得して+1する（リストの順番を入れ替える処理の対策）
      final Student studentMaxId = state.reduce((student1, student2) =>
          student1.id > student2.id ? student1 : student2);
      id = studentMaxId.id + 1;
    }

    //もしidが重複した際は登録させない
    final s = state.where((a) => a.id == id);
    if (s.isNotEmpty) {
      debugPrint('Duplicate Student id ');
      return;
    }

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

  void overrideState(List<Student> students) {
    state = [...students];
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
