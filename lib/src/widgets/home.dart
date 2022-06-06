import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DSS&T'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/team'),
            icon: const Icon(Icons.people),
            tooltip: 'Beheer je team',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Container()],
        ),
      ),
    );
  }
}
