import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:srock_management/componets/headers.dart';
import 'package:srock_management/screen/spalsh/controller/spalsh_controller.dart';
import 'package:srock_management/utils/helper/firedb_helper.dart';

import '../../../utils/constants.dart';
import '../../entry/controller/entry_controller.dart';
import '../../entry/model/entry_model.dart';
import '../../profile/controller/profile_controller.dart';
import '../../stock/controller/stock_controller.dart';
import '../../stock/model/stock_model.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  ProfileController profileController = Get.put(ProfileController());
  EntryController entryController = Get.put(EntryController());
  StockController stockController = Get.put(StockController());
  SplashController splashController =Get.find();
  final _formKey = GlobalKey<FormState>();

  String? _selectedStockName;
  final TextEditingController _quantityController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final List<String> _units = ['liters', 'tonne','kg']; // Units for selection
  String? _selectedUnit = 'liters'; // Default unit

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
                //Assign Permission Designation wise
                Obx(
                  () => Visibility(
                    visible: profileController
                        .splashController.currentPermission
                        .contains(PERMISSION_1) || profileController
                        .splashController.currentPermission
                        .contains(PERMISSION_3),
                    child: Expanded(
                      child: DropdownButtonFormField<String>(
                        value: entryController.selectedCompany.value,
                        items: splashController.companyList.map((company) {
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
                      //Assign Permission Designation wise
                      Visibility(
                        visible: profileController
                                .splashController.currentPermission
                                .contains(PERMISSION_1) ||
                            profileController.splashController.currentPermission
                                .contains(PERMISSION_4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                              visible:profileController.userModel.value.department![0]==entryController.entryList[index].companyName || profileController.userModel.value.designation![0] =="Admin",
                              child: IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  updateEntryDialog(stock);
                                },
                              ),
                            ),
                            Visibility(
                              visible:profileController.userModel.value.department![0]==entryController.entryList[index].companyName || profileController.userModel.value.designation![0] =="Admin",
                              child: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  FireDbHelper.helper
                                      .deleteEntryStock(stock.docId!);
                                },
                              ),
                            ),
                          ],
                        ),
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

  void updateEntryDialog(EntryModel entryModel) {
    _selectedStockName =
        entryModel.stockName == "All" ? null : entryModel.stockName;

    print("${_selectedStockName}");
    _quantityController.text = entryModel.quantity.toString();
    _selectedUnit = entryModel.unit;
    List timeList = entryModel.time.split(":");
    _selectedTime =
        TimeOfDay(hour: int.parse(timeList[0]), minute: int.parse(timeList[1]));
    _selectedDate = entryModel.date;

    Get.defaultDialog(
      title: "Update Stock Entry",
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: entryModel.companyName,
                decoration: const InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 20.0),
              Obx(
                () => DropdownButtonFormField<String>(
                  value: _selectedStockName,
                  items: stockController.stockList.map((StockModel stock) {
                    return DropdownMenuItem<String>(
                      value: stock.stockName,
                      child: Text(stock.stockName!),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedStockName = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Stock Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a stock name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _quantityController,
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the quantity';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedUnit,
                      items: _units.map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedUnit = newValue;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Unit',
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
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.calendar_today),
                      label:
                          Text(DateFormat('yyyy-MM-dd').format(_selectedDate)),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.access_time),
                      label: Text(_selectedTime.format(context)),
                      onPressed: () => _selectTime(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Update'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Retrieve the form data
              _submitForm(entryModel.docId!,entryModel);
            }
          },
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitForm(String docId, EntryModel model) {
    if (_formKey.currentState!.validate() && _selectedStockName != null) {
      int quantity = int.parse(_quantityController.text.trim());

      EntryModel entryModel = EntryModel(
          stockName: _selectedStockName!,
          companyName: model.companyName,
          date: _selectedDate,
          time: "${_selectedTime.hour}:${_selectedTime.minute}",
          quantity: quantity,
          unit: _selectedUnit!,
          addEntryEmpName: model.addEntryEmpName);

      FireDbHelper.helper.updateEntryStock(entryModel,docId);
    }
  }
}
