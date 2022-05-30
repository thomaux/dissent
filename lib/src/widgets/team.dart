import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/team_model.dart';
import 'add_player.dart';

class TeamWidget extends StatelessWidget {
  const TeamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beheer je team'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      body: Consumer<TeamModel>(
        builder: (context, team, child) {
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: team.players.length,
              itemBuilder: (BuildContext context, int index) {
                return Text('' + team.players[index].name);
              });
        },
      ),
      endDrawer: const Drawer(
        child: AddPlayerWidget(),
      ),
    );
  }
}