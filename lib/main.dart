import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
        '/': (context) => const HomePage(),
        '/team': (context) => const TeamScreen(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DSS&T'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/team');
        },
        tooltip: 'Beheer team',
        child: const Icon(Icons.people),
      ),
    );
  }
}

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

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
        child: AddPlayerForm(),
      ),
    );
  }
}

class AddPlayerForm extends StatefulWidget {
  const AddPlayerForm({super.key});

  @override
  AddPlayerFormState createState() => AddPlayerFormState();
}

class AddPlayerFormState extends State<AddPlayerForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voeg een speler toe'),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormBuilderTextField(
              autovalidateMode: AutovalidateMode.always,
              name: 'name',
              decoration: const InputDecoration(
                labelText: 'Naam',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vul ajb een naam in';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<TeamModel>(context, listen: false)
                        .add(Player(name: _formKey.currentState!.fields['name']!.value));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Voeg toe'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
