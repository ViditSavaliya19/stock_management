
import 'package:flutter/cupertino.dart';
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

class AppRoutes{

  static Map<String,WidgetBuilder> routes = {
    '/': (context) => const SplashScreen(),
    'login': (context) => const SignInScreen(),
    'singup': (context) => const SignUpScreen(),
    'home': (context) => const HomeScreen(),
    'stock': (context) => const StockScreen(),
    'newuser': (context) => const RegisterScreen(),
    'profile': (context) => const ProfileScreen(),
    'users': (context) => const UserListScreen(),
    'entry': (context) => const EntryScreen(),
    'settings': (context) => const SettingsScreen(),
  };

}