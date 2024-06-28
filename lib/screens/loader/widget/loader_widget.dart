
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/navigation/go_router_navigation.dart';
import '../../../shared/navigation/route_name.dart';
import '../../../shared/theme/colors/Colors.dart';
import 'loader_view_model.dart';


class LoaderWidget extends StatefulWidget {
  const LoaderWidget({super.key});

  @override
  State<LoaderWidget> createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> {
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
      BuildContext context, LoaderViewCubitState state) {
    if (state == LoaderViewCubitState.barberAuthorized) {
      router.pushReplacementNamed(RouteName.barberMainScreen);
    } else if (state == LoaderViewCubitState.customerAuthorized) {
      router.pushReplacementNamed(RouteName.customerMainScreen);
    } else if (state == LoaderViewCubitState.newVisitor) {
      router.pushReplacementNamed(RouteName.startScreen);
    }
  }
}
