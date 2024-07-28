import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srock_management/screen/profile/controller/profile_controller.dart';
import 'package:srock_management/screen/spalsh/controller/spalsh_controller.dart';
import 'package:srock_management/utils/helper/auth_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashController splashController = Get.put(SplashController());
  ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    bool isLogin = AuthHelper.helper.currentUser();

    if (isLogin) {
      controller.getProfileData();
    }
    Timer(
      const Duration(seconds: 3),
          () => Get.offAllNamed(isLogin ? '/app' : '/login'),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/logo/logo.png",
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
