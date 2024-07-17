import 'dart:async';
import 'dart:developer';

import 'package:barber_shop/screens/customer_screen_widget/home_page_widget/view/booking_screen.dart';
import 'package:barber_shop/screens/customer_screen_widget/map_page_widget/bloc/salon/salon_event.dart';
import 'package:barber_shop/screens/customer_screen_widget/map_page_widget/bloc/salon/salon_state.dart';
import 'package:barber_shop/screens/customer_screen_widget/map_page_widget/bloc/salon/salons_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/map_page_widget/cubit/select_salon_cubit.dart';
import 'package:barber_shop/shared/data/entity/salon.dart';
import 'package:barber_shop/shared/data/repository/salon_repository.dart';
import 'package:barber_shop/shared/theme/colors/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:barber_shop/shared/locations/locations.dart' as locations;

class CustomerMapPage extends StatefulWidget {
  const CustomerMapPage({super.key});

  @override
  State<CustomerMapPage> createState() => _CustomerMapPageState();
}

class _CustomerMapPageState extends State<CustomerMapPage> {

  late GoogleMapController mapController;
  final LatLng _center = const LatLng(40.278954, 69.631679);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalonBloc, SalonState>(
      builder: (context, salonState) {
        if(salonState is SalonProgress){
          return Center(child: CircularProgressIndicator(),);
        }else if(salonState is SalonSuccess){
          final model = salonState.salons;

          Set<Marker> markers = {};

          for(var salon in model){
            double latitude = double.parse(salon.latitude);
            double longitude = double.parse(salon.longitude);
            markers.add(
                Marker(
                  markerId: MarkerId('${salon.id}'),
                  position: LatLng(latitude, longitude),
                  onTap: (){
                    context.read<SelectSalonCubit>().select(salon);
                  }
                ));
          }
          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomGesturesEnabled: true,
                tiltGesturesEnabled: true,
                rotateGesturesEnabled: true,
                buildingsEnabled: true,
                markers: markers,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 13,
                ),
              ),
              BlocBuilder<SelectSalonCubit, SelectSalonState>(
                builder: (context, selectSalonState) {
                  if(selectSalonState is SelectedSuccess){
                    return _SalonDetailsInfo(salon: selectSalonState.salon);
                  }else{
                    return Container();
                  }

                }
              )
            ],
          );
        }else{
         return Center(child: Text('Нету салонов'),);
        }

      }
    );
  }
}

class _SalonDetailsInfo extends StatelessWidget {
  final Salon salon;
  const _SalonDetailsInfo({super.key, required this.salon});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 10, right: 10, left: 10,
        child: Container(
          padding: EdgeInsets.all(10),
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(salon.images, width: 175)
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       Text('Адрес: \n${salon.address}',
                       maxLines: 2,
                       overflow: TextOverflow.ellipsis,),
                      RatingBarIndicator(
                        rating: 4,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                      ElevatedButton(
                          onPressed: (){
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) => BookingScreen(
                            //         barberInfo: barberInfo
                            //     ),
                            //   ),
                            // )
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainColor
                          ),
                          child: Text('Перейти', style: TextStyle(
                            color: Colors.white
                          ),),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
