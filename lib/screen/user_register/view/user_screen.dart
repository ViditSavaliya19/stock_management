import 'package:flutter/material.dart';
import 'package:srock_management/screen/user_register/view/access_screen.dart';
import 'package:srock_management/screen/user_register/view/register_screen.dart';
import 'package:srock_management/screen/user_register/view/userlist_screen.dart';
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  text: "New users",
                ),
                Tab(
                  text: "Show All Users",
                ),
                Tab(
                  text: "Designation & Access",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  RegisterScreen(),
                  UserListScreen(),
                  AccessScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
