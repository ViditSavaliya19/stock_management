import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srock_management/screen/entry/controller/entry_controller.dart';
import 'package:srock_management/screen/entry/model/entry_model.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  EntryController entryController = Get.find();

  @override
  void initState() {
    super.initState();
    entryController.stockWiseEntry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Analysis"),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: entryController.analysisList.length,
          itemBuilder: (context, index) {
            List keys = entryController.analysisList.keys.toList();
            List<EntryModel>? entryList =
                entryController.analysisList[keys[index]]?.entryModelList;
            return ExpansionTile(
              title: Text("${keys[index]}"),
              trailing: Text(
                '${ entryController.analysisList[keys[index]]!.totalQuantity} KG',
                style: const TextStyle(color: Colors.blue),
              ),
              children: List.generate(
                entryList!.length,
                (index) => Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entryList[index].companyName),
                      Text(
                          "${entryList[index].quantity} ${entryList[index].unit}"),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
