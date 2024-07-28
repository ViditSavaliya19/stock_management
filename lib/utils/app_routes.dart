import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:srock_management/main/app_screen.dart';
import 'package:srock_management/screen/entry/view/entry_screen.dart';
import 'package:srock_management/screen/login/view/signIn_screen.dart';
import 'package:srock_management/screen/profile/view/profile_screen.dart';
import 'package:srock_management/screen/settings/settings_screen.dart';
import 'package:srock_management/screen/user_register/view/userlist_screen.dart';

import '../screen/home/view/home_screen.dart';
import '../screen/login/view/signUp_screen.dart';
import '../screen/spalsh/view/splash_screen.dart';
import '../screen/stock/view/stock_screen.dart';
import '../screen/user_register/view/register_screen.dart';

class AppRoutes {
  static Map<String,WidgetBuilder> routes = {
    '/': (context) => const SplashScreen(),
    '/login': (context) => const SignInScreen(),
    '/singup': (context) => const SignUpScreen(),
    '/app': (context) => const AppScreen(),
    '/home': (context) => const HomeScreen(),
    '/stock': (context) => const StockScreen(),
    '/newuser': (context) => const RegisterScreen(),
    '/profile': (context) => const ProfileScreen(),
    '/users': (context) => const UserListScreen(),
    '/entry': (context) => const EntryScreen(),
    '/settings': (context) => const SettingsScreen(),
  };

  // static List<GetPage> routes =[
  //   GetPage(name: '/', page: () => const SplashScreen(),),
  //   GetPage(name: '/login', page: () => const SignInScreen(),),
  //   GetPage(name: '/singup', page: () => const SignUpScreen(),),
  //   GetPage(name: '/app', page: () => const AppScreen(),),
  //   GetPage(name: '/home', page: () => const HomeScreen(),),
  //   GetPage(name: '/stock', page: () => const StockScreen(),),
  //   GetPage(name: '/newuser', page: () => const RegisterScreen(),),
  //   GetPage(name: '/profile', page: () => const ProfileScreen(),),
  //   GetPage(name: '/users', page: () => const UserListScreen(),),
  //   GetPage(name: '/entry', page: () => const EntryScreen(),),
  //   GetPage(name: '/settings', page: () => const SettingsScreen(),),
  // ];
}
