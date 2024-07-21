import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srock_management/componets/headers.dart';
import 'package:srock_management/screen/home/view/dash_screen.dart';
import 'package:srock_management/screen/home/view/home_screen.dart';
import 'package:srock_management/screen/settings/settings_screen.dart';
import 'package:srock_management/screen/stock/view/stock_screen.dart';
import 'package:srock_management/screen/user_register/view/user_screen.dart';
import 'package:srock_management/screen/user_register/view/userlist_screen.dart';
import '../controller/MenuAppController.dart';
import '../utils/Responsive.dart';
import 'components/side_menu.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  MenuAppController controller = Get.put(MenuAppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Header(),
                  Expanded(
                    child: Obx(
                      () {
                        if (controller.selectedMenuIndex.value == 0) {
                          return HomeScreen();
                        } else if (controller.selectedMenuIndex.value == 1)
                          return UserScreen();
                        else if (controller.selectedMenuIndex.value == 2)
                          return StockScreen();
                        else
                          return SettingsScreen();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
