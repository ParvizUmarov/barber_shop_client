
class Chat {
  final int id;
  final int barberId;
  final int customerId;

  Chat({
    required this.id,
    required this.barberId,
    required this.customerId});

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      barberId: json['barberId'],
      customerId: json['customerId'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'barberId': barberId,
      'customerId': customerId
    };
  }

}