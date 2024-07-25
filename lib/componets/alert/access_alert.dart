import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:srock_management/model/user_model.dart';
import 'package:srock_management/screen/spalsh/controller/spalsh_controller.dart';
import 'package:srock_management/screen/user_register/controller/user_controller.dart';
import 'package:srock_management/utils/constants.dart';

import '../../utils/helper/firedb_helper.dart';
import '../widgets/ResponsiveText.dart';

void showAccessPermissionAlert({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Assign Designation"),
        content: AccessAlert(),
      );
    },
  );
}

class AccessAlert extends StatelessWidget {
  AccessAlert({
    super.key,
  });

  SplashController splashController = Get.find();
  UserController userController = Get.put(UserController())
    ..assignAccessList()
    ..getUserCompany();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MultiSelectDropDown(
              onOptionSelected: (List<ValueItem> selectedOptions) {
                userController.userCompanyList = selectedOptions.map((e) => e.value as String,).toList();
              },
              selectedOptions: userController.userCompanyList
                  .map(
                    (element) => ValueItem(label: element, value: element),
                  )
                  .toList(),
              options: splashController.companyList.map(
                (e) {
                  return ValueItem(label: "$e", value: e);
                },
              ).toList(),
              selectionType: SelectionType.multi,
              chipConfig: const ChipConfig(wrapType: WrapType.wrap),
              dropdownHeight: 300,
              optionTextStyle: const TextStyle(fontSize: 16),
              selectedOptionIcon: const Icon(Icons.check_circle),
            ),

          Obx(
            () => Column(
              children: List.generate(
                userController.accessList.length,
                (index) {
                  return SwitchListTile(
                    value: userController.accessList[index].permission!,
                    onChanged: (value) {
                      var access = userController.accessList[index];
                      access.permission = value;
                      userController.accessList[index] = access;
                    },
                    title: ResponsiveText(
                        "${userController.accessList[index].permissionName}"),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          ElevatedButton(
              onPressed: () async {
                userController.updateUser();
                Get.back();
              },
              child: const Text("Save"))
        ],
      ),
    );
  }
}
