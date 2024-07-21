import 'package:flutter/material.dart';
import 'package:srock_management/screen/user_register/view/access_screen.dart';
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
    return const Scaffold(
      body: AccessScreen(),
    );
  }
}
