class AuthUser {
  final String? name;
  final String? password;
  final String? User_ID;

  AuthUser({this.name, this.password, this.User_ID});

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      name: json['name'] as String,
      password: json['password'] as String,
      User_ID: json['User_ID'] as String,
    );
  }
}
