
import 'package:barber_shop/screens/app.dart';
import 'package:barber_shop/screens/barber_screen_widget/barber_profile_screen/cubit/barber_profile_cubit.dart';
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/bloc/chat_bloc/chat_bloc.dart';
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/bloc/chat_room_bloc/chat_room_bloc.dart';
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/cubit/send_message_cubit/sendMessageCubit.dart';
import 'package:barber_shop/shared/firebase/firebase_options.dart';
import 'package:barber_shop/shared/general_blocs/booking_bloc.dart';
import 'package:barber_shop/shared/general_blocs/register_bloc.dart';
import 'package:barber_shop/shared/navigation/route_name.dart';
import 'package:barber_shop/shared/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        RegisterInitialState(), context, "CUSTOMER", RouteName.customerMainScreen),),
    BlocProvider<BookingBloc>(create: (context) => BookingBloc(), lazy: false),
    BlocProvider<BarberProfileCubit>(create: (context) => BarberProfileCubit()),
    BlocProvider<ChatBloc>(create: (context) => ChatBloc()),
    BlocProvider(create: (context) => ChatRoomBloc()),
    BlocProvider(create: (context) => SendMessageCubit()),
        ],
        child:  ChangeNotifierProvider(
            create: (BuildContext context) => ThemeProvider(
                isDarkMode: prefs.getBool('isDarkMode')),
            child: AppView()));

  }
}
