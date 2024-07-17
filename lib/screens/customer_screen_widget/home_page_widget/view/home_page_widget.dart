
import 'dart:developer';

import 'package:barber_shop/screens/customer_screen_widget/home_page_widget/bloc/barber_info/barber_info_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/home_page_widget/bloc/barber_info/barber_info_event.dart';
import 'package:barber_shop/screens/customer_screen_widget/home_page_widget/bloc/barber_info/barber_info_state.dart';
import 'package:barber_shop/screens/customer_screen_widget/home_page_widget/bloc/stores_bloc/stores_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/home_page_widget/bloc/stores_bloc/stores_event.dart';
import 'package:barber_shop/screens/customer_screen_widget/home_page_widget/bloc/stores_bloc/stores_state.dart';
import 'package:barber_shop/screens/customer_screen_widget/home_page_widget/view/stores_page.dart';
import 'package:barber_shop/shared/data/entity/barber_info.dart';
import 'package:barber_shop/shared/data/entity/order_info.dart';
import 'package:barber_shop/shared/data/entity/stores.dart';
import 'package:barber_shop/shared/navigation/go_router_navigation.dart';
import 'package:barber_shop/shared/navigation/route_name.dart';
import 'package:barber_shop/shared/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/colors/Colors.dart';
import 'booking_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    context.read<BarberInfoBloc>().add(GetAllBarberInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              SizedBox(height: 10),
              _SearchFieldWidget(),
              SizedBox(height: 10),
              _OfferWidget(),
              SizedBox(height: 30),
              _makeHairStylePostingWidget(),
              SizedBox(height: 20),
              _RecommendationsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecommendationsWidget extends StatelessWidget {
  const _RecommendationsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Парикмахерские',
          style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.mainColor
                  : Colors.white,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        BlocBuilder<BarberInfoBloc, BarberInfoState>(
          builder: (context, state) {
            log('state: $state');
            if(state is BarberInfoProgress){
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,),
              );
            }else if(state is BarberInfoSuccess){
              final model = state.barbersInfo;
              return SingleChildScrollView(
                child: Container(
                  height: (MediaQuery.of(context).size.height/2.75) * model.length,
                  width: double.infinity,
                  child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        final info = model[index];
                         return _RecommendationContainer(
                           masterAvatarPath: Images.userAvatar,
                           rating: 4,
                           isOpened: true,
                           barberSchedule: '8:00-15:00',
                           barberInfo: info,
                         );
                      },
                      separatorBuilder: (context, index){
                        return SizedBox(height: 10,);
                      },
                      itemCount: model.length),
                ),
              );
            }else {
              return Container();
            }
          }
        ),
      ],
    );
  }
}

class _RecommendationContainer extends StatelessWidget {
  final String masterAvatarPath;
  final double rating;
  final bool isOpened;
  final String barberSchedule;
  final BarberInfo barberInfo;

