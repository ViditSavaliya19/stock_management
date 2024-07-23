import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:srock_management/componets/alert/permission_alert.dart';
import 'package:srock_management/screen/spalsh/controller/spalsh_controller.dart';
import 'package:srock_management/screen/user_register/controller/user_controller.dart';

import '../../../utils/constants.dart';

class AccessScreen extends StatefulWidget {
  const AccessScreen({super.key});

  @override
  State<AccessScreen> createState() => _AccessScreenState();
}

class _AccessScreenState extends State<AccessScreen> {
  SplashController controller = Get.put(SplashController());
  UserController userController = Get.put(UserController());



  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController txtDesignation = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 30.0,
                    color: greenColor,
                  ),
                  const SizedBox(width: 20.0),
                  Text(
                    'Access',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: greenColor,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.designationList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("${controller.designationList[index].desiName}"),
                      trailing: IconButton(
                          onPressed: () {
                            userController.selectedDesignationIndex = index;
                            userController.assignPermissionList();
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Assign Access"),
                                content: PermissionAlert(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.more_vert)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Create New Designation"),
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: txtDesignation,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required Designation";
                      }
                      return null;
                    },
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {

                      if(_formKey.currentState!.validate())
                        {

                        }
                    },
                    child: const Text("Submit"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.person_add_alt_rounded),
      ),
    );
  }
}
