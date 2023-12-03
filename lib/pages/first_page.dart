import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:seats_app/model/student_model.dart';
import 'package:seats_app/pages/item/setting.dart';
import 'package:seats_app/pages/second_page.dart';
import 'package:seats_app/provider/student_notifier.dart';

class FirstPage extends ConsumerWidget {
  const FirstPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool layoutToggle = ref.watch(layoutToggleProvider);
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
                  title: const Text('レイアウト１（リスト）'),
                  onTap: () {
                    ref.read(layoutToggleProvider.notifier).state = true;
                  },
                ),
                ListTile(
                  title: const Text('レイアウト２（ドラッグ＆ドロップ）'),
                  onTap: () {
                    ref.read(layoutToggleProvider.notifier).state = false;
                  },
                ),
              ],
            ),
          ),
          body: layoutToggle
              ? const SeatingLayoutOnList()
              : Column(
                  children: [
                    const SizedBox(
                      height: 30,
                      child: DragList(),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.indigo,
                        child: const SeatingLayoutOnTable(),
                      ),
                    ),
                  ],
                )),
    );
  }
}

//レイアウト１、リストを使った座席のレイアウト
class SeatingLayoutOnList extends ConsumerWidget {
  const SeatingLayoutOnList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemList = ref.watch(studentsProvider);
    final itemListRe = ref.read(studentsProvider.notifier);
    final viewAxisCount = ref.watch(layoutColumns);
    return itemList.isNotEmpty
        ? ReorderableGridView.count(
            crossAxisCount: viewAxisCount,
            children: itemList
                .map((Student item) =>
                    Card(key: ObjectKey(item), child: Text(item.name)))
                .toList(),
            onReorder: (oldIndex, newIndex) {
              final newList = listSwitch(itemList, oldIndex, newIndex);
              itemListRe.overrideState(newList);
            },
          )
        : Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              child: const Text(
                '生徒を追加',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).push(
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

//レイアウト２、マス目が背景のレイアウト　TODO:ドラッグアンドドロップした時の処理を実装する必要あり
class SeatingLayoutOnTable extends ConsumerWidget {
  const SeatingLayoutOnTable({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final column = ref.watch(layoutColumns);
    final row = ref.watch(layoutRows);
    return Stack(
      children: [
        _TableWidget(
          column: column,
          row: row,
        )
      ],
    );
  }
}

//背景となる座席の枠を生成
class _TableWidget extends StatelessWidget {
  const _TableWidget({
    required this.column,
    required this.row,
    Key? key,
  }) : super(key: key);

  final int column;
  final int row;
  @override
  Widget build(BuildContext context) {
    final List<Widget> columnList = List.generate(
      column,
      (index) => SizedBox(
        height: 40,
        child: DragTarget(
          builder: (context, candidateData, rejectedData) {
            return const Text('');
          },
        ),
      ),
    );
    final List<TableRow> rowList =
        List.generate(row, (index) => TableRow(children: [...columnList]));

    return SingleChildScrollView(
      child: Table(
        border: TableBorder.all(),
        // defaultColumnWidth: const FlexColumnWidth(1.0),
        defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
        children: [
          ...rowList,
        ],
      ),
    );
  }
}

class DragList extends ConsumerWidget {
  const DragList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemList = ref.watch(studentsProvider);
    return ListView(
      scrollDirection: Axis.horizontal,
      children: itemList
          .map(
            (e) => Card(
              color: Colors.lightBlue,
              child: LongPressDraggable(
                feedback: const Icon(Icons.directions_run),
                data: e.name,
                child: Text(e.name),
              ),
            ),
          )
          .toList(),
    );
  }
}
