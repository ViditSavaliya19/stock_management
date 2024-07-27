import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:srock_management/screen/entry/controller/entry_controller.dart';
import 'package:srock_management/screen/home/view/analysis_screen.dart';
import 'package:srock_management/screen/home/view/dash_screen.dart';
import 'package:srock_management/screen/profile/controller/profile_controller.dart';
import 'package:srock_management/screen/stock/controller/stock_controller.dart';
import 'package:srock_management/utils/constants.dart';
import 'package:srock_management/utils/helper/auth_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProfileController profileController = Get.find();
  StockController stockController = Get.put(StockController());
  EntryController entryController = Get.put(EntryController());
  int i = 0;

  @override
  void initState() {
    super.initState();
    stockController.getAllStockData();
    entryController.getAllCompanyStock();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
            onPressed: () => selectDate(context),
            icon: Icon(Icons.calendar_month),
            label: Text(DateFormat('yyyy-MM-dd')
                .format(entryController.startDate.value)),
          ),
        ],
      ),
      // drawer: Drawer(
      //   backgroundColor: Colors.lightBlue[50],
      //   child: Column(
      //     children: [
      //       Container(
      //         height: 250,
      //         alignment: Alignment.center,
      //         child: Image.asset(
      //           'assets/logo/logo.png',
      //           height: 100,
      //           width: 100,
      //         ),
      //       ),
      //       ListTile(
      //         onTap: () {
      //           Get.toNamed('profile');
      //         },
      //         leading: const Icon(Icons.person),
      //         title: const Text("Profile"),
      //         trailing: const Icon(Icons.arrow_forward_ios),
      //       ),
      //       Obx(
      //         () => Visibility(
      //           visible: profileController.userModel.value.access == "Admin",
      //           child: ListTile(
      //             onTap: () {
      //               Get.toNamed('newuser');
      //             },
      //             leading: const Icon(Icons.person_add_alt_1),
      //             title: const Text("Add New User"),
      //             trailing: const Icon(Icons.arrow_forward_ios),
      //           ),
      //         ),
      //       ),
      //       Obx(
      //         () => Visibility(
      //           visible: profileController.userModel.value.access == "Admin",
      //           child: ListTile(
      //             onTap: () {
      //               Get.toNamed('users');
      //             },
      //             leading: const Icon(Icons.group),
      //             title: const Text("All Users"),
      //             trailing: const Icon(Icons.arrow_forward_ios),
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         onTap: () {
      //           Get.toNamed('profile');
      //         },
      //         leading: const Icon(Icons.person),
      //         title: const Text("Profile"),
      //         trailing: const Icon(Icons.arrow_forward_ios),
      //       ),
      //       Obx(
      //         () => Visibility(
      //           visible: profileController.userModel.value.access == "Admin",
      //           child: ListTile(
      //             onTap: () {
      //               Get.toNamed('settings');
      //             },
      //             leading: const Icon(Icons.settings),
      //             title: const Text("Settings"),
      //             trailing: const Icon(Icons.arrow_forward_ios),
      //           ),
      //         ),
      //       ),
      //       const Spacer(),
      //       ListTile(
      //         onTap: () {
      //           AuthHelper.helper.signOut();
      //           Get.offAllNamed('login');
      //         },
      //         leading: const Icon(Icons.login),
      //         title: const Text("Sign Out"),
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: Visibility(
        visible:profileController.splashController.currentPermission.isNotEmpty  && (!(profileController.splashController.currentPermission.length==1 &&  profileController.splashController.currentPermission.contains(PERMISSION_3))) ,
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed('entry');
          },
          backgroundColor: Colors.lightBlue[50],
          child: const Icon(Icons.add),
        ),
      ),
      body: [const DashScreen(), const AnalysisScreen()][i],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: i,
        onTap: (value) {
          setState(() {
            //Assign Permission Designation wise

            if (profileController.splashController.currentPermission.contains(PERMISSION_2)) {
              i = value;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.balance), label: "Balance"),
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
