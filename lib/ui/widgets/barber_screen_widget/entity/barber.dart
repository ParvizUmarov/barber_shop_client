import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Barber extends ChangeNotifier{
  static final instance = Barber._();
  Barber._();

   String _name = '';
   String _surname = '';
   String _phone = '';
   String _email = '';

  String get getSurname => _surname;

  String get getName => _name;

  String get getPhone => _phone;

  String get getEmail => _email;

  set _setSurname(String value) {
    _surname = value;
  }

  set _setName(String value) {
    _name = value;
  }

  set _setPhone(String value) {
    _phone = value;
  }

  set _setEmail(String value) {
    _email = value;
  }

  //FirebaseAuth.instance.currentUser!.uid

  void barberInfo(String uid){
    FirebaseFirestore.instance.collection('Barbers')
        .doc(uid)
        .get()
        .then((value){

      DocumentSnapshot documentSnapshot = value;

      value.exists;

      _setName = documentSnapshot['name'];
      _setSurname = documentSnapshot['surname'];
      _setPhone = documentSnapshot['phone'];
      _setEmail = documentSnapshot['email'];
      notifyListeners();
    }
    );
  }

}