
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateUser {

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //create a user document and collect them
  Future<void> createUserDocument(
      String nameOfCollection,
      UserCredential userCredential,
      TextEditingController name,
      TextEditingController surname,
      TextEditingController phone,
      ) async {
    final email = userCredential.user!.email;
    final username = name.text;
    final String uid = userCredential.user!.uid;
    final userSurname = surname.text;
    final userPhone = phone.text;

    if(userCredential.user != null){

      await _firebaseFirestore.collection(nameOfCollection)
          .doc(userCredential.user!.uid)
          .set({
        'uid' : uid,
        'email' : email,
        'name' : username,
        'surname' : userSurname,
        'phone' : userPhone
      }
      );
    }

  }
}

