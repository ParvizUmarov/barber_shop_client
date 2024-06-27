
class Users{
  final int uid;
  final String mail;
  final String token;
  final String type;

  Users({
    required this.uid,
    required this.mail,
    required this.token,
    required this.type
  } );

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        uid: json['uid'],
        mail: json['mail'],
        token: json['token'],
        type: json['type'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'mail': mail,
      'token': token,
    };
  }

  @override
  String toString() {
    return 'User{uid: $uid, mail: $mail, token: $token, type: $type}';
  }
}