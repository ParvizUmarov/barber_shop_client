
import 'package:barber_shop/ui/widgets/customer_screen_widget/main_screen/customer_main_screens/chat_page_widget/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../../colors/Colors.dart';
import '../../../../../../resources/resources.dart';



class ChatPageWidgetScreen extends StatefulWidget {
  const ChatPageWidgetScreen({super.key});

  @override
  State<ChatPageWidgetScreen> createState() => _ChatPageWidgetScreenState();
}

class _ChatPageWidgetScreenState extends State<ChatPageWidgetScreen> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Barbers').snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text('Error');
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            );
          }

            return ListView(
                children: snapshot.data!.docs
                    .map<Widget>((doc) => _buildBarberListItem(doc)).toList()
            );
        }
        );
  }

  Widget _buildBarberListItem(DocumentSnapshot document)  {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Slidable(
            endActionPane:  ActionPane(
                motion: const ScrollMotion(),
                children: [
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
                  child: Image.asset(Images.userAvatar)
              ),
              title: Text(data['name']+ ' ' + data['surname']),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatPage(
                            receiverUserEmail: data['email'],
                            receivedUserId: data['uid'])
                    )
                );
              },
            ),
          ),
        );
  }
}

