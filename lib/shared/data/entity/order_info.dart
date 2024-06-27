
class OrderStatus{
  static String changed = 'CHANGED';
  static String done = 'DONE';
  static String cancel = 'CANCELED';
  static String reserved = 'RESERVED';
}

class OrderInfo {
  final int id;
  final int barberId;
  final String barberName;
  final String barberPhone;
  final int customerId;
  final String customerName;
  final String customerPhone;
  final String status;
  final DateTime time;
  final int grade;
  final int serviceId;
  final String serviceName;
  final int servicePrice;

  OrderInfo({
    required this.id,
    required this.barberId,
    required this.barberName,
    required this.barberPhone,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.status,
    required this.time,
    required this.grade,
    required this.serviceId,
    required this.serviceName,
    required this.servicePrice
  });

  factory OrderInfo.fromJson(Map<String, dynamic> json) {
    return OrderInfo(
        id: json['id'],
        barberId: json['barberId'],
        barberName: json['barberName'] ?? '',
        barberPhone: json['barberPhone'] ?? '',
        customerId: json['customerId'] ?? '',
        customerName: json['customerName'] ?? '',
        customerPhone: json['customerPhone'] ?? '',
        status: json['status'] ?? '',
        time: DateTime.parse(json['time'].toString()).toUtc(),
        grade: json['grade'] ?? 0,
        serviceId: json['serviceId'] ?? 0,
        serviceName: json['serviceName'] ?? '',
        servicePrice: json['servicePrice'] ?? 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'barberId': barberId,
      'barberName': barberName,
      'barberPhone': barberPhone,
      'customerId': customerId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'status': status,
      'time': time,
      'grade': grade,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'servicePrice': servicePrice
    };
  }

}
