import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srock_management/screen/user_register/controller/user_controller.dart';

class PermissionAlert extends StatelessWidget {
  PermissionAlert({super.key});

  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(
            () =>  Column(
              children: List.generate(
                userController.detailPermissionList.length,
                (index) => SwitchListTile(
                  value: userController.detailPermissionList[index].permission ?? false ,
                  onChanged: (value) {
                    var desi = userController.detailPermissionList[index];
                    desi.permission =value;
                    userController.detailPermissionList[index] =desi;

                  },
                  title: Text("${userController.detailPermissionList[index].permissionName}"),
                ),
              ),
            ),
          ),
        ),
        ElevatedButton(onPressed: () {
              userController.updateDesignation();
              Get.back();

        }, child: const Text("Save"))
      ],
    );
  }
}
