import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:srock_management/model/user_model.dart';
import 'package:srock_management/utils/helper/firedb_helper.dart';

class UserController extends GetxController {
  RxList<UserModel> userList = <UserModel>[].obs;

  Future<void> getAllUserData() async {
    List<UserModel> list = [];

    QuerySnapshot snapshot = await FireDbHelper.helper.getAllUserData();
    for (var x in snapshot.docs) {
      Map m1 = x.data() as Map;
      UserModel model = UserModel.mapToModel(m1);
      list.add(model);
    }
    userList.value =list;
  }
}
