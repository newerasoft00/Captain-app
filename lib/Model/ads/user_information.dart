class User {
  final String email;
  final String phoneNumber;
  final String name;
  final String password;
  final String phone;
  final String uid;

  User({
    required this.email,
    required this.phoneNumber,
    required this.name,
    required this.password,
    required this.phone,
    required this.uid,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      phoneNumber: json['id'],
      name: json['name'],
      password: json['password'],
      phone: json['phone'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'id': phoneNumber,
      'name': name,
      'password': password,
      'phone': phone,
      'uid': uid,
    };
  }
}
