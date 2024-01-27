import 'package:barber_shop/ui/widgets/customer_screen_widget/main_screen/customer_menu_screens/customer_settings_screen/customer_settings_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../colors/Colors.dart';
import '../../../../../navigation/go_router_navigation.dart';

class CustomerSettingsScreenWidget extends StatelessWidget {
  const CustomerSettingsScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = CustomerSettingsModel();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          width: double.infinity,
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Опции',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                    ),),
                  ],
                ),
                ListTile(
                  title: Text('Тема'),
                  trailing:
                    Switch(
                      activeColor: Colors.white,
                      activeTrackColor: AppColors.mainColor,
                      inactiveTrackColor: Colors.white,
                      inactiveThumbColor: AppColors.mainColor,
                      value: model.isDarkMode(context),
                      onChanged: (bool value) {  
                        model.changeThemeMode(context);
                      },)
                  // IconButton(
                  //   onPressed: ()=> model.changeThemeMode(context),
                  //   icon: Icon(Icons.shield_moon)),


                ),

                // ListTile(
                //   trailing: IconButton(
                //     onPressed: () async {
                //       await FirebaseAuth.instance.signOut();
                //     },
                //     icon: Icon(Icons.logout),),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
