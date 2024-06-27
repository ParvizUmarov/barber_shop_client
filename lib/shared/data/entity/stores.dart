

import 'package:cloud_firestore/cloud_firestore.dart';

class Stores{
  final int id;
  final int barberId;
  final String image;
  final String time;

  Stores({
    required this.id,
    required this.barberId,
    required this.image,
    required this.time});

  factory Stores.fromJson(Map<String, dynamic> json) {
    return Stores(
      id: json['id'],
      barberId: json['barberId'] ?? '',
      image: json['image'] ?? '',
      time: json['time'] ?? '',

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'barberId': barberId,
      'image': image,
      'time' : time
    };
  }

}