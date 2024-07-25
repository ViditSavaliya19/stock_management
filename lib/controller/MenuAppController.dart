import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srock_management/screen/spalsh/controller/spalsh_controller.dart';

class MenuAppController extends GetxController {
  SplashController splashController = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  //Selected Screen
  RxInt selectedMenuIndex = 0.obs;


  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}