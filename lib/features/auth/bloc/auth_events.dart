part of 'auth_bloc.dart';

class AuthEvent {}

class AuthUserEvent extends AuthEvent {
  final String name;
  final String password;
  final String User_ID;

  AuthUserEvent(this.name, this.password, this.User_ID);
}