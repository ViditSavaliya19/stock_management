import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:srock_management/utils/helper/firedb_helper.dart';

class SplashController extends GetxController {
  RxList companyList = [].obs;

  Future<void> getCompanyList() async {
    QuerySnapshot doc = await FireDbHelper.helper.getCompanyNameList();
    var snapList = doc.docs;
    List l1 = [];
    for (var x in snapList) {
      Map m1 = x.data() as Map;
      l1.add(m1['name']);
    }
    l1.sort();
    companyList.value = l1;
  }
}
