import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/player.dart';
import '../providers/team_provider.dart';
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
      body: Consumer<TeamProvider>(
        builder: (context, db, child) {
          return FutureBuilder<List<Player>>(
            future: db.listPlayers(),
            builder: (innerContext, snapshot) {
              if(snapshot.hasData) {
                return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext innerContext, int index) {
                  return Text('' + snapshot.data![index].name);
              });
              }
              return const Text('Loading...');
            },
          );
        },
      ),
      endDrawer: const Drawer(
        child: AddPlayerWidget(),
      ),
    );
  }
}