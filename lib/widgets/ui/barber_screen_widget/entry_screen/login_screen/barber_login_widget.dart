import 'package:barber_shop/firebase/firebase_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/blocs/auth_bloc.dart';
import '../../../../shared/navigation/go_router_navigation.dart';
import '../../../../shared/navigation/route_name.dart';
import '../../../../shared/theme/colors/Colors.dart';


class BarberLoginWidget extends StatelessWidget {
  const BarberLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
            title: Text('Авторизация'),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
        body: _BarberScreenBody());
  }
}

class _BarberScreenBody extends StatelessWidget {
  _BarberScreenBody({
    super.key,
  });

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
      child: ListView(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(25)),
              width: double.infinity,
              height: 500,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    SizedBox(height: 70),
                    _TittleWidget(),
                    SizedBox(height: 50),
                    _TextFieldWidget(
                        controller: _emailController,
                        labelText: 'email',
                        obscuredText: false),
                    SizedBox(height: 15),
                    _TextFieldWidget(
                        controller: _passwordController,
                        labelText: 'password',
                        obscuredText: true),
                    _ForgottenTextButton(),
                    SizedBox(height: 20),
                    _LoginButtonWidget(
                      passwordController: _passwordController,
                      emailController: _emailController,
                    ),
                    SizedBox(height: 10),
                    _RegisterButton()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Нет аккаунта?  '),
          GestureDetector(
              onTap: () => router.pushNamed(RouteName.barberRegisterScreen),
              child: Text(
                'Регистрация',
                style: TextStyle(
                  color: Color(-9285227),
                ),
              ))
        ],
      ),
    );
  }
}

class _LoginButtonWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _LoginButtonWidget({
    super.key,
    required this.passwordController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, state) {
        final model = context.read<AuthBloc>();
        return GestureDetector(
          onTap: () => model.add(
            AuthLoginEvent(
                email: emailController.text,
                password: passwordController.text,
                collectionName: FirebaseCollections.barbers),
          ),
          child: Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: const <Color>[
                Color(-9285227),
                Color(-9942382),
                Color(-11453304),
              ]),
            ),
            child: const Center(
              child: Text(
                'Войти',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ForgottenTextButton extends StatelessWidget {
  const _ForgottenTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () => router.pushNamed(RouteName.barberResetPasswordScreen),
            child: Text(
              'Забыли пароль?',
              style: TextStyle(
                color: Color(-9285227),
              ),
            ))
      ],
    );
  }
}

class _TittleWidget extends StatelessWidget {
  const _TittleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Добро пожаловать!',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}

class _TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscuredText;

  const _TextFieldWidget(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.obscuredText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.grey,
      controller: controller,
      obscureText: obscuredText,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.mainColor
                      : Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 2,
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.mainColor
                      : Colors.grey)),
          suffixIcon: Icon(Icons.email, color: Colors.grey),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary,
          border: OutlineInputBorder(
            gapPadding: 15,
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.mainColor
                : Colors.grey,
          )),
    );
  }
}
