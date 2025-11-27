class UserCitra {
  final String userId;
  final String email;
  final String fullName;
  final String password;

  UserCitra({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'fullName': fullName,
      'password': password,
    };
  }

  factory UserCitra.fromMap(Map<String, dynamic> map) {
    return UserCitra(
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
      fullName: map['fullName'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
