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
        const Animate(),
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

class Animate extends StatefulWidget {
  const Animate({super.key});

  @override
  State<Animate> createState() => _AnimateState();
}

class _AnimateState extends State<Animate> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationDouble;
  final Tween<double> _tweenDouble = Tween(begin: 0.0, end: 200.0);
  late Animation<Color?> _animationColor;
  final ColorTween _tweenColor =
      ColorTween(begin: Colors.green, end: Colors.blue);

  _forward() async {
    setState(() {
      _animationController.forward();
    });
  }

  _stop() async {
    setState(() {
      _animationController.stop();
    });
  }

  _repeat() async {
    setState(() {
      _animationController.repeat();
    });
  }

  _reverse() async {
    setState(() {
      _animationController.reverse();
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _animationDouble = _tweenDouble.animate(_animationController);
    _animationDouble.addListener(() {
      setState(() {});
    });
    _animationColor = _tweenColor.animate(_animationController);
    _animationColor.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizeTransition(
            sizeFactor: _animationController,
            child: Center(
              child: SizedBox(
                width: _animationDouble.value,
                height: _animationDouble.value,
                child: Container(color: _animationColor.value),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _forward,
                icon: const Icon(Icons.arrow_forward),
              ),
              IconButton(
                onPressed: _stop,
                icon: const Icon(Icons.pause),
              ),
              IconButton(
                onPressed: _reverse,
                icon: const Icon(Icons.arrow_back),
              ),
              IconButton(onPressed: _repeat, icon: const Icon(Icons.repeat))
            ],
          ),
        ],
      ),
    );
  }
}
