import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srock_management/utils/constants.dart';
import 'package:srock_management/utils/helper/auth_helper.dart';

import '../../controller/MenuAppController.dart';
import '../../screen/spalsh/controller/spalsh_controller.dart';
import '../../utils/Responsive.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
  }) : super(key: key);

  MenuAppController controller = Get.find();
  SplashController splashController = Get.find();

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
              controller.selectedMenuIndex.value = 0;
              if(Responsive.isMobile(context))
                {
                  Get.back();
                }
            },
          ),
          DrawerListTile(
            title: "Profile",
            icon: Icons.account_circle,
            press: () {
              controller.selectedMenuIndex.value = 1;
              if(Responsive.isMobile(context))
              {
                Get.back();
              }
            },
          ),
          Visibility(
            visible: splashController.currentPermission.contains(PERMISSION_1),
            child: DrawerListTile(
              title: "User",
              icon: Icons.account_circle,
              press: () {
                controller.selectedMenuIndex.value = 2;
                if(Responsive.isMobile(context))
                {
                  Get.back();
                }
              },
            ),
          ),
          Visibility(
            visible: splashController.currentPermission.contains(PERMISSION_1),
            child: DrawerListTile(
              title: "Stock",
              icon: Icons.business_center,
              press: () {
                controller.selectedMenuIndex.value =3;
                if(Responsive.isMobile(context))
                {
                  Get.back();
                }
              },
            ),
          ),
          Visibility(
            visible: splashController.currentPermission.contains(PERMISSION_1),
            child: DrawerListTile(
              title: "Settings",
              icon: Icons.settings,
              press: () {
                controller.selectedMenuIndex.value = 4;
                if(Responsive.isMobile(context))
                {
                  Get.back();
                }
              },
            ),
          ),
          DrawerListTile(
            title: "Sign Out",
            icon: Icons.login,
            press: () {
              AuthHelper.helper.signOut();
              Get.offAllNamed('/login');
            },
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
