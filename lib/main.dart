import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:srock_management/controller/MenuAppController.dart';
import 'package:srock_management/utils/app_routes.dart';
import 'package:srock_management/utils/constants.dart';
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
      // initialRoute: '/',
      theme: ThemeData(
        colorSchemeSeed: greenColor,
        scaffoldBackgroundColor: Colors.white
      ),
      routes: AppRoutes.routes,
      // getPages: AppRoutes.routes,
    );
  }
}
