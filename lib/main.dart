import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seats_app/pages/firstPage.dart';
import 'package:seats_app/pages/secondPage.dart';
import 'package:seats_app/pages/thirdPage.dart';

final student = StateProvider((ref) => const StudentListName());
final currentIndexProvider = StateProvider((ref) => 0);
final seatsWidgetProvider = StateProvider((ref) => Seats());

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class members {
  late List membersName;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  final pagesWidget = [
    const FirstPage(),
    const SecondPage(),
    const ThirdPage(),
  ];

  MyHomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index) {
            ref.read(currentIndexProvider.notifier).state = index;
          },
          selectedIndex: currentIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
              selectedIcon: Icon(Icons.home_outlined),
            ),
            NavigationDestination(
              icon: Icon(Icons.business),
              label: 'Business',
              selectedIcon: Icon(Icons.business_outlined),
            ),
            NavigationDestination(
              icon: Icon(Icons.school),
              label: 'School',
              selectedIcon: Icon(Icons.school_outlined),
            ),
          ]),
      body: pagesWidget.elementAt(currentIndex),
    );
  }
}

class _boxState extends ConsumerWidget {
  _boxState();
  final widgets = [];
  final seatWidget = Seats().seats;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seatWidgets = ref.watch(seatsWidgetProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.red,
              child: const SizedBox(),
            ),
            Flexible(
              child: GestureDetector(
                onTapDown: (tapDownDetails) {
                  seatWidget.add(
                    Positioned(
                      left: tapDownDetails.localPosition.dx,
                      top: tapDownDetails.localPosition.dy,
                      child: const Placeholder(
                        color: Colors.blue,
                      ), //TODO: add seat widget
                    ),
                  );
                  ref.watch(seatsWidgetProvider); //タップでWidgetを挿入するたびに描画更新する
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ...seatWidget,
                    ...seatWidgets.seats,
                    Container(
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          seatWidget.clear();
          // ref.watch(seatsWidgetProvider);
        },
        mini: true,
        backgroundColor: Colors.grey,
        child: const Icon(Icons.delete),
      ),
    );
  }
}

class Seat {
  Seat({required this.studentName, required this.num});

  final String studentName;
  final int num;
}

class StudentName {
  StudentName({required this.name});

  final name;
}

class Seats {
  // Seats({this.seats});
  final List<Widget> seats = [];
}

class StudentListName extends StatefulWidget {
  const StudentListName({super.key});

  @override
  State<StudentListName> createState() => _StudentListNameState();
}

class _StudentListNameState extends State<StudentListName> {
  final List<String> studentNames = [];

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (value) {
        studentNames.add(value.toString());
        debugPrint('$studentNames');
      },
    );
  }
}
