
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/blocs/auth_bloc.dart';
import '../../shared/theme/colors/Colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Забыли пароль?'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Для отправки кода подтверждение введите свой email '
                  'к которому привязан аккаунт',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    child: Column(
                      children: [
                        _ResetUserEmailField(emailController: _emailController),
                        SizedBox(height: 20),
                        _ButtonSendResetPassword(email: _emailController.text,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonSendResetPassword extends StatefulWidget {
  final String email;
  const _ButtonSendResetPassword({super.key, required this.email});

  @override
  State<_ButtonSendResetPassword> createState() => _ButtonSendResetPasswordState();
}

class _ButtonSendResetPasswordState extends State<_ButtonSendResetPassword> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, snapshot) {
        final model = context.read<AuthBloc>();
        return GestureDetector(
          onTap: () => model.add(AuthResetPasswordEvent(widget.email)),
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
                'Отправить код',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        );
      }
    );
  }
}


class _ResetUserEmailField extends StatelessWidget {
  const _ResetUserEmailField({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor:
          Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.grey,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Theme.of(context).brightness ==
                          Brightness.light
                      ? AppColors.mainColor
                      : Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 2,
                  color: Theme.of(context).brightness ==
                          Brightness.light
                      ? AppColors.mainColor
                      : Colors.grey)),
          suffixIcon: Icon(Icons.email_outlined,
              color: Colors.grey),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary,
          border: OutlineInputBorder(
            gapPadding: 15,
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: 'email',
          labelStyle: TextStyle(
              color: Theme.of(context).brightness ==
                      Brightness.light
                  ? AppColors.mainColor
                  : Colors.grey)),
    );
  }
}

