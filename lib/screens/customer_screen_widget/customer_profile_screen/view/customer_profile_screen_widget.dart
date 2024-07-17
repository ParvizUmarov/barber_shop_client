import 'dart:developer';

import 'package:barber_shop/screens/customer_screen_widget/customer_main_widget/view/customer_main_screen_widget.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_profile_screen/bloc/customer_profile_bloc/customer_profile_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_profile_screen/bloc/customer_profile_bloc/customer_profile_event.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_profile_screen/bloc/customer_profile_bloc/customer_profile_state.dart';
import 'package:barber_shop/shared/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/resources/resources.dart';
import '../../../../shared/theme/colors/Colors.dart';



class CustomerProfileScreenWidget extends StatefulWidget {
  const CustomerProfileScreenWidget({super.key});

  @override
  State<CustomerProfileScreenWidget> createState() =>
      _CustomerProfileScreenWidgetState();
}

class _CustomerProfileScreenWidgetState
    extends State<CustomerProfileScreenWidget> {

  // @override
  // void initState() {
  //   var databaseService = DatabaseService.instance;
  //   databaseService.deleteUser("CUSTOMER");
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CustomerProfileBloc, CustomerProfileState>(
      builder: (context, state) {
        if(state is CustomerProgressState){
          return Center(child: ShimmerWidget(typeBox: ShimmerTypeBox.profile,),);
        }else if (state is CustomerSuccessState){
          return Scaffold(
             drawer: NavBar(),
              appBar: AppBar(
                title: Text('Профиль'),
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
              body: _CustomerProfileWidget(
                  name: state.customer.name,
                  surname: state.customer.surname,
                  email: state.customer.mail,
                  phone: state.customer.phone)
          );
        }else {
          return Center(child: ShimmerWidget(typeBox: ShimmerTypeBox.profile,),);
        }

      }
    );
  }
}

class _CustomerProfileWidget extends StatelessWidget {
  const _CustomerProfileWidget({
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
  });

  final String name;
  final String surname;
  final String email;
  final String phone;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
        return BlocConsumer<CustomerProfileBloc, CustomerProfileState>(
            listener: (context, state){
              // if(state is LogoutSuccess){
              //   log('push to start screen');
              //   router.pushReplacementNamed(RouteName.startScreen);
              // }
            },
            builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _CustomerInfo(
                      height: height,
                      name: name,
                      surname: surname,
                    ),
                    SizedBox(height: 10),
                    _CustomerDetailsInfo(
                        title: 'Email', subtitle: email, leading: Icons.email),
                    SizedBox(height: 10),
                    _CustomerDetailsInfo(
                        title: 'Phone', subtitle: phone, leading: Icons.phone),
                    SizedBox(height: 10),
                    // Column(
                    //   children: [
                    //     Container(
                    //       width: 70,
                    //       height: 70,
                    //       decoration: BoxDecoration(
                    //         color: Theme.of(context).colorScheme.secondary,
                    //         borderRadius: BorderRadius.circular(30),
                    //       ),
                    //       child: IconButton(
                    //         onPressed: () {
                    //            context.read<CustomerProfileBloc>().add(Logout());
                    //         },
                    //         icon: Icon(Icons.exit_to_app),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            );
          }
        );
  }
}

class _CustomerInfo extends StatelessWidget {
  const _CustomerInfo({
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

class _CustomerDetailsInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData leading;

  const _CustomerDetailsInfo(
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
