import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:srock_management/screen/home/view/home_screen.dart';
import 'package:srock_management/screen/login/view/signIn_screen.dart';
import 'package:srock_management/screen/login/view/signUp_screen.dart';
import 'package:srock_management/screen/spalsh/view/splash_screen.dart';
import 'package:srock_management/screen/stock/view/stock_screen.dart';
import 'package:srock_management/screen/user_register/view/register_screen.dart';
import 'package:srock_management/utils/app_routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
