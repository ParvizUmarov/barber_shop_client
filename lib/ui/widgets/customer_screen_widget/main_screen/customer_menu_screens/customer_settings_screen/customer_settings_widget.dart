import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../colors/Colors.dart';
import '../../../../../../theme/theme_provider.dart';

class CustomerSettingsScreenWidget extends StatelessWidget {
  const CustomerSettingsScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
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
                    Text(
                      'Опции',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ],
                ),
                ListTile(
                    title: Text('Тема'),
                    trailing: Switch(
                      activeColor: Colors.white,
                      activeTrackColor: AppColors.mainColor,
                      inactiveTrackColor: Colors.white,
                      inactiveThumbColor: AppColors.mainColor,
                      value: themeProvider.getThemeMode,
                      onChanged: (bool value) {
                        themeProvider.toggleTheme(value);
                      },
                    )
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
