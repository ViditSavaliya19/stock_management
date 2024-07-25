import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:srock_management/model/designation_model.dart';
import 'package:srock_management/utils/helper/firedb_helper.dart';

class SplashController extends GetxController {
  RxList companyList = [].obs;
  RxList<DesignationModel> designationList = <DesignationModel>[].obs;
  RxList currentPermission =[].obs;

  @override
  void onInit() {
    getCompanyList();
    getDesignationList();
    super.onInit();
  }

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

  Future<void> getDesignationList() async {
    QuerySnapshot doc = await FireDbHelper.helper.getDesignation();
    var snapList = doc.docs;
    List<DesignationModel> l1 = [];
    for (var x in snapList) {
      Map m1 = x.data() as Map;

      DesignationModel model = DesignationModel.mapToModel(m1);
      model.docId = x.id;
      l1.add(model);
    }
      // l1.sort();
    designationList.value = l1;
  }
}
