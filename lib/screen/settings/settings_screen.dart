import 'package:flutter/material.dart';
import 'package:srock_management/screen/user_register/view/register_screen.dart';
import 'package:srock_management/screen/user_register/view/userlist_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Data"),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "New users",
              ),
              Tab(
                text: "Add Designation",
              ),
              Tab(
                text: "Show All Uses",
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RegisterScreen(),
            RegisterScreen(),
            UserListScreen(),
          ],
        ),
      ),
    );
  }
}
