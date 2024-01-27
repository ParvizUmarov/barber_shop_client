import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../../colors/Colors.dart';
import '../../../../navigation/go_router_navigation.dart';


class BarberLoginModule extends ChangeNotifier {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void onPressedRegisterButton() {
    router.pushNamed('barberRegister');
  }


  // signIn method
  Future<UserCredential> _signInWithEmailAndPassword(String email,
      String password,
      BuildContext context,) async {
    try {
      UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password);

      _firestore.collection('Barbers').doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));


      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signIn(BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController,) async {
    final email = emailController.text;
    final password = passwordController.text;

    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.mainColor,
            ),
          );
        }
    );

    try {
      await _signInWithEmailAndPassword(email, password, context);

      if (context.mounted) {
        router.pushReplacementNamed('barberMainScreen');
        router.pop();
        notifyListeners();
      } else {
        return;
      }
    } catch (exception) {
      router.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(exception.toString(),
            style: TextStyle(
                color: Colors.red
            ),
          ),
        ),
      );
    }
  }
}

void _userInfoToEntity(){
  FirebaseFirestore.instance.collection('Barbers').get()
      .then((value) => {
        value.docs.forEach((element) {
            print(element.data());
        })
  });

}