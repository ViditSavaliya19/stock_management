import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:srock_management/screen/profile/controller/profile_controller.dart';
import 'package:srock_management/screen/stock/controller/stock_controller.dart';
import 'package:srock_management/utils/helper/firedb_helper.dart';

import '../model/entry_model.dart';

class EntryController {
  RxMap<String, List<EntryModel>> analysisList =
      <String, List<EntryModel>>{}.obs;
  ProfileController profileController = Get.find();
  StockController stockController = Get.find();
  RxList<EntryModel> entryList = <EntryModel>[].obs;
  List<EntryModel> allEntryBackUpList = <EntryModel>[];
  final List<String> companies = ["All", "Mahad", "Karunesh", "Soham", "Ansh"];
  Rx<DateTime> startDate = DateTime.now().obs;
  RxString selectedCompany = "All".obs;

  void getAllCompanyStock() {
    FireDbHelper.helper.getCompanyStockStream().listen(
      (event) {
        allEntryBackUpList = event;
        filterStocks();
      },
    );
  }

  void filterStocks() {
    entryList.value = allEntryBackUpList;
    entryList.value = allEntryBackUpList.where((stock) {
      bool matchesDate = DateFormat('yyyy-MM-dd').format(startDate.value) ==
          DateFormat('yyyy-MM-dd').format(stock.date);
      bool matchesCompany = selectedCompany.trim() == "All" ||
          stock.companyName.trim() == selectedCompany.trim();
      bool empCompany = profileController.userModel.value.department!.trim() ==
          stock.companyName.trim();

      if (profileController.userModel.value.access != "Admin") {
        return matchesDate && matchesCompany && empCompany;
      } else {
        return matchesDate && matchesCompany;
      }
    }).toList();
  }

  void stockWiseEntry() {
    Map<String, List<EntryModel>> temp = {};

    for (var element in stockController.stockList) {

      List<EntryModel> l1 =[];
      temp[element.stockName!] = l1;
    }

    var todayStock = allEntryBackUpList.where((stock) {
      bool matchesDate = DateFormat('yyyy-MM-dd').format(startDate.value) ==
          DateFormat('yyyy-MM-dd').format(stock.date);
      return matchesDate;
    });

    todayStock.map(
      (e) {
        List<EntryModel>? l1 = temp[e.stockName];
        l1!.add(e);
        temp[e.stockName]= l1;
      },
    );

    print(temp);

    analysisList.value = temp;
  }
}
