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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [Container()], // Hide the drawer icon
      ),
      body: Consumer<TeamProvider>(
        builder: (context, team, child) {
          return FutureBuilder<List<Player>>(
            future: team.listPlayers(),
            builder: (innerContext, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext innerContext, int index) {
                      return ListTile(
                        title: Text(snapshot.data![index].name),
                        trailing: IconButton(
                          onPressed: () => team.removePlayer(snapshot.data![index]),
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                        ),
                      );
                    },
                    separatorBuilder: (_, index) => const Divider(height: 1));
              }
              return const Text('Loading...');
            },
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => Scaffold.of(context).openEndDrawer(),
          tooltip: 'Voeg een speler toe',
          child: const Icon(Icons.add),
        ),
      ),
      endDrawer: const Drawer(
        child: AddPlayerWidget(),
      ),
    );
  }
}
