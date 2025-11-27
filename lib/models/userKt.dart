class UserCtr {
  final String userId;
  final String email;
  final String fullName;
  final String password;

  UserCtr({
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

  factory UserCtr.fromMap(Map<String, dynamic> map) {
    return UserCtr(
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
      fullName: map['fullName'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
