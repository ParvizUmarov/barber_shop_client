
import 'dart:developer';

import 'package:barber_shop/screens/customer_screen_widget/home_page_widget/bloc/stores_bloc/stores_event.dart';
import 'package:barber_shop/screens/customer_screen_widget/home_page_widget/bloc/stores_bloc/stores_state.dart';
import 'package:barber_shop/shared/data/repository/stores_repository.dart';
import 'package:barber_shop/shared/services/database/database_service.dart';
import 'package:bloc/bloc.dart';

class StoresBloc extends Bloc<StoresEvent, StoresState>{
  StoresBloc() : super(StoresInitial()){
    on<GetAllStores>(_getAllStores);
  }

  final _storesRepo = StoresRepository();
  final _db = DB.instance;

   _getAllStores( event,  emit) async {
     emit(StoresProgress());
     final userInfo = await _db.getUserInfo();

     if(userInfo == null){
       var errorMessage = 'You must authorized';
       log(errorMessage);
       emit(StoresFailure(errorMessage: errorMessage));
     }else{
       final response = await _storesRepo.getAllStores(userInfo.mail, userInfo.token);

       if(response.errorMessage == null){
         log('get all stores');
         emit(StoresSuccess(stores: response.response));
       }else{
         log("error: ${response.errorMessage!}");
         emit(StoresFailure(errorMessage: response.errorMessage!));
       }
     }
  }
}