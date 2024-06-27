class BarberInfo {
  final int id;
  final String name;
  final String surname;
  final String? birthday;
  final String? password;
  final String phone;
  final String mail;
  final int workExperience;
  final bool? authState;
  final int salonId;
  final String salonAddress;
  final String salonImages;
  final int serviceId;
  final String serviceName;
  final int servicePrice;
  final String token;

  BarberInfo({
    required this.id,
    required this.name,
    required this.surname,
    required this.birthday,
    required this.password,
    required this.phone,
    required this.mail,
    required this.workExperience,
    required this.authState,
    required this.salonId,
    required this.salonAddress,
    required this.salonImages,
    required this.serviceId,
    required this.serviceName,
    required this.servicePrice,
    required this.token
  });

  BarberInfo copyWith({
    final int? id,
    final String? name,
    final String? surname,
    final String? birthday,
    final String? password,
    final String? phone,
    final String? mail,
    final int? workExperience,
    final bool? authState,
    final int? salonId,
    final String? salonAddress,
    final String? salonImages,
    final int? serviceId,
    final String? serviceName,
    final int? servicePrice,
    final String? token
  }){
    return BarberInfo(
        id: id ?? this.id,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        birthday: birthday ?? this.birthday,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        mail: mail ?? this.mail,
        workExperience: workExperience ?? this.workExperience,
        authState: authState ?? this.authState,
        salonId: salonId ?? this.salonId,
        salonAddress: salonAddress ?? this.salonAddress,
        salonImages: salonImages ?? this.salonImages,
        serviceId: serviceId ?? this.serviceId,
        serviceName: serviceName ?? this.serviceName,
        servicePrice: servicePrice ?? this.servicePrice,
        token: token ?? this.token);
  }

  factory BarberInfo.fromJson(Map<String, dynamic> json) {
    return BarberInfo(
      id: json['id'],
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      birthday: json['birthday'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      mail: json['mail'] ?? '',
      workExperience: json['workExperience'] ?? 0,
      authState: json['authState'] ?? false,
      salonId: json['salonId'] ?? 0,
      salonAddress: json['salonAddress'] ?? '',
      salonImages: json['salonImages'] ?? '',
      serviceId: json['serviceId'] ?? 0,
      serviceName: json['serviceName'] ?? '',
      servicePrice: json['servicePrice'] ?? 0,
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'birthday': birthday,
      'password': password,
      'phone': phone,
      'mail': mail,
      'workExperience': workExperience,
      'authState': authState,
    };
  }
}