import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:srock_management/model/designation_model.dart';
import 'package:srock_management/model/user_model.dart';
import 'package:srock_management/screen/stock/model/stock_model.dart';
import 'package:srock_management/screen/user_register/model/permission_model.dart';

import '../../screen/entry/model/entry_model.dart';

class FireDbHelper {
  static FireDbHelper helper = FireDbHelper._();

  FireDbHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //Get All Registered Company List (Splash Screen)
  Future<QuerySnapshot<Map<String, dynamic>>> getCompanyNameList() {
    return fireStore.collection("Company").get();
  }

  // Create new user by Admin Function (Add / Update)
  Future<void> createNewUser({required UserModel model}) async {
    await fireStore.collection('users').doc(model.uid).set(model.toFireStore());
  }

  // delete user by Admin Function (Add / Update)
  Future<void> deleteUser({required String uid}) async {
    await fireStore.collection('users').doc(uid).delete();
  }

  // Get Profile (SplashScreen & SignIn Screen)
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfileData(uid) {
    return fireStore.collection("users").doc(uid).get();
  }

  //Get All Registered UserList (UserList Screen)
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUserData() {
    return fireStore.collection("users").get();
  }

  // Add Stock (Stock Screen)
  Future<void> addStockToFireStore(String stockName) async {
    await fireStore.collection('stocks').add({
      'name': stockName,
    });
    getAllStockData();
  }

  //Get Added Stock List (Stock Screen)
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllStockData() {
    return fireStore.collection("stocks").snapshots();
  }

  //Update Stock (Stock Screen)
  Future<void> updateStock(StockModel stock, String docID) async {
   await fireStore.collection("stocks").doc(docID).set({
      'name': stock.stockName,
    });
  }

  //Delete Stock (Stock Screen)
  Future<void> deleteStock(String docID) async {
   await fireStore.collection("stocks").doc(docID).delete();
  }

  //Daily Stock Entry department wise (Entry Screen)
  Future<void> addStockEntryToFireStore(EntryModel stock) async {
    try {
      await fireStore.collection('company_stocks').add(stock.toFirestore());
    } catch (e) {
      print('Error adding stock: $e');
    }
  }

  //Update Daily Stock Entry department wise (Dash Screen)
  void updateEntryStock(EntryModel e1, String docID) async {
    await fireStore
        .collection('company_stocks')
        .doc(docID)
        .set(e1.toFirestore());
  }

  //Delete Daily Stock Entry department wise (Dash Screen)
  void deleteEntryStock(String docID) async {
    await fireStore.collection('company_stocks').doc(docID).delete();
  }

  //Get Daily Stock Entry department wise (Entry Screen)
  Stream<List<EntryModel>> getCompanyStockStream() {
    return FirebaseFirestore.instance
        .collection('company_stocks')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => EntryModel.fromFirestore(doc)).toList();
    });
  }

  //Get All Designation (Splash Screen)
  Future<QuerySnapshot<Map<String, dynamic>>> getDesignation() {
    return fireStore.collection("Designation").get();
  }

  //Update Designation (Permission Alert)
  void updateDetailPermission(DesignationModel model) async {
    await fireStore
        .collection('Designation')
        .doc(model.docId)
        .set(model.modelToMap());
  }








}
