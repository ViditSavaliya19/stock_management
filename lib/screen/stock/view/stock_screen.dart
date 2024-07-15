import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srock_management/screen/stock/controller/stock_controller.dart';
import 'package:srock_management/screen/stock/model/stock_model.dart';
import 'package:srock_management/utils/helper/firedb_helper.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _stockNameController = TextEditingController();
  TextEditingController _stockUpdateNameController = TextEditingController();

  StockController stockController = Get.put(StockController());

  @override
  void initState() {
    super.initState();
    stockController.getAllStockData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Stock'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _stockNameController,
                    decoration: const InputDecoration(
                      labelText: 'Stock Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the stock name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Add Stock'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: stockController.stockList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: ExpansionTile(
                        title:
                            Text(stockController.stockList[index].stockName!),
                        children: <Widget>[
                          ButtonBar(
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  _stockUpdateNameController.text =
                                      stockController
                                          .stockList[index].stockName!;

                                  Get.defaultDialog(
                                    title: "Update Stock",
                                    content: TextField(
                                      controller: _stockUpdateNameController,
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          FireDbHelper.helper.updateStock(
                                              StockModel(
                                                  docId: stockController
                                                      .stockList[index].docId!,
                                                  stockName:
                                                      _stockUpdateNameController
                                                          .text),
                                              stockController
                                                  .stockList[index].docId!);
                                          Get.back();
                                        },
                                        child: const Text("Update"),
                                      ),
                                    ],
                                  );
                                },
                                child: const Text('Update'),
                              ),
                              TextButton(
                                onPressed: () {
                                  FireDbHelper.helper.deleteStock(
                                      stockController.stockList[index].docId!);
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String stockName = _stockNameController.text.trim();
      FireDbHelper.helper.addStockToFireStore(stockName);
    }
  }
}
