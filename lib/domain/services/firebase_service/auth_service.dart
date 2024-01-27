import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../colors/Colors.dart';
import '../../../ui/navigation/go_router_navigation.dart';


class AuthService extends ChangeNotifier{
  final String userMainScreenPushNamed;

  AuthService({
    required this.userMainScreenPushNamed
  });

  Future<bool> isAuth() async {
    final idToken = FirebaseAuth.instance.currentUser?.getIdToken();
    final isAuth = idToken != null;
    return isAuth;
  }


  Future<UserCredential> _signInWithEmailAndPassword (
      String email,
      String password,
      BuildContext context,
      ) async {

    try{
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);
      return userCredential;
    }on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }


  Future<void> login(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController,
      ) async {

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

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);

      if(context.mounted){
        router.pushReplacementNamed(userMainScreenPushNamed);
        router.pop();
        notifyListeners();
      }else{
        return;
      }
    }catch(exception){
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