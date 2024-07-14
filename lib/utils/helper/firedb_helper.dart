import 'package:cloud_firestore/cloud_firestore.dart';

import '../../screen/entry/model/entry_model.dart';

class FireDbHelper {
  static FireDbHelper helper = FireDbHelper._();

  FireDbHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> addNewAccessEmpData(
      {name, email, password, department, mobile, uid}) async {
    await fireStore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'password': password,
      'department': department,
      'mobile': mobile,
      'uid': uid,
      'access': "Emp",
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfileData(uid) {
    return fireStore.collection("users").doc(uid).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUserData() {
    return fireStore.collection("users").get();
  }

  Future<void> addStockToFireStore(String stockName) async {
    await fireStore.collection('stocks').add({
      'name': stockName,
    });
    getAllStockData();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllStockData() {
    return fireStore.collection("stocks").get();
  }

  void updateStock() {}

  void deleteStock() {}

  Future<void> addStockEntryToFirestore(EntryModel stock) async {
    try {
      await fireStore.collection('company_stocks').add(stock.toFirestore());
    } catch (e) {
      print('Error adding stock: $e');
    }
  }

  Stream<List<EntryModel>> getCompanyStockStream() {
    return FirebaseFirestore.instance.collection('company_stocks').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => EntryModel.fromFirestore(doc)).toList();
    });
  }

}
