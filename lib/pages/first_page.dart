import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seats_app/Model/seats_model.dart';
import 'package:seats_app/provider/seats_notifier.dart';

// タップした場所に配置するWidgetの状態管理
final seatsWidgetProvider =
    StateNotifierProvider<SeatsNotifier, List<Seats>>((ref) => SeatsNotifier());

class FirstPage extends ConsumerWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Seats> seatWidgets = ref.watch(seatsWidgetProvider);
    final seatNotifier = ref.watch(seatsWidgetProvider.notifier);

    return Scaffold(
      body: GestureDetector(
        onTapDown: (tapDownDetails) {
          seatNotifier.addSeat(
            Positioned(
              left: tapDownDetails.localPosition.dx,
              top: tapDownDetails.localPosition.dy,
              child: const FlutterLogo(
                size: 60,
              ), //TODO: add seat widget
            ),
          );
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            //Seatsクラスのseatをfor分でリストを展開して各Widgetを表示
            // for (final seats in seatWidgets) seats.seat,
            ...seatWidgets.map((e) => e.seat).toList(),
            Container(
              color: Colors.transparent,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  seatNotifier.clearSeat();
                },
                mini: true,
                backgroundColor: Colors.grey,
                child: const Icon(Icons.delete),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
