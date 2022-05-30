import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/player.dart';
import '../providers/team_provider.dart';

class AddPlayerWidget extends StatefulWidget {
  const AddPlayerWidget({super.key});

  @override
  AddPlayerWidgetState createState() => AddPlayerWidgetState();
}

class AddPlayerWidgetState extends State<AddPlayerWidget> {
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
                    Provider.of<TeamProvider>(context, listen: false)
                        .addPlayer(Player(name: _formKey.currentState!.fields['name']!.value));
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
