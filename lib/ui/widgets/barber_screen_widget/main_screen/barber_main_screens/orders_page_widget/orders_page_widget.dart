import 'package:flutter/material.dart';

import '../../../../../../colors/Colors.dart';
import '../../../../../../resources/resources.dart';

class BarberOrdersPage extends StatelessWidget {

  const BarberOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 600,
        child: ListView(
          children: [
            Column(
              children: [
                _Orders(),
                SizedBox(height: 10,),_Orders(),
                SizedBox(height: 10,),_Orders(),
                SizedBox(height: 10,),_Orders(),
                SizedBox(height: 10,),
              ],
            )
          ],

        ),
      ),
    );
  }
}

class _Orders extends StatelessWidget {
  const _Orders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                '10:30',
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.mainListColors,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          radius: 30,
                          child: Image.asset(Images.userAvatar),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            _TextWidget(
                              title: 'Имя',
                              text: 'Парвиз',)
                            ,_TextWidget(
                              title: 'Забронирован',
                              text: '10:30',),
                            _TextWidget(
                              title: 'Услуги',
                              text: 'Стрижка',),
                            _TextWidget(
                              title: 'Стоимость услуг',
                              text: '30 смн',),
                            Row(
                              children: [
                                IconButton.filled(
                                    onPressed: (){},
                                    icon: Icon(Icons.phone,
                                    color: AppColors.mainColor),
                                ),
                                IconButton.filled(
                                    onPressed: (){},
                                    icon: Icon(Icons.chat_outlined,
                                          color: AppColors.mainColor,),
                                ),

                              ],
                            ),


                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TextWidget extends StatelessWidget {
  final String title;
  final String text;
  const _TextWidget({
    super.key,
    required this.text,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
        child: Row(
          children: [
            Text('$title: ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            Text(text,
              style: TextStyle(
                fontSize: 16,
                  color: Colors.white
              ),
            ),
          ],
        )
    );
  }
}

