import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:srock_management/utils/helper/auth_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[50],
      ),
      drawer: Drawer(
        backgroundColor: Colors.lightBlue[50],
        child: Column(
          children: [
            Container(
              height: 250,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/logo/logo.png',
                height: 100,
                width: 100,
              ),
            ),
            ListTile(
              onTap: () {
                Get.toNamed('newuser');
              },
              leading: const Icon(Icons.person_add_alt_1),
              title: const Text("Sign Out"),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const Spacer(),
            ListTile(
              onTap: () {
                AuthHelper.helper.singOut();
                Get.offAllNamed('login');
              },
              leading: const Icon(Icons.login),
              title: const Text("Sign Out"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.lightBlue[50],
        child: Icon(Icons.add),
      ),
    );
  }
}
