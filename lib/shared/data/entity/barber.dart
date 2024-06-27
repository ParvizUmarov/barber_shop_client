class Barber {
  final int id;
  final String? name;
  final String? surname;
  final String? birthday;
  final String? password;
  final String? phone;
  final String? mail;
  final int? workExperience;
  final bool authState;

  Barber({
    required this.id,
    required this.name,
    required this.surname,
    required this.birthday,
    required this.password,
    required this.phone,
    required this.mail,
    required this.workExperience,
    required this.authState
  });

  Barber copyWith({
    final int? id,
    final String? name,
    final String? surname,
    final String? birthday,
    final String? password,
    final String? phone,
    final String? mail,
    final int? workExperience,
    final bool? authState,
  }){
    return Barber(
        id: id ?? this.id,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        birthday: birthday ?? this.birthday,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        mail: mail ?? this.mail,
        workExperience: workExperience ?? this.workExperience,
        authState: authState ?? this.authState
    );
  }

  factory Barber.fromJson(Map<String, dynamic> json) {
    return Barber(
        id: json['id'],
        name: json['name'] ?? '',
        surname: json['surname'] ?? '',
        birthday: json['birthday'] ?? '',
        password: json['password'] ?? '',
        phone: json['phone'] ?? '',
        mail: json['mail'] ?? '',
        workExperience: json['workExperience'] ?? 0,
        authState: json['authState'] ?? false
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
      'authState': authState
    };
  }
}