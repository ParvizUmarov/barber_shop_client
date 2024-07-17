
import 'package:barber_shop/shared/general_blocs/register_bloc.dart';
import 'package:barber_shop/shared/navigation/go_router_navigation.dart';
import 'package:barber_shop/shared/navigation/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/theme/colors/Colors.dart';

class BarberRegisterWidget extends StatelessWidget {
  const BarberRegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          title: Text('Регистрация '),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
      body: _BarberRegisterBody(),
    );
  }
}

class _BarberRegisterBody extends StatelessWidget {
  _BarberRegisterBody({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              height: 600,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    _TittleWidget(),
                    SizedBox(height: 30),
                    _TextFieldWidget(
                      controller: _nameController,
                      suffixIcon: Icons.person,
                      obscureText: false,
                      labelText: "username",
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(height: 10),
                    _TextFieldWidget(
                      controller: _surnameController,
                      suffixIcon: Icons.person,
                      obscureText: false,
                      labelText: "surname",
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(height: 10),
                    _TextFieldWidget(
                        controller: _emailController,
                        suffixIcon: Icons.mail,
                        obscureText: false,
                        labelText: "email",
                        textInputType: TextInputType.emailAddress),
                    SizedBox(height: 10),
                    _TextFieldWidget(
                        controller: _numberController,
                        suffixIcon: Icons.phone,
                        obscureText: false,
                        labelText: "phone",
                        textInputType: TextInputType.phone),
                    SizedBox(height: 10),
                    _TextFieldWidget(
                      controller: _passwordController,
                      suffixIcon: Icons.lock,
                      obscureText: true,
                      labelText: "password",
                      textInputType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 20),
                    _RegisterButtonWidget(
                      passwordController: _passwordController,
                      emailController: _emailController,
                      nameController: _nameController,
                      surnameController: _surnameController,
                      phoneController: _numberController,
                    ),
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
                      ? Colors.grey
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

class _RegisterButtonWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController phoneController;

  const _RegisterButtonWidget({
    super.key,
    required this.passwordController,
    required this.emailController,
    required this.nameController,
    required this.surnameController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state){
          if(state is RegisterSuccessState){
            router.pushReplacementNamed(Routes.barberMainScreen);
          }
        },
        builder: (context, state) {
      final model = context.read<RegisterBloc>();
      return GestureDetector(
        onTap: state is RegisterInProgressState ? null : () => model.add(
          RegisterProcessEvent(
              name: nameController.text,
              surname: surnameController.text,
              email: emailController.text,
              phone: phoneController.text,
              password: passwordController.text),
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
          child:  Center(
            child:  state is RegisterInProgressState
                ? CircularProgressIndicator(color: Colors.white,)
                : Text(
              'Создать аккаунт',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      );
    });
  }
}

class _TittleWidget extends StatelessWidget {
  const _TittleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Для регистрации \nзаполните поля',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}
