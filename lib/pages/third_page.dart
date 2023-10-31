import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  TabBar _buildTabBar() {
    return const TabBar(
      indicatorWeight: 5,
      indicatorColor: Colors.white,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.blueGrey,
      tabs: [
        Tab(
          text: 'Contacts',
          icon: Icon(Icons.people),
        ),
        Tab(
          text: 'Settings',
          icon: Icon(Icons.settings),
        )
      ],
    );
  }

  TabBarView _buildTabBarView() {
    return TabBarView(
      children: [
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.purple,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('School'),
      //   leading: Image.asset('images/owl.png'),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   actions: [
      //     IconButton(
      //       onPressed: () => print('Map pressed'),
      //       icon: Icon(Icons.map),
      //       highlightColor: Colors.blue,
      //       splashColor: Colors.purple,
      //     ),
      //     TextButton(
      //       style: ButtonStyle(
      //         foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      //       ),
      //       onPressed: () => print('Cart pressed'),
      //       child: Text('Cart'),
      //     )
      //   ],
      // ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool bool) {
            return <Widget>[
              SliverAppBar(
                title: const Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Image.asset(
                  'images/owl.png',
                ),
                backgroundColor: Colors.black,
                pinned: true,
                floating: false,
                snap: false,
                expandedHeight: 300,
                bottom: _buildTabBar(),
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  collapseMode: CollapseMode.pin,
                  background: Image.asset(
                    'images/owl.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () => debugPrint('Map pressed'),
                    icon: const Icon(Icons.map),
                    highlightColor: Colors.blue,
                    splashColor: Colors.purple,
                  ),
                  TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                    onPressed: () => debugPrint('Cart pressed'),
                    child: const Text(
                      'Cart',
                    ),
                  ),
                ],
              )
            ];
          },
          body: _buildTabBarView(),
        ),
      ),
    );
  }
}
