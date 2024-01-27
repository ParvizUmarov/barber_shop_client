import 'package:barber_shop/ui/helper/display_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../../colors/Colors.dart';
import '../../../../../domain/services/firebase_service/create_user.dart';
import '../../../../navigation/go_router_navigation.dart';

class CustomerRegisterModel extends ChangeNotifier{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final user = CreateUser();

  Future<UserCredential> registerWithEmailAndPassword (
      String email,
      String password,
      BuildContext context,
      ) async {

    try{
      UserCredential userCredential =
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password);

      return userCredential;
    }on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  void registerCustomer (
      BuildContext context,
      TextEditingController customerName,
      TextEditingController customerEmail,
      TextEditingController customerPassword,
      TextEditingController customerSurname,
      TextEditingController customerPhoneNumber
      ) async{

    final email = customerEmail.text;
    final password = customerPassword.text;

    //showing loading circle
    showDialog(
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(
            color: AppColors.mainColor,
          ),
        ));

    try{
      final userCredential =
          await registerWithEmailAndPassword(
              email,
              password,
              context);

      user.createUserDocument(
        'Customers',
        userCredential,
        customerName,
        customerSurname,
        customerPhoneNumber);
      
      if(context.mounted){
        router.pushReplacementNamed('customerMainScreen');
        notifyListeners();
      }else{
        return;
      }
      
    }catch(e){
      router.pop();
      snackBarMessage(e.toString(), context);
    }
  }
}

