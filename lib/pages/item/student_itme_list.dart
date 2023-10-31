import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seats_app/model/student_model.dart';
import 'package:seats_app/provider/student_notifier.dart';

class StudentItemList extends ConsumerWidget {
  const StudentItemList({super.key});

  Future<void> _dialogBuilder(
      BuildContext context, WidgetRef ref, Student student) async {
    //テキストの入力値を一時的に保持するのための変数
    final sectionTextEdit = ref.watch(sectionTextProvider);
    final stutdentNameTextEdit = ref.watch(studentNameTextProvider);

    //編集対象のテキスト情報取得
    final sectionText = ref.read(sectionTextProvider.notifier);
    final studentText = ref.read(studentNameTextProvider.notifier);

    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
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
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
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
                      //TODO: dialogか編集画面を作る
                      _dialogBuilder(context, ref, studentList[index]);
                      // studentsStateSet.editStudent(newStudent);
                      //TODO: ダイアログに入力中に後ろの画面にも入力されてしまう。
                      // ダイアログで更新した値を非同期で入力してから生とリスト編集するように修正する
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
