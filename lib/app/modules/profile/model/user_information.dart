class User {
  final String email;
  final String phoneNumber;
  final String name;
  final String password;
  final String uid;
  final int totalBetPoint;

  User({
    required this.totalBetPoint,
    required this.email,
    required this.phoneNumber,
    required this.name,
    required this.password,
    required this.uid,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      totalBetPoint: json['total_bet_point'] ?? 0,
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      name: json['name'] ?? '',
      password: json['password'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_bet_point': totalBetPoint,
      'email': email,
      'phoneNumber': phoneNumber,
      'name': name,
      'password': password,
      'uid': uid,
    };
  }
}
