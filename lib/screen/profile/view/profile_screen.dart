import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srock_management/screen/profile/controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 60.0,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 60.0,
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              controller.userModel.value.name!,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 20.0),
            _buildProfileItem(Icons.email, 'Email', controller.userModel.value.email),
            // _buildProfileItem(Icons.business, 'Department', controller.userModel.value.department),
            _buildProfileItem(
                Icons.phone, 'Mobile', controller.userModel.value.mobile),
            // _buildProfileItem(Icons.security, 'Access Level', controller.userModel.value.access),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, String? value) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.lightBlue),
        title: Text(title),
        subtitle: Text(value ?? ''),
      ),
    );
  }
}
