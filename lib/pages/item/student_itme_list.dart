import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seats_app/model/student_model.dart';
import 'package:seats_app/provider/student_notifier.dart';

class StudentItemList extends ConsumerWidget {
  const StudentItemList({super.key});

  Future<void> _dialogBuilder(
      BuildContext context, WidgetRef ref, Student student) async {
    //テキストの入力値を一時的に保持するのための変数
    final sectionTextEdit = ref.watch(sectionTextEditProvider);
    final stutdentNameTextEdit = ref.watch(studentNameTextEditProvider);

    //編集対象のテキスト情報取得更新用
    final sectionText = ref.read(sectionTextEditProvider.notifier);
    final studentText = ref.read(studentNameTextEditProvider.notifier);

    //タップされた編集対象のリスト情報をダイアログに反映
    sectionText.state.text = student.section;
    studentText.state.text = student.name;

    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '編集',
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            Column(
              children: [
                SizedBox(
                  child: TextFormField(
                    controller: sectionTextEdit,
                    maxLength: 10,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white54,
                        hintText: 'クラス名'),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: stutdentNameTextEdit,
                    maxLength: 10,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white54,
                        hintText: '氏名'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //編集ダイアログで修正されたクラス名、氏名を持たせて状態を更新する（[id]はそのまま）
                    Student newStudent = Student(
                        id: student.id,
                        section: sectionTextEdit.text,
                        name: stutdentNameTextEdit.text);
                    ref.read(studentsProvider.notifier).editStudent(newStudent);
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //保持したテキスト情報、削除用のための変数
    final studentsStateSet = ref.read(studentsProvider.notifier);

    //取得した表示用の各リスト
    final List<Student> studentList = ref.watch(studentsProvider);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Dismissible(
          key: ObjectKey(studentList),
          // key: Key(studentList[index].toString()),
          onDismissed: (direction) =>
              studentsStateSet.removeStudent(studentList[index].id),
          child: Card(
            child: ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(studentList[index].section),
              subtitle: Text(
                studentList[index].name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Wrap(
                children: [
                  IconButton(
                    onPressed: () {
                      _dialogBuilder(context, ref, studentList[index]);
                    },
                    icon: const Icon(Icons.create),
                  ),
                  IconButton(
                    onPressed: () {
                      studentsStateSet.removeStudent(studentList[index].id);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ),
        ),
        childCount: studentList.length,
      ),
    );
  }
}
