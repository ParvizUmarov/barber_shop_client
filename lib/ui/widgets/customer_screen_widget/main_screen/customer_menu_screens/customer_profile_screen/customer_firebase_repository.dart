import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'customer.dart';

class CustomerFirebaseRepository extends ChangeNotifier{
  final _fireStore = FirebaseFirestore.instance.collection('Customers');
  final _currentUserID = FirebaseAuth.instance.currentUser?.uid;
  final customer = Customer();


  CustomerFirebaseRepository(){
    someTest();
    notifyListeners();
  }


  Stream<User?> get user {
    return FirebaseAuth.instance.authStateChanges().map((user) => user);
  }

  Future<void> userInfo() async{

    Customer customerInfo;
     user.map((event) async {
       await _fireStore.doc(event!.uid).get().then(
               (value) {

               }
       );
     });
  }


  void someTest(){
    StreamBuilder(
      stream: user,
      builder: (context, snapshot) {
        final user = snapshot.data;
        final uid = user?.uid;
        return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: _fireStore.doc(uid).get(),
            builder: (context, snapshot) {

                   customer.setName(snapshot.data?['name']);
                   customer.setSurname(snapshot.data?['surname']);
                   customer.setEmail(snapshot.data?['email']);
                   customer.setPhone(snapshot.data?['phone']);
                   customer.setUid(snapshot.data?['uid']);

                   final n = customer.name;
                   final s = customer.surname;
                   final e = customer.email;
                   final p = customer.phone;
                   final u = customer.uid;

                   print("{$n}, {$s}, {$e}, {$p}, {$u}");
                   notifyListeners();


                  // final name = snapshot.data?['name'];
                  // final email = snapshot.data?['email'];
                  // final surname = snapshot.data?['surname'];
                  // final phone = snapshot.data?['phone'];

              return Text('Loading');
            });
      },
    );
  }

  String getName() {
    final String name = customer.name;
    return name;
  }

}