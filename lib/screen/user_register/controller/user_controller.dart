import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:srock_management/model/user_model.dart';
import 'package:srock_management/screen/spalsh/controller/spalsh_controller.dart';
import 'package:srock_management/utils/helper/firedb_helper.dart';
import 'package:srock_management/utils/helper/permission_helper.dart';

import '../model/permission_model.dart';

class UserController extends GetxController {
  UserModel selectedUser = UserModel();
  int selectedUserIndex = 0;

  //Access Screen
  int selectedDesignationIndex = 0;

  //Access Alert
  RxList<UserModel> userList = <UserModel>[].obs;
  RxList<PermissionModel> accessList = <PermissionModel>[].obs;
  List userCompanyList = [];
  SplashController splashController = Get.find();

  //Designation wise Permission List (Permission Alert )
  RxList<PermissionModel> detailPermissionList = <PermissionModel>[].obs;

  // Company Assign
  void getUserCompany() {
    userCompanyList = userList[selectedUserIndex].department!;
  }

  Future<void> getAllUserData() async {
    List<UserModel> list = [];

    QuerySnapshot snapshot = await FireDbHelper.helper.getAllUserData();
    for (var x in snapshot.docs) {
      Map m1 = x.data() as Map;
      UserModel model = UserModel.mapToModel(m1);
      list.add(model);
    }
    userList.value = list;
  }

  //Access Assign
  void assignAccessList() {
    selectedUser = userList[selectedUserIndex];
    List<PermissionModel> l1 = [];

    for (var x in splashController.designationList) {
      if (selectedUser.designation!.contains(x.desiName)) {
        l1.add(PermissionModel(permissionName: x.desiName, permission: true));
      } else {
        l1.add(PermissionModel(permissionName: x.desiName, permission: false));
      }
    }

    accessList.value = l1;
  }

  //Update User Permission
  Future<void> updateUser() async {
    var filterPermission = accessList.where((p0) => p0.permission!);
    var desiList = filterPermission
        .map(
          (element) => element.permissionName!,
        )
        .toList();
    //Update Designation
    userList[selectedUserIndex].designation = desiList;
    //Update Department
    userList[selectedUserIndex].department = userCompanyList;
    await FireDbHelper.helper.createNewUser(model: selectedUser);
  }

  // Get selected Designation wise detail permission
  void assignPermissionList() {
    //everyTime assign when permission dialog assign
    var l1 = PermissionHelper.helper.defaultPermissionList;

    var selectedDesi =
        splashController.designationList[selectedDesignationIndex];
    for (var i = 0; i < l1.length; i++) {
      if (selectedDesi.permissionIds!.contains(l1[i].permissionId)) {
        var permit = l1[i];
        permit.permission = true;
        l1[i] = permit;
      }
    }

    detailPermissionList.value = l1;
  }

  // Update designation Permission
  void updateDesignation() {
    //filter permission only true
    var filterPermissionList = detailPermissionList.where(
      (p0) => p0.permission,
    );
    //filter permission ids list
    var filterPermissionIdList = filterPermissionList
        .map(
          (e) => e.permissionId,
        )
        .toList();

    splashController.designationList[selectedDesignationIndex].permissionIds =
        filterPermissionIdList;
    FireDbHelper.helper.updateDetailPermission(
        splashController.designationList[selectedDesignationIndex]);
  }
}
