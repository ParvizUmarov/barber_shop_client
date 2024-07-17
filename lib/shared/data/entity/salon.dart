
class Salon{
  final int? id;
  final String address;
  final String images;
  final String longitude;
  final String latitude;

  Salon({
    this.id,
    required this.address,
    required this.images,
    required this.longitude,
    required this.latitude
  });

  factory Salon.fromJson(Map<String, dynamic> json) {
    return Salon(
      id: json['id'],
      address: json['address'],
      images: json['images'],
      longitude: json['longitude'],
      latitude: json['latitude']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'images': images,
      'longitude': longitude,
      'latitude': latitude
    };
  }

  @override
  String toString() {
    return 'Salon{id: $id, '
        'address: $address, '
        'images: $images, '
        'longitude: $longitude,'
        ' latitude: $latitude }';
  }
}