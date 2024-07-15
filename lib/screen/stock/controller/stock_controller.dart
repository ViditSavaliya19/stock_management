import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../utils/helper/firedb_helper.dart';
import '../model/stock_model.dart';

class StockController extends GetxController
{

  RxList<StockModel> stockList = <StockModel>[].obs;

  void getAllStockData() {
    List<StockModel> list = [];

    FireDbHelper.helper.getAllStockData().listen((event) {
      for (var x in event.docs) {
        Map m1 = x.data() as Map;

        StockModel model = StockModel(docId: x.id,stockName: m1['name']);
        list.add(model);
      }
      stockList.value =list;

    },);
  }

}