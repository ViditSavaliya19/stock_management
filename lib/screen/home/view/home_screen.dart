import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:srock_management/screen/profile/controller/profile_controller.dart';
import 'package:srock_management/utils/helper/auth_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProfileController profileController = Get.find();

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
                Get.toNamed('profile');
              },
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            Obx(
              () => Visibility(
                visible: profileController.userModel.value.access == "Admin",
                child: ListTile(
                  onTap: () {
                    Get.toNamed('newuser');
                  },
                  leading: const Icon(Icons.person_add_alt_1),
                  title: const Text("Add New User"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: profileController.userModel.value.access == "Admin",
                child: ListTile(
                  onTap: () {
                    Get.toNamed('users');
                  },
                  leading: const Icon(Icons.group),
                  title: const Text("All Users"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: profileController.userModel.value.access == "Admin",
                child: ListTile(
                  onTap: () {
                    Get.toNamed('stock');
                  },
                  leading: const Icon(Icons.group),
                  title: const Text("Add Stock"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            const Spacer(),
            ListTile(
              onTap: () {
                AuthHelper.helper.signOut();
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
