import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:srock_management/screen/spalsh/controller/spalsh_controller.dart';
import 'package:srock_management/utils/constants.dart';

import '../widgets/ResponsiveText.dart';

void showAccessPermissionAlert(BuildContext context) {
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
  AccessAlert({super.key});

  SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MultiSelectDropDown(
            onOptionSelected: (List<ValueItem> selectedOptions) {},
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
          SwitchListTile(
            value: true,
            onChanged: (value) {},
            title: ResponsiveText("Admin"),
          ),
          SwitchListTile(
            value: true,
            onChanged: (value) {},
            title: ResponsiveText("Accountant"),
          ),
          SwitchListTile(
            value: true,
            onChanged: (value) {},
            title: ResponsiveText("Storage Manager"),
          ),
          SwitchListTile(
            value: true,
            onChanged: (value) {},
            title: ResponsiveText("Unit Storage Entry"),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Save"))
        ],
      ),
    );
  }
}
