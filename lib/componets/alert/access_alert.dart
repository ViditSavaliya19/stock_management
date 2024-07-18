import 'package:flutter/material.dart';

void showAccessPermissionAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const AccessAlert();
    },
  );
}

class AccessAlert extends StatefulWidget {
  const AccessAlert({super.key});

  @override
  State<AccessAlert> createState() => _AccessAlertState();
}

class _AccessAlertState extends State<AccessAlert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Access Permission"),
      ),
      body:  Column(
        children: [
          SwitchListTile(
            value: true,
            onChanged: (value) {},
            title: const Text("Admin"),
          ),
          SwitchListTile(
            value: true,
            onChanged: (value) {},
            title: const Text("Accountant"),
          ),
          SwitchListTile(
            value: true,
            onChanged: (value) {},
            title: const Text("Storage Manager"),
          ),
          SwitchListTile(
            value: true,
            onChanged: (value) {},
            title: const Text("Unit Storage Entry"),
          ),
        ],
      ),
    );
  }
}
