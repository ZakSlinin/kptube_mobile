class AuthUser {
  final String? name;
  final String? password;
  final String? User_ID;

  AuthUser({this.name, this.password, this.User_ID});

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      name: json['name']?.toString(),
      password: json['password']?.toString(),
      User_ID: json['User_ID']?.toString(),
    );
  }

  static List<AuthUser> fromJsonList(List<dynamic> list) {
    return list
        .map((item) => AuthUser.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
