import 'package:barber_shop/firebase/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain/blocs/auth_bloc/auth_bloc.dart';
import '../../../../../../resources/resources.dart';
import '../../../../../theme/colors/Colors.dart';

class CustomerProfileScreenWidget extends StatefulWidget {
  const CustomerProfileScreenWidget({super.key});

  @override
  State<CustomerProfileScreenWidget> createState() =>
      _CustomerProfileScreenWidgetState();
}

class _CustomerProfileScreenWidgetState
    extends State<CustomerProfileScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final user = snapshot.data;
            final uid = user?.uid;
            final customers = FirebaseFirestore.instance
                .collection(FirebaseCollections.customers);
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

                      // final customer = Customer();
                      // customer.setName(snapshot.data?['name']);
                      // customer.setSurname(snapshot.data?['surname']);
                      // customer.setEmail(snapshot.data?['email']);
                      // customer.setPhone(snapshot.data?['phone']);
                      // customer.setUid(snapshot.data?['uid']);

                      //snapshot.data?['name'],
                      //                           snapshot.data?['surname'],
                      //                           snapshot.data?['surname'],
                      //                           snapshot.data?['phone'],
                      //                           snapshot.data?['uid']

                      return _CustomerProfileWidget(
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
        ));
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final model = context.read<AuthBloc>();
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
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: () => model.add(AuthLogoutEvent()),
                        icon: Icon(Icons.exit_to_app),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
