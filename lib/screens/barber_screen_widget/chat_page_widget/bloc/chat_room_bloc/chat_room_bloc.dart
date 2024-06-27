

import 'dart:developer';

import 'package:barber_shop/shared/data/repository/message_repository.dart';
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/bloc/chat_room_bloc/chat_room_event.dart';
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/bloc/chat_room_bloc/chat_room_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState>{
  ChatRoomBloc() : super(ChatRoomInitialState()){
    on<GetMessageByChatId>(getMessageByChatId);
  }

  MessageRepository repository = MessageRepository();

  getMessageByChatId(event, emit) async {
    emit(ProgressChatRoomState());

    final response = await repository.getMessageById(event.chatID);

    if(response.errorMessage != null){
      log('chat room response error: ${response.errorMessage}');
      emit(FailureChatRoomState());
    }else{
      log('message response message: ${response.response}');
      final allMessages = response.response;
      emit(SuccessChatRoomState(allMessage: allMessages));

    }
  }

}