  const _RecommendationContainer({
    super.key,
    required this.masterAvatarPath,
    required this.rating,
    required this.isOpened,
    required this.barberSchedule,
    required this.barberInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 270,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, blurRadius: 5, offset: Offset(0, 1))
            ],
            color: Theme.of(context).colorScheme.primary),
        child: Container(
          padding: EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Column(
              children: [
                Stack(
                  children: [
                    _BarberSalonImageWidget(
                        barberSalonImagePath: barberInfo.salonImages),
                    _BarberStatusSalon(isOpened: isOpened),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _BarberDetailsInfoWIdget(
                          masterName: barberInfo.name,
                          locations: barberInfo.salonAddress,
                          rating: rating
                      ),
                      _BarberBookingAndPriceWidget(
                          rating: rating,
                          isOpened: isOpened,
                          barberSchedule: barberSchedule,
                        barberInfo: barberInfo,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BarberBookingAndPriceWidget extends StatelessWidget {
  const _BarberBookingAndPriceWidget({
    super.key,
    required this.rating,
    required this.isOpened,
    required this.barberSchedule,
    required this.barberInfo,
  });

  final double rating;
  final bool isOpened;
  final String barberSchedule;
  final BarberInfo barberInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${barberInfo.servicePrice} c',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.mainColor),
          ),
          onPressed: () => {
            //context.push(Routes.customerBarberDetail, extra: barberInfo),
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BookingScreen(
                  barberInfo: barberInfo
                ),
              ),
            )
          },
          //router.pushNamed('bookingScreen')
          child: Text(
            'Записаться',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _BarberDetailsInfoWIdget extends StatelessWidget {
  const _BarberDetailsInfoWIdget({
    super.key,
    required this.masterName,
    required this.locations,
    required this.rating,
  });

  final String masterName;
  final String locations;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            masterName,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          Text(
            locations,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey),
          ),
          RatingBarIndicator(
            rating: rating,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
        ],
      ),
    );
  }
}

class _BarberStatusSalon extends StatelessWidget {
  const _BarberStatusSalon({
    super.key,
    required this.isOpened,
  });

  final bool isOpened;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isOpened == true ? Colors.green : Colors.red,
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Center(
            child: Text(
              isOpened == true ? 'Открыто' : 'Закрыто',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _BarberSalonImageWidget extends StatelessWidget {
  const _BarberSalonImageWidget({
    super.key,
    required this.barberSalonImagePath,
  });

  final String barberSalonImagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Image.network(
        barberSalonImagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}

Widget _makeHairStylePostingWidget(){
  return BlocProvider<StoresBloc>(
      create: (context) =>  StoresBloc(),
      child: _HairstylePosting(),);
}

class _HairstylePosting extends StatefulWidget {
  const _HairstylePosting({
    super.key,
  });

  @override
  State<_HairstylePosting> createState() => _HairstylePostingState();
}

class _HairstylePostingState extends State<_HairstylePosting> {

  @override
  void initState() {
    context.read<StoresBloc>().add(GetAllStores());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listOfImages = [
      Images.firstStores,
      Images.secondStores,
      Images.thirdStores
    ];
    return Column(
      children: [
        Text('Истории мастеров',
            style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.mainColor
                    : Colors.white,
                fontWeight: FontWeight.w500)),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 170,
          child: BlocBuilder<StoresBloc, StoresState>(
            builder: (context, state) {
              if(state is StoresProgress){
                return Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
              }else if(state is StoresSuccess){
                final model = state.stores;
                return ListView.builder(
                    itemCount: model.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            child: _StoresContainer(stores: model[index]),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      StoresPage(content: model[index])
                                )
                              );
                            },),
                      );
                    });
              }else {
                return Container();
              }
            }
          ),
        ),
      ],
    );
  }
}

class _StoresContainer extends StatelessWidget {
  final Stores stores;
  const _StoresContainer({
    super.key, required this.stores,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
                stores.image,
                fit: BoxFit.cover),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  colors: [
                  Color(-9285227).withOpacity(0.1),
                  Color(-9942382).withOpacity(0.5),
                  Color(-11453304).withOpacity(0.9),
                  ]
                ),
                borderRadius: BorderRadius.circular(20)),
          ),
          Positioned(
            top: 40,
            right: 27,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.mainColor
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: CircleAvatar(
                      radius: 25,
                      child: Image.asset(Images.userAvatar),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Positioned(
          //     top: 100,
          //     right: 40,
          //     child: Text(
          //       'Name',
          //       style: TextStyle(color: Colors.white),
          //     ))
        ],
      ),
    );
  }
}





class _OfferWidget extends StatelessWidget {
  const _OfferWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: AppColors.mainListColors),
          boxShadow: [
            BoxShadow(
                color: Colors.black45, blurRadius: 9, offset: Offset(0, 5))
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Бронируй стрижку \nрядом! ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      onPressed: () {
                        context.go(Routes.customerMapPage);
                      },
                      child: Text(
                        'Прямо сейчас',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: Image.asset(Images.hairdresser),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchFieldWidget extends StatelessWidget {
  const _SearchFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        child: TextField(
          cursorColor: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            filled: true,
            fillColor: Theme.of(context).colorScheme.primary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.mainColor
                      : Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey
                        : Colors.transparent)),
            hintText: 'Найди свой салон',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
