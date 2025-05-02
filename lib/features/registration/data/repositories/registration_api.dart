import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kptube_mobile/core/constants/constants.dart';
import 'package:kptube_mobile/features/registration/models/user.dart';

class RegistrationApi {
  final Dio _dio;

  RegistrationApi(this._dio);

  Future<User> register({
    required String name,
    required String email,
    required String password,
    required File avatar,
    required File header,
    required int User_ID,
  }) async {
    final formData = FormData.fromMap({
      'name': name,
      'email': email,
      'password': password,
      'avatar': await MultipartFile.fromFile(
        avatar.path,
        filename: avatar.path.split('/').last,
      ),
      'header': await MultipartFile.fromFile(
        header.path,
        filename: header.path.split('/').last,
      ),
      'User_ID': User_ID,
    });

    final response = await _dio.post(
      registrationUserUrl,
      data: formData,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
    return User.fromJson(response.data);
  }
}
