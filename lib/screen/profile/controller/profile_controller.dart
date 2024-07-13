import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:srock_management/model/user_model.dart';
import 'package:srock_management/utils/helper/auth_helper.dart';
import 'package:srock_management/utils/helper/firedb_helper.dart';

class ProfileController extends GetxController {
  Rx<UserModel> userModel = UserModel().obs;

  Future<void> getProfileData() async {
    DocumentSnapshot snapshot = await FireDbHelper.helper
        .getUserProfileData(AuthHelper.helper.user!.uid);

    Map m1 = snapshot.data() as Map;
    userModel.value = UserModel.mapToModel(m1);
  }
}
