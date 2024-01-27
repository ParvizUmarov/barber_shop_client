import 'package:barber_shop/ui/widgets/loader/loader_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../colors/Colors.dart';
import '../../navigation/go_router_navigation.dart';

class LoaderWidget extends StatefulWidget {
  const LoaderWidget({super.key});

  @override
  State<LoaderWidget> createState() => _LoaderWidgetState();

}

class _LoaderWidgetState extends State<LoaderWidget>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoaderViewCubit, LoaderViewCubitState>(
        listenWhen: (prev, current) => current != LoaderViewCubitState.unknown,
        listener: onLoaderViewCubitStateChange,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.mainColor,
          ),
        ),
      ),
    );
  }

  void onLoaderViewCubitStateChange(
      BuildContext context,
      LoaderViewCubitState state
      ) {

    final nextScreen = state == LoaderViewCubitState.authorized
    //customerMainScreen
        ? 'customerMainScreen'
        : 'startScreen';
    router.pushReplacementNamed(nextScreen);

  }

}
