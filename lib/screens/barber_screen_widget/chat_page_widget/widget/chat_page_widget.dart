
import 'dart:developer';

import 'package:barber_shop/shared/data/entity/chat.dart';
import 'package:barber_shop/shared/firebase/firebase_collections.dart';
import 'package:barber_shop/shared/navigation/route_name.dart';
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/bloc/chat_bloc/chat_bloc.dart';
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/bloc/chat_bloc/chat_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import '../../../../../shared/resources/resources.dart';
import '../../../../shared/theme/colors/Colors.dart';
import '../bloc/chat_bloc/chat_state.dart';

class BarberChatPage extends StatefulWidget {
  const BarberChatPage({super.key});

  @override
  State<BarberChatPage> createState() => _BarberChatPageState();
}


class _BarberChatPageState extends State<BarberChatPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context).add(ChatGetByBarberID(barberId: 11));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = 80;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, chatState) {
          if(chatState is ProgressChatState){
            return Center(child: CircularProgressIndicator(),);
          }else if(chatState is SuccessChatState){
            if(chatState.allChats.isEmpty){
              return Center(child: Text('No chats'));
            }else{
              return Stack(
                children: [
                  ListView.separated(
                      itemBuilder: (context, index){
                        return InkWell(
                            onTap: (){
                              context.pushNamed(Routes.barberMessageScreen,
                                  extra: chatState.allChats[index]);
                            },
                            child: _ChatTileWidget(chat: chatState.allChats[index],));
                      },
                      separatorBuilder: (context, index){
                        return Container(
                          height: 3,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                        );
                      },
                      itemCount: chatState.allChats.length),
                  Positioned(
                      right: 5,
                      bottom: 10,
                      child: InkWell(
                        onTap: (){
                          log(Timestamp.now().seconds.toString());
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(40)
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: 30,),
                        ),
                      )
                  )
                ],
              );
            }
          }else{
            return Center(child: Text('No chats'));
          }
        }
      ),
    );
  }
}

class _ChatTileWidget extends StatelessWidget {
  final Chat chat;
  const _ChatTileWidget({
    super.key, required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          child: Image.asset('assets/images/user_avatar.png'),
        ),
        SizedBox(width: 20),
        Column(
          children: [
            Text('Customer ID: ${chat.customerId}',
            style: TextStyle(
               fontSize: 17,
               fontWeight: FontWeight.w600
            ),
            ),
            SizedBox(height: 3,),
            Text('Новое сообщение',
              maxLines: 2,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey
              ),),
          ],
        ),
        Spacer(),
        Column(
          children: [
          Text('5 min',
            style: TextStyle(
                fontSize: 15,
                color: Colors.grey
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.mainColor
            ),
            child: Center(child: Text('1', style: TextStyle(color: Colors.white),)),
          )
        ],
        )
      ],
    );
  }
}
