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
        title: const Text("Data"),
      ),
      body: Expanded(
        child: Obx(
          () => ListView.builder(
            itemCount: entryController.analysisList.length,
            itemBuilder: (context, index) {
              List keys = entryController.analysisList.keys.toList();
              List<EntryModel>? entryList =
                  entryController.analysisList[keys[index]];
              return ExpansionTile(
                title: Text("${keys[index]}"),
                // trailing: Text(
                //   '${stock.quantity} ${stock.unit}',
                //   style: const TextStyle(color: Colors.blue),
                // ),
                children: List.generate(
                  entryList!.length,
                  (index) => ListTile(
                    title: Text(entryList[index].companyName),
                    subtitle: Text("${entryList[index].quantity}"),
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
