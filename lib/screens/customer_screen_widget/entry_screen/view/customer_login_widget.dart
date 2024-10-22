
import 'package:barber_shop/shared/general_blocs/auth_bloc.dart';
import 'package:barber_shop/shared/helper/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/navigation/go_router_navigation.dart';
import '../../../../shared/navigation/route_name.dart';
import '../../../../shared/theme/colors/Colors.dart';

class CustomerLoginWidget extends StatelessWidget {
  const CustomerLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          title: Text(
            'Авторизация',
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
      body: _CustomerScreenBody(),
    );
  }
}

class _CustomerScreenBody extends StatelessWidget {
  _CustomerScreenBody({
    super.key,
  });

  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

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
                        suffixIcon: Icons.email,
                        obscureText: false,
                        labelText: 'email',
                        textInputType: TextInputType.emailAddress),
                    SizedBox(height: 15),
                    _TextFieldWidget(
                        controller: _passwordController,
                        suffixIcon: Icons.lock,
                        obscureText: true,
                        labelText: 'password',
                        textInputType: TextInputType.visiblePassword),
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
              onTap: () => router.pushNamed(Routes.customerRegisterScreen),
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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state){
        if(state is CustomerAuthAuthorizedState){
          router.goNamed(Routes.customerHomePage);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   snackBar(context, 'Авторизация прошла успешно', Colors.green),
          // );
        }else if(state is CustomerFailureState){
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(context, 'Неправильный пароль или почта', Colors.red),
          );
        }
      },
      builder: (BuildContext context, state) {
        final model = context.read<AuthBloc>();
        return GestureDetector(
          onTap: state is CustomerAuthInProgressState ? null : () {
              model.add(
                AuthLoginEvent(
                    email: emailController.text,
                    password: passwordController.text,
                    userType: UserType.customer),
              );
          },
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
            child: Center(
              child: state is CustomerAuthInProgressState
                 ? CircularProgressIndicator(color: Colors.white,)
                  : Text(
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
            onPressed: () {
              router.pushNamed(Routes.customerResetPasswordScreen);
            },
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
  final IconData suffixIcon;
  final bool obscureText;
  final String labelText;
  final TextInputType textInputType;

  const _TextFieldWidget(
      {super.key,
      required this.controller,
      required this.suffixIcon,
      required this.obscureText,
      required this.labelText,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.grey,
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
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
          suffixIcon: Icon(suffixIcon, color: Colors.grey),
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
                  : Colors.grey)),
    );
  }
}
