
import 'dart:async';
import 'dart:developer';

import 'package:barber_shop/shared/data/entity/chat.dart';
import 'package:barber_shop/shared/data/repository/chat_repository.dart';
import 'package:barber_shop/shared/services/database/database_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'customer_chat_event.dart';
part 'customer_chat_state.dart';

class CustomerChatBloc extends Bloc<CustomerChatEvent, CustomerChatState>{
  CustomerChatBloc() : super(CustomerChatInitial()){
    on<GetAllChatByCustomer>(_getAllCustomersChat);
  }

  final _db = DB.instance;
  final chatRepo = ChatRepository();

   _getAllCustomersChat( event, emit) async {
     emit(CustomerChatProgress());
     final userInfo = await _db.getUserInfo();

     if(userInfo == null){
       emit(CustomerChatFailure(errorMessage: 'You must authorized'));
     }else{
       log('customer id: ${userInfo.uid}');
       final response = await chatRepo.getChatByCustomerId(userInfo.uid);

       if(response.errorMessage == null){
         emit(CustomerChatSuccess(chats: response.response));
       }else{
         emit(CustomerChatFailure(errorMessage: response.errorMessage));
       }


     }

  }
}