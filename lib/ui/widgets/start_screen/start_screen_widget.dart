import 'package:flutter/material.dart';
import '../../../resources/resources.dart';
import '../../navigation/go_router_navigation.dart';
import '../../theme/colors/Colors.dart';

class StartScreenWidget extends StatelessWidget {
  const StartScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white ,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                    child: Image.asset(Images.logo2)
                ),
                Column(
                  children: [
                    _CustomerEntry(),
                    SizedBox(height: 20),
                    _BarberEntry(),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomerEntry extends StatelessWidget {
  const _CustomerEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: AppColors.mainListColors
          )
      ),
      child: ElevatedButton(
        onPressed:()=> router.pushNamed('customerLogin'),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.transparent),
          shadowColor: MaterialStatePropertyAll(Colors.transparent),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ))
        ),
        child: Text('Вход для клиентов',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16),),
      ),
    );
  }
}
class _BarberEntry extends StatelessWidget {
  const _BarberEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.mainColor)
      ),
      child: ElevatedButton(
        onPressed: (){
          router.pushNamed('barberLogin');
        },
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white),
          overlayColor: MaterialStatePropertyAll(Colors.grey[100]),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                ))
        ),
        child: Text('Вход для мастеров',
          style: TextStyle(
              color: AppColors.mainColor,
              fontSize: 16),),
      ),
    );
  }
}

