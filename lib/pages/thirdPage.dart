import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('School'),
          leading: Image.asset('images/owl.png'),
          bottom: const TabBar(tabs: [
            Tab(
              text: 'people',
              icon: Icon(Icons.people),
            ),
            Tab(
              text: 'settings',
              icon: Icon(Icons.settings),
            )
          ]),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              onPressed: () => print('Map pressed'),
              icon: Icon(Icons.map),
              highlightColor: Colors.blue,
              splashColor: Colors.purple,
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () => print('Cart pressed'),
              child: Text('Cart'),
            )
          ],
        ),
        body: TabBarView(
          children: [
            Container(
              color: Colors.green,
            ),
            Container(
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
