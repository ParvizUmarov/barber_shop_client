import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../colors/Colors.dart';

import '../../../../../domain/services/firebase_service/create_user.dart';
import '../../../../helper/display_message.dart';
import '../../../../navigation/go_router_navigation.dart';

class BarberRegisterModel extends ChangeNotifier{
  final user = CreateUser();
  
  void onPressedRegisterButton (
      BuildContext context,
      TextEditingController barberName,
      TextEditingController barberEmail,
      TextEditingController barberPassword,
      TextEditingController barberSurname,
      TextEditingController barberPhone,
      ) async{
    //showing loading circle
    showDialog(
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(
            color: AppColors.mainColor,
          ),
        ));

    try{
      UserCredential? userCredential =
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: barberEmail.text,
          password: barberPassword.text);

      user.createUserDocument(
          'Barbers',
          userCredential,
          barberName,
          barberSurname,
          barberPhone);

      if(context.mounted) router.pushReplacementNamed('barberMainScreen');
      notifyListeners();

    }on FirebaseAuthException catch(e){
      router.pop();
      displayMessageToUser(e.code, context);
    }
  }
  
}