import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'item/input_widget.dart';
import 'item/student_itme_list.dart';

class SecondPage extends ConsumerWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
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
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset(
                        'images/school.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    title: const StudentInput(),
                  ),
                  const StudentItemList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
