part of 'registration_bloc.dart';

class RegistrationEvent {}

class RegisterUserEvent extends RegistrationEvent {
  final String name;
  final String email;
  final String password;
  final File avatar;
  final File header;
  final String User_ID;

  RegisterUserEvent(
    this.name,
    this.email,
    this.password,
    this.avatar,
    this.header,
    this.User_ID,
  );
}
