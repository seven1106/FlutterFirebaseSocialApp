import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ModToolScreen extends StatelessWidget {
  final String communityName;

  const ModToolScreen({super.key, required this.communityName});

  void navigateToEditCommunity(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$communityName');
  }

  void navigateToAddMods(BuildContext context) {
    Routemaster.of(context).push('/add_mods/$communityName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mod Tools'),
        ),
        body: Column(children: [
          ListTile(
              leading: const Icon(Icons.add_moderator),
              title: const Text('Add Moderators'),
              onTap: () => navigateToAddMods(context)),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Community'),
            onTap: () => navigateToEditCommunity(context),
          ),
        ]));
  }
}
