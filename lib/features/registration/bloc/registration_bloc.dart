import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/core/di/injection.dart';
import 'package:kptube_mobile/features/registration/data/repositories/abstract_registration_repository.dart';

part 'registration_events.dart';
part 'registration_states.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final registrationRepository = getIt<AbstractRegistrationRepository>();

  RegistrationBloc([abstractRegistrationRepository])
    : super(RegistrationInitial()) {
    on<RegisterUserEvent>(_handleRegisterUser);
  }

  Future<void> _handleRegisterUser(
    RegisterUserEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());
    try {
      print('Sending registration data:');
      print('Name: ${event.name}');
      print('Email: ${event.email}');
      print('Password: ${event.password}');
      print('Avatar file: ${event.avatar.path}');
      print('Header file: ${event.header.path}');

      registrationRepository.registerUser(
        name: event.name,
        email: event.email,
        password: event.password,
        avatar: event.avatar,
        header: event.header,
        User_ID: event.User_ID,
      );
      emit(RegistrationSuccess());
    } catch (e) {
      print('Failed registration with error: ${e.toString()}');
      emit(RegistrationFailed(error: e.toString()));
    }
  }
}
