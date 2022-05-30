import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/widgets/all.dart';
import 'src/models/team_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TeamModel(),
      child: const DissentApp(),
    ),
  );
}

class DissentApp extends StatelessWidget {
  const DissentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSS&T',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeWidget(),
        '/team': (context) => const TeamWidget(),
      },
    );
  }
}
