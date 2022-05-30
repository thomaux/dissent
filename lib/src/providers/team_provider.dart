import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/player.dart';

class TeamProvider extends ChangeNotifier  {
  TeamProvider({ required this.db });
  final Database db;  

  Future<void> addPlayer(Player player) async {
    await db.insert('players', player.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    notifyListeners();
  }

  Future<List<Player>> listPlayers() async {
    final List<Map<String, dynamic>> maps = await db.query('players');

    return List.generate(maps.length, (i) {
      return Player(
        name: maps[i]['name'],
      );
    });
  }
}
