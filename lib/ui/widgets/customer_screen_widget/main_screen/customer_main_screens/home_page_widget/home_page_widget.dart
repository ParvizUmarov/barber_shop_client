import 'package:barber_shop/domain/blocs/booking_bloc/booking_bloc.dart';
import 'package:barber_shop/ui/widgets/customer_screen_widget/main_screen/customer_main_screens/home_page_widget/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../../resources/resources.dart';
import '../../../../../theme/colors/Colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: ListView(
        children: [
          SizedBox(height: 10),
          _SearchFieldWidget(),
          SizedBox(height: 10),
          _OfferWidget(),
          SizedBox(height: 30),
          _HairstylePosting(),
          SizedBox(height: 20),
          _RecommendationsWidget(),
        ],
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
        _RecommendationContainer(
          masterName: 'Джаборако',
          locations: 'г.Худжанд, ул. Гагарина, 63',
          masterAvatarPath: Images.userAvatar,
          rating: 4,
          cost: 30,
          isOpened: true,
          barberSalonImagePath: Images.barbershopSalon,
          barberSchedule: '8:00-15:00',
        ),
        SizedBox(height: 10),
        _RecommendationContainer(
          masterName: 'Аббосако',
          locations: 'г.Худжанд, ул. Камоли Худжанди, 163',
          masterAvatarPath: Images.userAvatar,
          rating: 2,
          cost: 25,
          isOpened: false,
          barberSalonImagePath: Images.barbershopSalon,
          barberSchedule: '9:00-20:00',
        ),
        SizedBox(height: 10),
        _RecommendationContainer(
          masterName: 'Джамшедако',
          locations: 'г.Худжанд, пр. Исмоили Сомони, 38',
          masterAvatarPath: Images.userAvatar,
          rating: 5,
          cost: 40,
          isOpened: true,
          barberSalonImagePath: Images.barbershopSalon,
          barberSchedule: '8:00-14:00',
        )
      ],
    );
  }
}

class _RecommendationContainer extends StatelessWidget {
  final String barberSalonImagePath;
  final String masterName;
  final String locations;
  final String masterAvatarPath;
  final double rating;
  final int cost;
  final bool isOpened;
  final String barberSchedule;

  const _RecommendationContainer({
    super.key,
    required this.masterName,
    required this.locations,
    required this.masterAvatarPath,
    required this.rating,
    required this.cost,
    required this.isOpened,
    required this.barberSalonImagePath,
    required this.barberSchedule,
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
                        barberSalonImagePath: barberSalonImagePath),
                    _BarberStatusSalon(isOpened: isOpened),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _BarberDetailsInfoWIdget(
                          masterName: masterName,
                          locations: locations,
                          rating: rating),
                      _BarberBookingAndPriceWidget(
                          cost: cost,
                          masterName: masterName,
                          locations: locations,
                          rating: rating,
                          isOpened: isOpened,
                          barberSalonImagePath: barberSalonImagePath,
                          barberSchedule: barberSchedule)
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
    required this.cost,
    required this.masterName,
    required this.locations,
    required this.rating,
    required this.isOpened,
    required this.barberSalonImagePath,
    required this.barberSchedule,
  });

  final int cost;
  final String masterName;
  final String locations;
  final double rating;
  final bool isOpened;
  final String barberSalonImagePath;
  final String barberSchedule;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$cost c',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.mainColor),
          ),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BookingScreen(
                  barberName: masterName,
                  locations: locations,
                  rating: rating,
                  cost: cost,
                  isOpened: isOpened,
                  imagePath: barberSalonImagePath,
                  barberSchedule: barberSchedule,
                ).create(),
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
      child: Image.asset(
        barberSalonImagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _HairstylePosting extends StatelessWidget {
  const _HairstylePosting({
    super.key,
  });

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
          child: ListView.builder(
              itemCount: listOfImages.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 120,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(listOfImages[index],
                              fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: 45,
                          right: 35,
                          child: CircleAvatar(
                            radius: 25,
                            child: Image.asset(Images.userAvatar),
                          ),
                        ),
                        Positioned(
                            top: 100,
                            right: 40,
                            child: Text(
                              'Name',
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
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
                      onPressed: () {},
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
