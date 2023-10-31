import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seats_app/provider/student_notifier.dart';

// //組の入力値を保持する
// final sectionTextProvider =
//     StateProvider.autoDispose((ref) => TextEditingController());

// //氏名の入力値を保持する
// final studentNameTextProvider =
//     StateProvider.autoDispose((ref) => TextEditingController());

class StudentInput extends ConsumerWidget {
  const StudentInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //テキストの入力値を一時的に保持するのための変数
    final sectionText = ref.watch(sectionTextProvider);
    final stutdentNameText = ref.watch(studentNameTextProvider);

    //保持したテキスト情報、削除用のための変数
    final studentsStateSet = ref.read(studentsProvider.notifier);
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'クラス名・氏名の入力',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          child: TextFormField(
            controller: sectionText,
            maxLength: 10,
            decoration: const InputDecoration(
                filled: true, fillColor: Colors.white54, hintText: 'クラス名'),
          ),
        ),
        SizedBox(
          child: TextFormField(
            controller: stutdentNameText,
            maxLength: 10,
            decoration: const InputDecoration(
                filled: true, fillColor: Colors.white54, hintText: '氏名'),
          ),
        ),
        SizedBox(
          child: ElevatedButton(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            onPressed: () => {
              //StateNotifierの各リストにテキスト情報を追加
              studentsStateSet.addStudent(
                  sectionText.text, stutdentNameText.text),
              debugPrint(
                  '登録ボタン押下: 組${sectionText.text}、氏名${stutdentNameText.text}'),
              //登録完了後にテキスト情報を初期化
              // sectionText.clear(),
              // stutdentNameText.clear(),
              debugPrint(
                  '登録後にtextFormField初期化: 組${sectionText.text}、氏名${stutdentNameText.text}'),
            },
            child: const Text('登録'),
          ),
        ),
      ],
    );
  }
}
