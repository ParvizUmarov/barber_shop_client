class Customer {
  final int id;
  final String name;
  final String surname;
  final String birthday;
  final String password;
  final String phone;
  final String mail;
  final bool authState;

  Customer({
    required this.id,
    required this.name,
    required this.surname,
    required this.birthday,
    required this.password,
    required this.phone,
    required this.mail,
    required this.authState,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        id: json['id'],
        name: json['name'] ?? '',
        surname: json['surname'] ?? '',
        birthday: json['birthday'] ?? '',
        password: json['password'] ?? '',
        phone: json['phone'] ?? '',
        mail: json['mail'] ?? '',
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
      'authState': authState
    };
  }
}