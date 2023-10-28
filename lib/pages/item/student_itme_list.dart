import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seats_app/model/student_model.dart';
import 'package:seats_app/provider/student_notifier.dart';

class StudentItemList extends ConsumerWidget {
  const StudentItemList({
    super.key,
    // required this.index,
    // required this.studentsStateSet,
    // required this.studentList,
  });

  // final int index;
  // final StudentsNotifier studentsStateSet;
  // final List<Student> studentList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final student = studentList[index];

    //保持したテキスト情報、削除用のための変数
    final studentsStateSet = ref.read(studentsProvider.notifier);

    //取得した表示用の各リスト
    final List<Student> studentList = ref.watch(studentsProvider);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Dismissible(
          //StateNotifierで状態管理しているstateのidが一意（のはず）のためKeyとして設定
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
                    onPressed: () {},
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
