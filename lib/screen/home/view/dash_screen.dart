import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../entry/controller/entry_controller.dart';
import '../../entry/model/entry_model.dart';
import '../../profile/controller/profile_controller.dart';
class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  ProfileController profileController = Get.find();
  EntryController entryController = Get.put(EntryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => selectDate(context),
                    child: Text(DateFormat('yyyy-MM-dd')
                        .format(entryController.startDate.value)),
                  ),
                ),
                const SizedBox(width: 8),
                Visibility(
                  visible: profileController!.userModel.value.access=="Admin",
                  child: Expanded(
                    child: Obx(
                          () => DropdownButtonFormField<String>(
                        value: entryController.selectedCompany.value,
                        items: entryController.companies.map((String company) {
                          return DropdownMenuItem<String>(
                            value: company,
                            child: Text(company),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          entryController.selectedCompany.value = newValue!;
                          entryController.filterStocks();
                        },
                        decoration: const InputDecoration(
                          labelText: 'Select Company',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: entryController.entryList.length,
                itemBuilder: (context, index) {
                  EntryModel stock = entryController.entryList[index];
                  return ExpansionTile(
                    title: Text(stock.stockName),
                    subtitle: Text(stock.companyName),
                    trailing: Text(
                      '${stock.quantity} ${stock.unit}',
                      style: const TextStyle(color: Colors.blue),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                            'Date: ${DateFormat('yyyy-MM-dd').format(stock.date)}'),
                        subtitle: Text('Time: ${stock.time}'),
                      ),
                      ListTile(
                        title: Text(
                            'Available Stock: ${stock.quantity} ${stock.unit}'),
                      ),
                      ListTile(
                        title: Text(
                            'Entry Person Stock: ${stock.addEntryEmpName}'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => {},
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    setState(() {
      entryController.startDate.value = picked ?? DateTime.now();
      entryController.filterStocks();
    });
  }

}
