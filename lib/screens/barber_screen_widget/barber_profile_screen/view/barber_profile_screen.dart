import 'dart:developer';
import 'package:barber_shop/shared/general_blocs/auth_bloc.dart';
import 'package:barber_shop/shared/resources/resources.dart';
import 'package:barber_shop/shared/navigation/go_router_navigation.dart';
import 'package:barber_shop/shared/navigation/route_name.dart';
import 'package:barber_shop/shared/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/barber_profile_bloc.dart';

class BarberProfileScreen extends StatefulWidget {
  const BarberProfileScreen({super.key});

  @override
  State<BarberProfileScreen> createState() => _BarberProfileScreenState();
}

class _BarberProfileScreenState extends State<BarberProfileScreen> {

  @override
  void initState() {
    context.read<BarberProfileBloc>().add(GetBarberProfileInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: BlocConsumer<BarberProfileBloc, BarberProfileState>(
            listener: (context, barberState){
              if(barberState is LogoutState){
                router.pushReplacementNamed(Routes.startScreen);
              }
            },
            builder: (context, barberState) {
              if(barberState is ProfileInProgress){
                return Center(child: ShimmerWidget(typeBox: ShimmerTypeBox.profile,));
              }else if(barberState is ProfileSuccess){
            final barber = barberState.barber;
            return _BarberProfileWidget(
                name: barber.name ?? '',
                surname: barber.surname ?? '',
                email: barber.mail ?? '',
                phone: barber.phone ?? '',
              birthday: barber.birthday ?? '',
              workExperience: barber.workExperience ?? 0,);
          }else{
                return Center(child: Text('Вам нужно авторизоваться'));
          }
        }),
      ),
    );
  }
}

class _BarberProfileWidget extends StatefulWidget {
  final String name;
  final String surname;
  final String email;
  final String phone;
  final String birthday;
  final int workExperience;

  const _BarberProfileWidget(
      {required this.name,
      required this.surname,
      required this.email,
      required this.phone,
        required this.birthday,
        required this.workExperience});

  @override
  State<_BarberProfileWidget> createState() => _BarberProfileWidgetState();
}

class _BarberProfileWidgetState extends State<_BarberProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthBloc>();

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Center(
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
                  _BarberDetailsInfo(
                      title: 'Birthday',
                      subtitle: widget.birthday,
                      leading: Icons.date_range_sharp),
                  SizedBox(height: 10),
                  _BarberDetailsInfo(
                      title: 'Стаж работы (год)',
                      subtitle: widget.workExperience.toString(),
                      leading: Icons.work_history_outlined),
                  SizedBox(height: 10),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: (){
                        context.read<BarberProfileBloc>().add(Logout());
                      },
                      icon: Icon(Icons.exit_to_app),
                    ),
                  ),
                ],
              ),
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
