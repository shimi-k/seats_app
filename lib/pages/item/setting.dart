import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//座席レイアウト変更用フラグ
final layoutToggleProvider = StateProvider<bool>((ref) => true);

//座席レイアウト　列
final layoutColumns = StateProvider<int>((ref) => 4);

//座席レイアウト　行
final layoutRows = StateProvider<int>((ref) => 10);

//設定値画面
class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        SettingList(
          leading: const Icon(Icons.view_column),
          title: const Text('レイアウトの列を指定'),
          trailing: Count(provider: layoutColumns),
        ),
        SettingList(
          leading: const Icon(Icons.table_rows),
          title: const Text('レイアウトの行を指定'),
          trailing: Count(provider: layoutRows),
        ),
      ],
    );
  }
}

//設定値リスト
class SettingList extends ConsumerWidget {
  const SettingList({
    super.key,
    this.leading = const Icon(Icons.star_rate_outlined),
    required this.title,
    required this.trailing,
  });
  final Widget leading;
  final Widget title;
  final Widget trailing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: leading,
      title: title,
      trailing: SizedBox(
        width: 110,
        child: trailing,
      ),
    );
  }
}

//設定値　レイアウトの行・列の数を設定する処理
class Count extends ConsumerWidget {
  const Count({
    required this.provider,
    super.key,
  });
  //行と列のProviderを引数で受け取る用
  final StateProvider<int> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int num = ref.watch(provider);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: (() {
              //設定値が1より下にならないようにする
              if (num > 1) {
                ref.read(provider.notifier).state--;
              }
            }),
            icon: const Icon(Icons.arrow_left),
          ),
        ),
        Text('$num'),
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: (() {
              ref.read(provider.notifier).state++;
            }),
            icon: const Icon(Icons.arrow_right),
          ),
        ),
      ],
    );
  }
}
