import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:srock_management/model/user_model.dart';
import 'package:srock_management/utils/helper/auth_helper.dart';
import 'package:srock_management/utils/helper/firedb_helper.dart';
import 'package:srock_management/utils/helper/permission_helper.dart';

import '../../../utils/constants.dart';
import '../../spalsh/controller/spalsh_controller.dart';

class ProfileController extends GetxController {

  SplashController splashController = Get.find();
  Rx<UserModel> userModel = UserModel().obs;

  Future<void> getProfileData() async {
    DocumentSnapshot snapshot = await FireDbHelper.helper
        .getUserProfileData(AuthHelper.helper.user!.uid);

    Map m1 = snapshot.data() as Map;
    userModel.value = UserModel.mapToModel(m1);

    splashController. currentPermission.value = PermissionHelper.helper
        .getPermissionCodeToDesignation(
        userModel.value, splashController. designationList);



    print("===================== ${splashController.currentPermission.value}");
  }
}
