import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/student_model.dart';
import '../provider/student_notifier.dart';
import 'item/student_itme_list.dart';

class SecondPage extends ConsumerWidget {
  SecondPage({super.key});

  final String _imageUrl =
      'https://shop.creativefreaks.net/wp-content/uploads/edd/2019/09/Thumbnail_S001_1.png';

  //組の入力値を保持する
  final sectionTextProvider =
      StateProvider.autoDispose((ref) => TextEditingController());

  //氏名の入力値を保持する
  final studentNameTextProvider =
      StateProvider.autoDispose((ref) => TextEditingController());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //テキストの入力値を一時的に保持するのための変数
    final sectionText = ref.watch(sectionTextProvider);
    final stutdentNameText = ref.watch(studentNameTextProvider);

    //保持したテキスト情報、削除用のための変数
    final studentsStateSet = ref.read(studentsProvider.notifier);

    //取得した表示用の各リスト
    final List<Student> studentList = ref.watch(studentsProvider);

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.grey,
          child: RefreshIndicator(
            onRefresh: () async {
              return Future<void>.delayed(const Duration(seconds: 1));
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  toolbarHeight: 220.0 + kToolbarHeight,
                  // pinned: true,
                  floating: true,
                  stretch: true,
                  title: Column(
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
                              filled: true,
                              fillColor: Colors.white54,
                              hintText: 'クラス名'),
                        ),
                      ),
                      SizedBox(
                        child: TextFormField(
                          controller: stutdentNameText,
                          maxLength: 10,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white54,
                              hintText: '氏名'),
                        ),
                      ),
                      SizedBox(
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.black),
                          onPressed: () => {
                            //StateNotifierの各リストにテキスト情報を追加
                            studentsStateSet.addStudent(
                                sectionText.text, stutdentNameText.text),
                            debugPrint(
                                '登録ボタン押下: 組${sectionText.text}、氏名${stutdentNameText.text}'),
                            //登録完了後にテキスト情報を初期化
                            sectionText.clear(),
                            stutdentNameText.clear(),
                            debugPrint(
                                '登録後にtextFormField初期化: 組${sectionText.text}、氏名${stutdentNameText.text}'),
                          },
                          child: const Text('登録'),
                        ),
                      ),
                    ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      _imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                ),
                const StudentItemList(),
                // SliverList(
                //   delegate: SliverChildBuilderDelegate(
                //     (context, index) => StudentItemList(
                //       index: index,
                //       studentsStateSet: studentsStateSet,
                //       studentList: studentList,
                //     ),
                //     childCount: studentList.length,
                // Dismissible(
                //   //StateNotifierで状態管理しているstateのidが一意（のはず）のためKeyとして設定
                //   key: Key(studentList[index].id.toString()),
                //   onDismissed: (direction) => students.removeStudent(id),
                //   child: Card(
                //     child: ListTile(
                //       leading: const Icon(Icons.account_circle),
                //       title: Text(studentList[index].section.toString()),
                //       subtitle: Text(
                //         studentList[index].name.toString(),
                //         style: const TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //       trailing: Wrap(
                //         children: [
                //           IconButton(
                //             onPressed: () {},
                //             icon: const Icon(Icons.create),
                //           ),
                //           IconButton(
                //             onPressed: () {
                //               students.removeStudent()
                //             },
                //             icon: const Icon(Icons.delete),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
