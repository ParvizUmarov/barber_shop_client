import 'package:barber_shop/firebase/firebase_options.dart';
import 'package:barber_shop/widgets/app.dart';
import 'package:barber_shop/widgets/shared/navigation/route_name.dart';
import 'package:barber_shop/widgets/shared/theme/theme_provider.dart';
import 'package:barber_shop/widgets/ui/customer_screen_widget/entry_screen/register_screen/customer_register_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/blocs/booking_bloc.dart';
import 'domain/blocs/register_bloc.dart';
import 'firebase/firebase_collections.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(App(prefs: prefs));
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.prefs,
  });

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
    BlocProvider<RegisterBloc>(create: (context) => RegisterBloc(
        RegisterInProgressState(), context, FirebaseCollections.customers, RouteName.customerMainScreen),),
    BlocProvider<BookingBloc>(create: (context) => BookingBloc(), lazy: false),


        ],
        child:  ChangeNotifierProvider(
            create: (BuildContext context) => ThemeProvider(
                isDarkMode: prefs.getBool('isDarkMode')),
            child: AppView()));

  }
}
