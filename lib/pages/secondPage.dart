import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final String imageUrl =
      'https://shop.creativefreaks.net/wp-content/uploads/edd/2019/09/Thumbnail_S001_1.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.grey,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'Student Name List',
                    style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  background: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                actions: <Widget>[
                  IconButton(onPressed: () {}, icon: Icon(Icons.dehaze)),
                ],
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                      child: Text('Item ${index}'),
                      color: Colors.amber,
                    );
                  },
                  childCount: 20,
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
