import 'dart:developer';

import 'package:barber_shop/shared/data/entity/message.dart';
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/bloc/chat_room_bloc/chat_room_bloc.dart';
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/bloc/chat_room_bloc/chat_room_event.dart';
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/bloc/chat_room_bloc/chat_room_state.dart';
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/cubit/send_message_cubit/sendMessageCubit.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/theme/colors/Colors.dart';
import '../../../../shared/helper/chat_bubbles.dart';

class BarberChatRoom extends StatefulWidget {
  final String receiverUserEmail;
  final String receivedUserId;
  final int chatID;

  const BarberChatRoom(
      {super.key,
      required this.receiverUserEmail,
      required this.receivedUserId, required this.chatID});

  @override
  State<BarberChatRoom> createState() => _BarberChatRoomState();
}

class _BarberChatRoomState extends State<BarberChatRoom> {

  @override
  void initState() {
     context.read<ChatRoomBloc>().add(GetMessageByChatId(chatID: widget.chatID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: _ChatBody(
        receivedUserId: widget.receivedUserId, chatId: widget.chatID,
      ),
    );
  }
}

class _ChatBody extends StatelessWidget {
  final int chatId;
  final String receivedUserId;

  const _ChatBody({super.key, required this.receivedUserId, required this.chatId});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final TextEditingController messageController = TextEditingController();

    return Column(
      children: [
        _MessageArea(
            receivedUserId: receivedUserId,
            firebaseAuth: firebaseAuth),
        _MessageBarWidget(
          messageController: messageController,
          receivedUserId: receivedUserId,
          chatId: chatId,
        ),
      ],
    );
  }
}

class _MessageArea extends StatelessWidget {
  final String receivedUserId;
  final FirebaseAuth firebaseAuth;

  const _MessageArea(
      {super.key,
      required this.receivedUserId,
      required this.firebaseAuth});

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Center(
      child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
        builder: (context, chatRoomState) {
          if(chatRoomState is ProgressChatRoomState){
            return Center(child: CircularProgressIndicator());
          }else if(chatRoomState is SuccessChatRoomState){
            if(chatRoomState.allMessage.isEmpty){
              return Text('Нет сообщение', style: TextStyle(color: Colors.grey),);
            }else{
              return ListView.separated(
                  itemBuilder: (context, index){
                    return Column(
                      children: [
                        // DateChip(
                        //   date: DateTime.parse(chatRoomState.allMessage[index].time),
                        //   color: Theme.of(context).colorScheme.primary,
                        // ),
                        BubbleNormal(
                          text: chatRoomState.allMessage[index].message,
                          seen: true,
                          tail: true,
                          isSender: true,
                          color: true ? AppColors.mainColor : Color(-2894849),
                          textStyle: TextStyle(
                              color: true ? Colors.white : Colors.black, fontSize: 16),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.symmetric(horizontal: 12),
                        //       child: Text(DateFormat('hh:mm').format(
                        //           DateTime.parse(chatRoomState.allMessage[index].time.toDate().toString())
                        //           ),
                        //     ),
                        //     )
                        //   ],
                        // )
                      ],
                    );
                  },
                  separatorBuilder: (context, index){
                    return SizedBox(height: 10);
                  },
                  itemCount: chatRoomState.allMessage.length);
            }
          }else{
            return Text('Нет сообщение', style: TextStyle(color: Colors.grey),);
          }
        }
      )),
    );
  }
}

class _MessageBarWidget extends StatelessWidget {
  const _MessageBarWidget({
    super.key,
    required this.messageController,
    required this.receivedUserId,
    required this.chatId,
  });

  final String receivedUserId;
  final TextEditingController messageController;
  final int chatId;

  @override
  Widget build(BuildContext context) {
    void sendMessage() {

    }

    return Container(
      color: Theme.of(context).colorScheme.secondary,
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: sendMessage,
            icon: Icon(
              color: AppColors.mainColor,
              Icons.add_box_outlined,
              size: 30,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 55,
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primary,
                  hintText: 'Сообщение',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
                obscureText: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              onPressed: () async {
                if (messageController.text.isNotEmpty) {
                  log('send message to chat: $chatId' );
                  context.read<SendMessageCubit>().sendMessage(Message(
                      chatId: chatId,
                      message: messageController.text,
                      time: Timestamp.now().seconds.toString()
                  ));
                  messageController.clear();
                  context.read<ChatRoomBloc>().add(GetMessageByChatId(chatID: chatId));

                }
              },
              icon: Icon(
                color: AppColors.mainColor,
                Icons.send,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildMessageItem extends StatelessWidget {
  final DocumentSnapshot document;

  const _BuildMessageItem({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    int dateTime = data['timestamp'].microsecondsSinceEpoch;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId'] == firebaseAuth.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            ChatBubbles(
                message: data['message'], alignment: alignment, dateTime: dateTime),
            // Text(time,
            //   style: TextStyle(color: Colors.grey),),
            //Text('$timestamp')
          ],
        ),
      ),
    );
  }
}
