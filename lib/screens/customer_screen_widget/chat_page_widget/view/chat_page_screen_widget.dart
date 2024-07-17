
import 'dart:developer';

import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/chat_page.dart';
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/widget/chat_page_widget.dart';
import 'package:barber_shop/screens/customer_screen_widget/chat_page_widget/bloc/customer_chat_bloc/customer_chat_bloc.dart';
import 'package:barber_shop/shared/data/entity/chat.dart';
import 'package:barber_shop/shared/firebase/firebase_collections.dart';
import 'package:barber_shop/shared/resources/resources.dart';
import 'package:barber_shop/shared/theme/colors/Colors.dart';
import 'package:barber_shop/shared/widgets/shimmer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

class ChatPageWidgetScreen extends StatefulWidget {
  const ChatPageWidgetScreen({super.key});

  @override
  State<ChatPageWidgetScreen> createState() => _ChatPageWidgetScreenState();
}

class _ChatPageWidgetScreenState extends State<ChatPageWidgetScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = 80;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _BuildSearchBar(),
            SizedBox(height: 10),
            BlocBuilder<CustomerChatBloc, CustomerChatState>(
              builder: (context, chatState) {
                if(chatState is CustomerChatProgress){
                  return Center(child: ShimmerWidget(typeBox: ShimmerTypeBox.listBox,),);
                }else if (chatState is CustomerChatSuccess){
                  final model = chatState.chats;
                  if(model.isEmpty){
                    return Center(child: Text('Нету чатов'),);
                  }else{
                    return Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.separated(
                              itemBuilder: (context, index){
                                final chat = model[index];
                                return InkWell(
                                    onTap: (){
                                      // context.pushNamed(Routes.barberMessageScreen,
                                      //     extra: chatState.allChats[index]);
                                    },
                                    child: _ChatTileWidget(chat: chat,));
                              },
                              separatorBuilder: (context, index){
                                return Container(
                                  height: 3,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                  ),
                                );
                              }, itemCount: model.length),
                        ),
                        Positioned(
                            right: 5,
                            bottom: 10,
                            child: InkWell(
                              onTap: (){

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
                  return Center(child: Text('Упс что та пошло не так!'));
                }

              }
            ),
          ],
        ),
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
            Text('Barber ID: ${chat.customerId}',
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

class _BuildSearchBar extends StatelessWidget {
  const _BuildSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    var searchTextEditingController = TextEditingController();
    return Container(
      margin: const EdgeInsets.all(10),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.person_search,
            size: 24,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              controller: searchTextEditingController,
              onChanged: (value) {},
              decoration: const InputDecoration.collapsed(
                hintText: 'Поиск',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
