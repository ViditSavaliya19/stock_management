import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:srock_management/screen/entry/model/analysis_model.dart';
import 'package:srock_management/screen/entry/model/bulk_entry_model.dart';
import 'package:srock_management/screen/profile/controller/profile_controller.dart';
import 'package:srock_management/screen/stock/controller/stock_controller.dart';
import 'package:srock_management/screen/stock/model/stock_model.dart';
import 'package:srock_management/utils/constants.dart';
import 'package:srock_management/utils/helper/firedb_helper.dart';

import '../model/entry_model.dart';

class EntryController extends GetxController {
  RxMap<String, AnalysisModel> analysisList = <String, AnalysisModel>{}.obs;
  ProfileController profileController = Get.find();
  StockController stockController = Get.put(StockController());
  RxList<EntryModel> entryList = <EntryModel>[].obs;
  List<EntryModel> allEntryBackUpList = <EntryModel>[];
  Rx<DateTime> startDate = DateTime.now().obs;
  RxString selectedCompany = "All".obs;
  RxList<StockModel> stockList = <StockModel>[].obs;
  RxList<BulkEntryModel> bulkEntry = <BulkEntryModel>[].obs;

  @override
  void onInit() {
    stockList = stockController.stockList;
    super.onInit();
  }

  void getAllCompanyStock() {
    FireDbHelper.helper.getCompanyStockStream().listen(
      (event) {
        allEntryBackUpList = event;
        filterStocks();
      },
    );
  }

  // Dashboard stock show

  void filterStocks() {
    //For all entry
    // entryList.value = allEntryBackUpList;

    //For Filter
    if (profileController.splashController.currentPermission
            .contains(PERMISSION_1) ||
        profileController.splashController.currentPermission
            .contains(PERMISSION_3)) {
      entryList.value = allEntryBackUpList.where((stock) {
        bool matchesDate = DateFormat('yyyy-MM-dd').format(startDate.value) ==
            DateFormat('yyyy-MM-dd').format(stock.date);
        bool matchesCompany = selectedCompany.trim() == "All" ||
            stock.companyName.trim() == selectedCompany.trim();

        return matchesDate && matchesCompany;
      }).toList();
    } else {
      entryList.value = allEntryBackUpList.where((stock) {
        bool matchesDate = DateFormat('yyyy-MM-dd').format(startDate.value) ==
            DateFormat('yyyy-MM-dd').format(stock.date);
        bool empCompany = profileController.userModel.value.department!
            .contains(stock.companyName.trim());

        // if (profileController.userModel.value.access != "Admin") {
        return matchesDate && empCompany;
        // } else {
        // return matchesDate && matchesCompany;
        // }
      }).toList();
    }
    stockWiseEntry();
  }

  void stockWiseEntry() {
    Map<String, AnalysisModel> temp = {};

    for (var element in stockController.stockList) {
      List<EntryModel> l1 = [];
      AnalysisModel model = AnalysisModel(entryModelList: l1, totalQuantity: 0);
      temp[element.stockName!] = model;
    }

    var todayStock = allEntryBackUpList.where((stock) {
      bool matchesDate = DateFormat('yyyy-MM-dd').format(startDate.value) ==
          DateFormat('yyyy-MM-dd').format(stock.date);
      return matchesDate;
    });

    for (var e in todayStock) {
      AnalysisModel? analysisModel = temp[e.stockName];
      List<EntryModel> l1 = analysisModel!.entryModelList;
      l1.add(e);
      analysisModel.entryModelList = l1;
      if (e.unit == 'tonne') {
        analysisModel.totalQuantity =
            analysisModel.totalQuantity! + (e.quantity * 1000);
      } else {
        analysisModel.totalQuantity = analysisModel.totalQuantity! + e.quantity;
      }

      temp[e.stockName] = analysisModel;
    }

    print(todayStock);
    print(temp);

    analysisList.value = temp;
  }

  Future<void> addBulkEntry() async {
    for (var x in bulkEntry) {
      String qua = x.txtQuantity.text.trim();

      if (qua != "0" && qua.isNotEmpty) {
        int quantity = int.parse(qua.trim());

        if (!(quantity <= 0)) {

          EntryModel entryModel = EntryModel(
              stockName: x.stockModel!.stockName!,
              companyName: profileController.userModel.value.department![0],
              date: DateTime.now(),
              time: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}",
              quantity: quantity,
              unit: x.unit!,
              addEntryEmpName: profileController.userModel.value.name!);

          await FireDbHelper.helper.addStockEntryToFireStore(entryModel);
        }
      }
    }
  }
}
