import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srock_management/utils/helper/auth_helper.dart';

import '../../controller/MenuAppController.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
  }) : super(key: key);

  MenuAppController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.lightBlue[50],
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/logo/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            icon: Icons.home,
            press: () {
              controller.selectedMenuIndex.value =0;
            },
          ),
          DrawerListTile(
            title: "User",
            icon: Icons.account_circle,
            press: () {
              controller.selectedMenuIndex.value =1;
            },
          ),
          DrawerListTile(
            title: "Stock",
            icon: Icons.business_center,
            press: () {
              controller.selectedMenuIndex.value =2;
            },
          ),
          DrawerListTile(
            title: "Settings",
            icon: Icons.settings,
            press: () {
              controller.selectedMenuIndex.value =3;
            },
          ),
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
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        size: 16,
      ),
      title: Text(
        title,
      ),
    );
  }
}