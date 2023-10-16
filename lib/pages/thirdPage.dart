import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('School'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          TextFormField(

          ),
          SizedBox(
            child: ListView.builder(
              itemBuilder: (context,index){

              }),
              itemCount: null,
            ),
          )
        ],
      ),
    );
  }
}
