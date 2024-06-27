
import 'dart:developer';

import 'package:barber_shop/shared/data/entity/chat.dart';
import 'package:barber_shop/shared/data/repository/barber_repository.dart';
import 'package:barber_shop/shared/data/repository/chat_repository.dart';
import 'package:barber_shop/shared/data/repository/customer_repository.dart';
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/bloc/chat_bloc/chat_event.dart';
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/bloc/chat_bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState>{
  ChatBloc() : super(ChatInitialState()){
    on<ChatGetAllEvent>(getAllChats);
    on<ChatGetByBarberID>(getChatByBarberID);

  }

  ChatRepository repository = ChatRepository();
  BarbersRepository barbersRepository = BarbersRepository();
  CustomersRepository customersRepository = CustomersRepository();


  getAllChats(event, emit) async {
    emit(ProgressChatState());

    final response = await repository.getAllChats();

    if(response.errorMessage != null){
      log('response error: ${response.errorMessage}');
      emit(FailureChatState());

    }else{
      log('response message: ${response.response}');
      final allChats = response.response;
      emit(SuccessChatState(allChats: allChats));

    }

  }

  getChatByBarberID(event, emit) async {
    emit(ProgressChatState());

    final response = await repository.getChatByBarberId(event.barberId);

    if(response.errorMessage != null){
      log('response error: ${response.errorMessage}');
      emit(FailureChatState());

    }else{
      log('response message: ${response.response}');
      final allChats = response.response;
      emit(SuccessChatState(allChats: allChats));

    }
  }


}