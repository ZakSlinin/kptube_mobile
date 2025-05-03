import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kptube_mobile/features/registration/data/repositories/abstract_registration_repository.dart';
import 'package:kptube_mobile/features/registration/data/repositories/registration_api.dart';
import 'package:kptube_mobile/features/registration/data/repositories/registration_repository_local.dart';
import 'package:kptube_mobile/features/registration/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final user = await _registrationApi.register(
        name: name,
        email: email,
        password: password,
        avatar: avatar,
        header: header,
        User_ID: User_ID,
      );

      _localData.saveRegistrationData(name, password, User_ID);
      return user;
  }
}

class RegistrationException implements Exception {
  final String message;

  RegistrationException(this.message);
}
