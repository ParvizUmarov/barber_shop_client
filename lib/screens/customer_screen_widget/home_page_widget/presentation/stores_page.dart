
import 'dart:developer';

import 'package:barber_shop/shared/data/entity/stores.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linear_timer/linear_timer.dart';

class StoresPage extends StatefulWidget {
  final Stores content;
  const StoresPage({super.key, required this.content});

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              LinearTimer(
                  color: Colors.white,
                  backgroundColor: Colors.grey,
                  minHeight: 3,
                  duration: const Duration(seconds: 5),
                  onTimerEnd: (){
                    context.pop();
                  },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Image.asset("assets/images/user_avatar.png"),
                    ),
                    SizedBox(width: 10,),
                    Text('barber_${widget.content.barberId}'),
                    SizedBox(width: 7,),
                    Text(getTime(widget.content.time), style: TextStyle(color: Colors.grey),),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: Image.network(widget.content.image,
              fit: BoxFit.contain,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,),
          ),
        ],
      ),
    );
  }

  String getTime(String time){
    var formattedTime = '';
    final date = DateTime.parse(time);
    final now = DateTime.now();
    final newTime = now.difference(date);

    if(newTime.inHours < 1){
      formattedTime =  '${newTime.inMinutes} мин.';
    }else{
      formattedTime =  '${newTime.inHours} ч.';
    }
    return formattedTime;
  }

}
