import 'package:barber_shop/firebase_options.dart';
import 'package:barber_shop/theme/theme_provider.dart';
import 'package:barber_shop/ui/app/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
      ChangeNotifierProvider(
          create: (BuildContext context) => ThemeProvider(),
          child: MyApp()));
}