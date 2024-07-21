import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:srock_management/screen/entry/model/entry_model.dart';
import 'package:srock_management/screen/profile/controller/profile_controller.dart';
import 'package:srock_management/screen/stock/controller/stock_controller.dart';
import 'package:srock_management/screen/stock/model/stock_model.dart';

import '../../../utils/helper/firedb_helper.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  ProfileController profileController = Get.find();
  StockController stockController = Get.put(StockController());



  final _formKey = GlobalKey<FormState>();
  String? _selectedStockName;
  final TextEditingController _quantityController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final List<String> _units = ['kg', 'tonne']; // Units for selection
  String? _selectedUnit = 'kg'; // Default unit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // TextFormField(
              //   initialValue: profileController.userModel.value.department!,
              //   decoration: const InputDecoration(
              //     labelText: 'Company Name',
              //     border: OutlineInputBorder(),
              //   ),
              //   enabled: false,
              // ),
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
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Stock'),
              ),
            ],
          ),
        ),
      ),
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

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _selectedStockName != null) {
      int quantity = int.parse(_quantityController.text.trim());

      // EntryModel entryModel = EntryModel(
      //     stockName: _selectedStockName!,
      //     companyName: profileController.userModel.value.department!,
      //     date: _selectedDate,
      //     time: "${_selectedTime.hour}:${_selectedTime.minute}",
      //     quantity: quantity,
      //     unit: _selectedUnit!,
      //     addEntryEmpName: profileController.userModel.value.name!);
      //
      // await FireDbHelper.helper.addStockEntryToFirestore(entryModel);

    }
  }
}
