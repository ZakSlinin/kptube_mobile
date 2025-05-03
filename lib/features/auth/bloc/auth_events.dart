part of 'auth_bloc.dart';

class AuthEvent {}

class AuthUserEvent extends AuthEvent {
  final String name;
  final String password;

  AuthUserEvent(this.name, this.password);
}