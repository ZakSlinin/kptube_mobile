import 'dart:io';

class User {
  final String? name;
  final String? password;
  final File? avatar;
  final File? header;
  final String? User_ID;

  User({this.name, this.password, this.avatar, this.header, this.User_ID});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      password: json['password'] as String,
      avatar: File(json['avatar'] as String),
      header: File(json['header'] as String),
      User_ID: json['User_ID'] as String,
    );
  }
}