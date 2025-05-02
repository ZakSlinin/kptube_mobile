import 'dart:io';

import 'package:kptube_mobile/features/registration/data/repositories/abstract_registration_repository.dart';
import 'package:kptube_mobile/features/registration/data/repositories/registration_api.dart';
import 'package:kptube_mobile/features/registration/models/user.dart';

class RegistrationRepositoryImpl implements AbstractRegistrationRepository {
  final RegistrationApi _registrationApi;

  RegistrationRepositoryImpl(this._registrationApi);

  @override
  Future<User> registerUser({
    required String name,
    required String email,
    required String password,
    required File avatar,
    required File header,
    required int User_ID,
  }) async {
    try {
      final user = await _registrationApi.register(
        name: name,
        email: email,
        password: password,
        avatar: avatar,
        header: header,
        User_ID: User_ID
      );
      return user;
    } catch (e) {
      throw RegistrationException('Failed to register: ${e.toString()}');
    }
  }
}

class RegistrationException implements Exception {
  final String message;

  RegistrationException(this.message);
}
