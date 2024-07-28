import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srock_management/componets/widgets/ResponsiveText.dart';
import 'package:srock_management/screen/entry/controller/entry_controller.dart';
import 'package:srock_management/utils/constants.dart';

import '../../stock/controller/stock_controller.dart';
import '../model/bulk_entry_model.dart';

class AllEntryScreen extends StatefulWidget {
  const AllEntryScreen({super.key});

  @override
  State<AllEntryScreen> createState() => _AllEntryScreenState();
}

class _AllEntryScreenState extends State<AllEntryScreen> {
  EntryController entryController = Get.find();
  final List<String> _units = ['liters', 'tonne', 'kg']; // Units for selection

  @override
  void initState() {
    super.initState();
    entryController.bulkEntry.value =
        BulkEntryModel.convertBulkEntryList(entryController.stockList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          tileColor: greenColor,
          leading: const Text(
            "NO",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
          title: const Text(
            "Stock Name",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Quantity",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Unit",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: entryController.bulkEntry.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              minTileHeight: 60,
              tileColor: index % 2 == 0 ? Colors.lightBlue[50] : Colors.white,
              leading: ResponsiveText("${index + 1}"),
              title: Text(
                  "${entryController.bulkEntry[index].stockModel!.stockName}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: entryController.bulkEntry[index].txtQuantity,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 150,
                    child: Obx(
                      () => DropdownButtonFormField<String>(
                        value: entryController.bulkEntry[index].unit,
                        items: _units.map((String unit) {
                          return DropdownMenuItem<String>(
                            value: unit,
                            child: Text(unit),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            BulkEntryModel model =
                                entryController.bulkEntry[index];
                            model.unit = newValue;
                            entryController.bulkEntry[index] = model;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a unit';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () async {
                  Get.defaultDialog(
                    title: "",
                    content: const Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Process Start..",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )
                      ],
                    ),
                  );
                  await entryController.addBulkEntry();
                  Get.back();
                  Get.back();

                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blue),
                    foregroundColor: WidgetStateProperty.all(Colors.white)),
                child: const Text("Add Stock"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
