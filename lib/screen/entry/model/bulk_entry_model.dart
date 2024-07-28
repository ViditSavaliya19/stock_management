import 'package:flutter/material.dart';
import 'package:srock_management/screen/stock/model/stock_model.dart';

class BulkEntryModel {
  TextEditingController txtQuantity = TextEditingController(text: "0");
  StockModel? stockModel;
  String? unit="kg";

  BulkEntryModel({required this.txtQuantity, required this.stockModel,this.unit});

  static List<BulkEntryModel> convertBulkEntryList(List<StockModel> stockList) {
    return stockList
        .map((e) => BulkEntryModel(
            txtQuantity: TextEditingController(text: "0"), stockModel: e,unit: "kg"))
        .toList();
  }
}
