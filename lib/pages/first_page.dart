import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:seats_app/model/student_model.dart';
import 'package:seats_app/pages/second_page.dart';
import 'package:seats_app/provider/student_notifier.dart';

class FirstPage extends ConsumerWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.flutter_dash_outlined),
            title: const Text('席替えレイアウト'),
          ),
          endDrawer: Drawer(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('data1'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('data2'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('data3'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.indigo,
            child: const SeatingLayoutOnList(),
          )),
    );
  }
}

//リストを使った座席のレイアウトクラス
class SeatingLayoutOnList extends ConsumerWidget {
  const SeatingLayoutOnList({super.key});

  //座席の配置を保持　TODO:riverpodで保持するように修正する
  final int row = 4;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemList = ref.watch(studentsProvider);
    final itemListRe = ref.read(studentsProvider.notifier);
    return itemList.isNotEmpty
        ? ReorderableGridView.count(
            crossAxisCount: row,
            children: itemList
                .map((Student item) =>
                    Card(key: ObjectKey(item), child: Text(item.name)))
                .toList(),
            onReorder: (oldIndex, newIndex) {
              final newList = listSwitch(itemList, oldIndex, newIndex);
              itemListRe.overrideState(newList);
            },
          )
        //TODO:ページ遷移するときにナビゲーションバーとかが消えてしまう
        : Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              child: const Text(
                '生徒を追加',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SecondPage())),
            ),
          );
  }

  //ドラッグでリストを入れ替える時に2つのリスト（ドラッグ元とドラッグ先のリスト）のみが入れ替わるための処理
  List<Student> listSwitch(
      List<Student> beforeSwitchList, int oldIndex, int newIndex) {
    final afterSwitchList = [...beforeSwitchList];
    final Student item = beforeSwitchList[oldIndex];
    afterSwitchList[oldIndex] = afterSwitchList[newIndex];
    afterSwitchList[newIndex] = item;
    return afterSwitchList;
  }
}
