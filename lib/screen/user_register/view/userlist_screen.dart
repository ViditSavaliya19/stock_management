import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srock_management/screen/user_register/controller/user_controller.dart';
class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {

  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userController.getAllUserData();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Obx(
        ()=> ListView.builder(
          itemCount: userController.userList.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ExpansionTile(
                title: Text(userController.userList[index].name!),
                children: <Widget>[
                  ListTile(
                    title: Text('Email: ${userController.userList[index].email!}'),
                  ),
                  ListTile(
                    title: Text('Department: ${userController.userList[index].department!}'),
                  ),
                  ListTile(
                    title: Text('Mobile: ${userController.userList[index].mobile!}'),
                  ),
                  ListTile(
                    title: Text('Access: ${userController.userList[index].access!}'),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: const Text('Update'),
                      ),
                      TextButton(
                        onPressed: (){},
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
