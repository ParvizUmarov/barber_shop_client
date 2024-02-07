import 'package:barber_shop/ui/widgets/barber_screen_widget/main_screen/barber_main_screens/chat_page_widget/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/colors/Colors.dart';

class BarberChatPage extends StatefulWidget {
  const BarberChatPage({super.key});

  @override
  State<BarberChatPage> createState() => _BarberChatPageState();
}

class _BarberChatPageState extends State<BarberChatPage> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Customers').snapshots(),
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


          });
  }

  Widget _buildBarberListItem(DocumentSnapshot document)  {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    return ListTile(
      title: Text(data['email']),
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
    );


  }

}
