
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../navigation/go_router_navigation.dart';
import '../theme/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}