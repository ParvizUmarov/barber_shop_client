import 'package:barber_shop/ui/widgets/customer_screen_widget/loader/customer_loader_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../colors/Colors.dart';
import '../../navigation/go_router_navigation.dart';
import '../barber_screen_widget/loader/barber_loader_view_model.dart';

class LoaderWidget extends StatefulWidget {
  const LoaderWidget({super.key});

  @override
  State<LoaderWidget> createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> {


  @override
  Widget build(BuildContext context) {
    bool isBarberAuthorized;
    bool isCustomerAuthorized;

    void onBarberLoaderViewCubitStateChange(
        BuildContext context, BarberLoaderViewCubitState state) {
      if(state == BarberLoaderViewCubitState.authorized){
        isBarberAuthorized = true;
      }else{
        isBarberAuthorized = false;
      }
    }

    void onCustomerLoaderViewCubitStateChange(
        BuildContext context, CustomerLoaderViewCubitState state) {
      if(state == CustomerLoaderViewCubitState.authorized){
        isCustomerAuthorized = true;
      }else{
        isCustomerAuthorized = false;
      }
    }

    // setState(() {
    //   if(isBarberAuthorized == true){
    //     router.pushReplacementNamed('barberMainScreen');
    //   }else if(isCustomerAuthorized == true){
    //     router.pushReplacementNamed('customerMainScreen');
    //   }else{
    //     router.pushReplacementNamed('startScreen');
    //   }
    // });

    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<BarberLoaderViewCubit, BarberLoaderViewCubitState>(
              listener: (context, state){
                if(state == BarberLoaderViewCubitState.authorized){
                  isBarberAuthorized = true;
                }else{
                  isBarberAuthorized = false;
                }
              }),
          BlocListener<CustomerLoaderViewCubit, CustomerLoaderViewCubitState>(
              listener: (context, state){
                if(state == CustomerLoaderViewCubitState.authorized){
                  isCustomerAuthorized = true;
                }else{
                  isCustomerAuthorized = false;
                }
              }),
        ],
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.mainColor,
          ),
        ),
      ),
    );
  }

}
