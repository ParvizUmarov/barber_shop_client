import 'dart:developer';
import 'package:barber_shop/shared/general_blocs/auth_bloc.dart';
import 'package:barber_shop/shared/helper/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
      child: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(25)),
              width: double.infinity,

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    SizedBox(height: 70),
                    _TittleWidget(),
                    SizedBox(height: 50),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Пустое поле";
                        }else{
                          return null;
                        }
                      },
                      cursorColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.black
                              : Colors.grey,
                      controller: _emailController,
                      obscureText: false,
                      decoration: getInputDecoration('email', context,Icons.email),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Пустое поле";
                        }else{
                          return null;
                        }
                      },
                      cursorColor:
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.grey,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: getInputDecoration('password', context, Icons.lock)
                    ),
                    _ForgottenTextButton(),
                    SizedBox(height: 20),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state){
                         if (state is BarberAuthAuthorizedState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            snackBar(context, 'Авторизация прошла успешно', Colors.green),
                          );
                          router.goNamed(RouteName.barberMainScreen);
                        } else if (state is BarberFailureState) {
                          log('failure error: ${state.errorMessage}');
                          ScaffoldMessenger.of(context).showSnackBar(
                              snackBar(context, state.errorMessage, Colors.red)
                          );
                        }
                      },
                      builder: (BuildContext context, state) {
                        return GestureDetector(
                          onTap: state is BarberAuthInProgressState ? null :() {
                            if(_formKey.currentState!.validate()){
                              context.read<AuthBloc>().add(AuthLoginEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  userType: UserType.barber));
                            }
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
                              child: state is BarberAuthInProgressState
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Войти',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    _RegisterButton(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration? getInputDecoration(
      String labelText,
      BuildContext context,
      IconData suffixIcon){
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                color: Theme.of(context).brightness ==
                    Brightness.light
                    ? AppColors.mainColor
                    : Colors.transparent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                width: 2,
                color: Theme.of(context).brightness ==
                    Brightness.light
                    ? AppColors.mainColor
                    : Colors.grey)),
        suffixIcon: Icon(suffixIcon, color: Colors.grey),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary,
        border: OutlineInputBorder(
          gapPadding: 15,
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                width: 2,
                color: Colors.red)),
        errorStyle: TextStyle(
          color: Colors.red
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Theme.of(context).brightness ==
              Brightness.light
              ? AppColors.mainColor
              : Colors.grey,
        ));

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
            onPressed: () =>
                router.pushNamed(RouteName.barberResetPasswordScreen),
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
  final String? Function(String?) validator;

  const _TextFieldWidget(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.obscuredText,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
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
