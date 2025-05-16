part of 'registration_bloc.dart';

class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationFailed extends RegistrationState {
  final String error;

  RegistrationFailed({required this.error});
}
