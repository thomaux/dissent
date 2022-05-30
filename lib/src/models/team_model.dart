import 'dart:collection';

import 'package:flutter/material.dart';

class Player {
  const Player({required this.name});
  final String name;
}

class TeamModel extends ChangeNotifier {
  final List<Player> _players = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Player> get players => UnmodifiableListView(_players);

  void add(Player player) {
    _players.add(player);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}