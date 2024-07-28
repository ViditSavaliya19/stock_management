import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:srock_management/screen/entry/model/entry_model.dart';
import 'package:srock_management/screen/entry/view/all_entry_screen.dart';
import 'package:srock_management/screen/entry/view/single_entry_screen.dart';
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
  final List<String> _units = ['liters', 'tonne', 'kg']; // Units for selection
  String? _selectedUnit = 'kg'; // Default unit

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Text("Data"),
              Expanded(
                child: TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(
                      text: "Bulk Entry",
                    ),
                    Tab(
                      text: "Single Entry",
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllEntryScreen(),
            SingleEntryScreen(),
          ],
        )
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

      EntryModel entryModel = EntryModel(
          stockName: _selectedStockName!,
          companyName: profileController.userModel.value.department![0],
          date: _selectedDate,
          time: "${_selectedTime.hour}:${_selectedTime.minute}",
          quantity: quantity,
          unit: _selectedUnit!,
          addEntryEmpName: profileController.userModel.value.name!);

      await FireDbHelper.helper.addStockEntryToFireStore(entryModel);
      Get.back();
    }
  }


}
