import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srock_management/componets/widgets/ResponsiveText.dart';
import 'package:srock_management/screen/entry/controller/entry_controller.dart';
import 'package:srock_management/utils/constants.dart';

import '../../stock/controller/stock_controller.dart';

class AllEntryScreen extends StatefulWidget {
  const AllEntryScreen({super.key});

  @override
  State<AllEntryScreen> createState() => _AllEntryScreenState();
}

class _AllEntryScreenState extends State<AllEntryScreen> {
  EntryController entryController = Get.put(EntryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          tileColor: greenColor,
          leading: const Text(
            "NO",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          title: const Text(
            "Stock Name",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Text(
            "Quantity",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () => Padding(
          padding:
              const EdgeInsets.only(top: 8.0, left: 20, right: 20, bottom: 8),
          child: ListView.builder(
            itemCount: entryController.stockList.length,
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: index % 2 == 0 ? Colors.lightBlue[50] : Colors.white,
                leading: ResponsiveText("${index + 1}"),
                title: Text("${entryController.stockList[index].stockName}"),
                trailing: const SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
