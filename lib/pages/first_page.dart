import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seats_app/Model/seats_model.dart';
import 'package:seats_app/provider/seats_notifier.dart';
import 'package:seats_app/provider/student_notifier.dart';

// タップした場所に配置するWidgetの状態管理
final seatsWidgetProvider =
    StateNotifierProvider<SeatsNotifier, List<Seats>>((ref) => SeatsNotifier());

class FirstPage extends ConsumerWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Seats> seatWidgets = ref.watch(seatsWidgetProvider);
    final seatNotifier = ref.watch(seatsWidgetProvider.notifier);

    return SafeArea(
      child: Scaffold(
          body: Container(
        child: SeatingLayout(),
      )
          // body: GestureDetector(
          //   onTapDown: (tapDownDetails) {
          //     seatNotifier.addSeat(
          //       Positioned(
          //         left: tapDownDetails.localPosition.dx,
          //         top: tapDownDetails.localPosition.dy,
          //         child: const FlutterLogo(
          //           size: 60,
          //         ), //TODO: add seat widget
          //       ),
          //     );
          //   },
          //   child: Stack(
          //     fit: StackFit.expand,
          //     children: [
          //       //Seatsクラスのseatをfor分でリストを展開して各Widgetを表示
          //       // for (final seats in seatWidgets) seats.seat,
          //       ...seatWidgets.map((e) => e.seat).toList(),
          //       Container(
          //         color: Colors.transparent,
          //       ),
          //       Align(
          //         alignment: Alignment.bottomRight,
          //         child: FloatingActionButton(
          //           onPressed: () {
          //             seatNotifier.clearSeat();
          //           },
          //           mini: true,
          //           backgroundColor: Colors.grey,
          //           child: const Icon(Icons.delete),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}

class SeatingLayout extends ConsumerWidget {
  SeatingLayout({super.key});

  //座席の配置を行と列で保持
  int colum = 1;
  int row = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemList = ref.watch(studentsProvider);
    final itemListRe = ref.read(studentsProvider.notifier);
    return ReorderableListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          key: Key('$index'),
          title: Text('${itemList[index]}'),
        );
      },
      itemCount: itemList.length,
      onReorder: (oldIndex, newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1; //-1するのは「newIndex」がリストの要素数からはみださないようにしてるのか
        }
        final item = itemList.removeAt(oldIndex);
        itemList.insert(newIndex, item);
        itemListRe.overrideState(itemList); //TODO:動確する　リストの順番が入れ替わっているか
      },
    );
  }
}
