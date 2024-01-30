import 'package:barber_shop/ui/widgets/barber_screen_widget/main_screen/barber_menu_screens/barber_profile_screen/barber_profile_module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../colors/Colors.dart';
import '../../../../../../resources/resources.dart';
import '../../../auth_bloc/barber_auth_bloc.dart';
import '../../../entity/barber.dart';

class BarberProfileScreen extends StatelessWidget {
  const BarberProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
            child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final user = snapshot.data;
            final uid = user?.uid;
            final customers = FirebaseFirestore.instance.collection('Barbers');
            return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: customers.doc(uid).get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Упс... Что та пошло не так'));
                  } else {
                    if (snapshot.hasData) {
                      final name = snapshot.data?['name'];
                      final email = snapshot.data?['email'];
                      final surname = snapshot.data?['surname'];
                      final phone = snapshot.data?['phone'];
                      double height = MediaQuery.of(context).size.height;

                      return _BarberProfileWidget(
                          name: name,
                          surname: surname,
                          email: email,
                          phone: phone);
                    } else {
                      return Center(child: Text('Нет данных'));
                    }
                  }
                });
          },
        )));
  }
}

class _BarberProfileWidget extends StatefulWidget {
  final String name;
  final String surname;
  final String email;
  final String phone;

  const _BarberProfileWidget(
      {required this.name,
      required this.surname,
      required this.email,
      required this.phone});

  @override
  State<_BarberProfileWidget> createState() => _BarberProfileWidgetState();
}

class _BarberProfileWidgetState extends State<_BarberProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<BarberAuthBloc>();
    //final barber = context.watch<Barber>();
    // setState(() {
    //   barber.barberInfo(FirebaseAuth.instance.currentUser!.uid);
    // });

    return BlocBuilder<BarberAuthBloc, BarberAuthState>(
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _BarberInfo(
                  height: MediaQuery.of(context).size.height,
                  name: widget.name,
                  surname: widget.surname,
                ),
                SizedBox(height: 10),
                _BarberDetailsInfo(
                    title: 'Email',
                    subtitle: widget.email,
                    leading: Icons.email),
                SizedBox(height: 10),
                _BarberDetailsInfo(
                    title: 'Phone',
                    subtitle: widget.phone,
                    leading: Icons.phone),
                SizedBox(height: 10),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: () => model.add(BarberAuthLogoutEvent()),
                    icon: Icon(Icons.exit_to_app),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BarberInfo extends StatelessWidget {
  const _BarberInfo({
    super.key,
    required this.height,
    required this.name,
    required this.surname,
  });

  final double height;
  final String name;
  final String surname;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.3,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double innerHeight = constraints.maxHeight;
          double innerWidth = constraints.maxWidth;
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: innerHeight * 0.65,
                  width: innerWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 75),
                      Text(
                        '$name $surname',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: SizedBox(
                      width: innerWidth * 0.40,
                      child: Image.asset(
                        Images.userAvatar,
                        fit: BoxFit.fitWidth,
                      )),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class _BarberDetailsInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData leading;

  const _BarberDetailsInfo(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.leading});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 95,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                leading,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              title: Text(
                title,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
