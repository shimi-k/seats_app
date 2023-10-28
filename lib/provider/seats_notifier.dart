import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seats_app/Model/seats_model.dart';

class SeatsNotifier extends StateNotifier<List<Seats>> {
  //親クラスのコンストラクタに初期値を渡す
  SeatsNotifier() : super([]);

  void addSeat(Widget widget) {
    //既存のリストに新規分と合わせてリスト生成する
    state = [
      ...state,
      Seats(seat: widget),
    ];
    debugPrint('add Widget $state.toString()');
  }

  void clearSeat() {
    //リストの要素を削除
    state = [];
    debugPrint('clear widgets $state.toString()');
  }
}
