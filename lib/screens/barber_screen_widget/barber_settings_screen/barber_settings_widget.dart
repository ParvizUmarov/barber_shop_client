import 'package:flutter/material.dart';
import '../../../shared/theme/colors/Colors.dart';
import 'barber_settings_model.dart';

class BarberSettingsWidget extends StatefulWidget {
  const BarberSettingsWidget({super.key});

  @override
  State<BarberSettingsWidget> createState() => _BarberSettingsWidgetState();
}

class _BarberSettingsWidgetState extends State<BarberSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    final model = BarberSettingsModel();
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
                        model.changeThemeMode(context, value);
                      },)
                  // IconButton(
                  //   onPressed: ()=> model.changeThemeMode(context),
                  //   icon: Icon(Icons.shield_moon)),


                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
