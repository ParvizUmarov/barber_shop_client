
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/chat_page.dart';
import 'package:barber_shop/shared/firebase/firebase_collections.dart';
import 'package:barber_shop/shared/resources/resources.dart';
import 'package:barber_shop/shared/theme/colors/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

    return Column(
      children: [
        _BuildSearchBar(),
        SizedBox(height: 10),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(FirebaseCollections.barbers)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                );
              }

              int? userCount = snapshot.data?.size;

              (userCount! > 1) ? height *= userCount : height;

              return SizedBox(
                width: width,
                height: height,
                child: ListView(
                    children: snapshot.data!.docs
                        .map<Widget>((doc) => _barberChatPage(doc))
                        .toList()),
              );
            }),
      ],
    );
  }

  Widget _barberChatPage(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _BarberListTile(data: data, context: context),
    );
  }
}

class _BarberListTile extends StatelessWidget {
  const _BarberListTile({
    super.key,
    required this.data,
    required this.context,
  });

  final Map<String, dynamic> data;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          label: 'Delete',
          backgroundColor: Colors.red,
          icon: Icons.delete,
          onPressed: (BuildContext context) {},
        ),
      ]),
      child: ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(Images.userAvatar)),
        title: Text(data['name'] + ' ' + data['surname']),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BarberChatRoom(
                        receiverUserEmail: data['email'],
                        receivedUserId: data['uid'], chatID: 100001,
                      )
                  // ChatPage(
                  // receiverUserEmail: data['email'],
                  // receivedUserId: data['uid'])
                  ));
        },
      ),
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
