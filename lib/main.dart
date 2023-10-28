import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seats_app/pages/first_page.dart';
import 'package:seats_app/pages/second_page.dart';
import 'package:seats_app/pages/third_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final currentIndexProvider = StateProvider((ref) => 0);

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', ''),
        Locale('en', ''),
      ],
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
    FirstPage(),
    SecondPage(),
    ThirdPage(),
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
