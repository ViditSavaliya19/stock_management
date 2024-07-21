import 'package:flutter/material.dart';

class PermissionAlert extends StatelessWidget {
  const PermissionAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          value: true,
          onChanged: (value) {},
          title: const Text("New Unit(Company) Add Access"),
        ),
        SwitchListTile(
          value: true,
          onChanged: (value) {},
          title: const Text("Show All User Access"),
        ),
        SwitchListTile(
          value: true,
          onChanged: (value) {},
          title: const Text("Show All User Access"),
        ),
        SwitchListTile(
          value: true,
          onChanged: (value) {},
          title: const Text("Add Stock Entry Access"),
        ),
        SwitchListTile(
          value: true,
          onChanged: (value) {},
          title: const Text("Show All Company Stock Access"),
        ),
        SwitchListTile(
          value: true,
          onChanged: (value) {},
          title: const Text("Only Show Company Wise Stock Access"),
        ),
      ],
    );
  }
}
