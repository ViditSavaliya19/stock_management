
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EntryModel {
  String stockName;
  String companyName;
  DateTime date;
  String time;
  int quantity;
  String unit;
  String addEntryEmpName;
  String? docId;

  EntryModel({
    required this.stockName,
    required this.companyName,
    required this.date,
    required this.time,
    required this.quantity,
    required this.unit,
    required this.addEntryEmpName,
    this.docId
  });

  factory EntryModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return EntryModel(
      docId: doc.id ,
      stockName: data['stockName'] ?? '',
      companyName: data['companyName'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      time: data['time'] as String,
      quantity: data['quantity'] ?? 0,
      unit: data['unit'] ?? '',
      addEntryEmpName: data['addName'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'stockName': stockName,
      'companyName': companyName,
      'date': date,
      'time': time,
      'quantity': quantity,
      'unit': unit,
      'addName': addEntryEmpName,
    };
  }
}