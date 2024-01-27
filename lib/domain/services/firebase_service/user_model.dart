import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel{
  final String? _id;

  UserModel({required String id}) : _id = id;

   Future<Map<String, dynamic>> userInfo(
       String nameOfData,
       String nameOfCollection) async {
     Map<String, dynamic> mapOfData = HashMap();

     final firestore =  FirebaseFirestore.instance.collection(nameOfCollection);
     final uid = _id;

     FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
         future: firestore.doc(uid).get(),
         builder: (context, snapshot) {
           mapOfData.addAll(snapshot.data?[nameOfData]);
           return snapshot.data?[nameOfData];
         }
     );

    // StreamBuilder(
    //   stream: FirebaseAuth.instance.authStateChanges(),
    //   builder: (context, snapshot) {
    //     final uid = _id;
    //     final customers =
    //     FirebaseFirestore.instance.collection(nameOfCollection);
    //     return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    //         future: customers.doc(uid).get(),
    //         builder: (context, snapshot) {
    //           mapOfData.addAll(snapshot.data?[nameOfData]);
    //               return snapshot.data?[nameOfData];
    //           }
    //        );
    //   },
    // );

    return mapOfData;

  }



}