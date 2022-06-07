import 'package:dissent/src/providers/game_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<GameStateProvider>(
        builder: ((context, gameState, child) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(gameState.phase.toString()),
                  Text(gameState.seconds.toString()),
                  TextButton(
                    onPressed: () => gameState.nextPhase(),
                    child: const Text('Next phase'),
                  ),
                  TextButton(
                    onPressed: () => gameState.reset(),
                    child: const Text('Reset'),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
