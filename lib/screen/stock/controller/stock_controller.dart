import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../utils/helper/firedb_helper.dart';
import '../model/stock_model.dart';

class StockController extends GetxController
{

  RxList<StockModel> stockList = <StockModel>[].obs;

  Future<void> getAllStockData() async {
    List<StockModel> list = [];

    QuerySnapshot snapshot = await FireDbHelper.helper.getAllStockData();
    for (var x in snapshot.docs) {
      Map m1 = x.data() as Map;

      print(m1);
      StockModel model = StockModel(docId: x.id,stockName: m1['name']);
      list.add(model);
    }
    stockList.value =list;
  }

}