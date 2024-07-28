import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srock_management/screen/login/controller/login_controller.dart';
import 'package:srock_management/screen/profile/controller/profile_controller.dart';
import 'package:srock_management/utils/constants.dart';
import 'package:srock_management/utils/helper/auth_helper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginController controller = Get.put(LoginController());
  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 CircleAvatar(
                  radius: 60.0,
                  child: Icon(
                    Icons.person,
                    size: 60.0,
                    color: greenColor,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: greenColor,
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon:
                         Icon(Icons.email, color: greenColor),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: controller.validateEmail,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon:  Icon(Icons.lock, color: greenColor),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: controller.validatePassword,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 15.0),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {},
                  child:  Text(
                    'Don\'t have an account? Sign Up',
                    style: TextStyle(
                      color: greenColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, perform login action

      await AuthHelper.helper
          .signInEmailPassword(_emailController.text, _passwordController.text);

      bool? isLogin = AuthHelper.helper.currentUser();

      if (isLogin) {
        await profileController.getProfileData();
        Get.offAllNamed('/app');
      }
    }
  }
}
