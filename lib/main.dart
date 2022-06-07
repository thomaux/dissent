import 'package:dissent/src/providers/game_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'src/providers/team_provider.dart';
import 'src/widgets/all.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Database db = await openDatabase(
    join(await getDatabasesPath(), 'dissent.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE players(id INTEGER PRIMARY KEY, name TEXT)',
      );
    },
    version: 1,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TeamProvider(db: db)),
      ChangeNotifierProvider(create: (context) => GameStateProvider())
    ],
    child: const DissentApp(),
  ));
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
