import 'dart:io';

import 'package:kptube_mobile/core/services/image_validation_service/image_vaidation_service.dart';
import 'package:kptube_mobile/features/registration/data/repositories/abstract_registration_repository.dart';
import 'package:kptube_mobile/features/registration/data/repositories/registration_api.dart';
import 'package:kptube_mobile/features/registration/data/repositories/registration_repository_local.dart';
import 'package:kptube_mobile/features/registration/models/user.dart';

class RegistrationRepositoryImpl implements AbstractRegistrationRepository {
  final RegistrationApi _registrationApi;
  final RegistrationLocalData _localData;

  RegistrationRepositoryImpl(this._registrationApi, this._localData);

  @override
  Future<User> registerUser({
    required String name,
    required String email,
    required String password,
    required File avatar,
    required File header,
    required String User_ID,
  }) async {
    try {
      if (!isValidSvgFile(avatar)) {
        throw RegistrationException(
          'Invalid avatar file format. Only SVG files are allowed.',
        );
      }

      if (!isValidSvgFile(header)) {
        throw RegistrationException(
          'Invalid header file format. Only SVG files are allowed.',
        );
      }

      final user = await _registrationApi.register(
        name: name,
        email: email,
        password: password,
        avatar: avatar,
        header: header,
        User_ID: User_ID,
      );

      await _localData.saveRegistrationData(name, password, User_ID);

      return user;
    } on RegistrationException {
      rethrow;
    } catch (e) {
      throw RegistrationException('Failed to register user: ${e.toString()}');
    }
  }
}

class RegistrationException implements Exception {
  final String message;

  RegistrationException(this.message);

  @override
  String toString() => message;
}
