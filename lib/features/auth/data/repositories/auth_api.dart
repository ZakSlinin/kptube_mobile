import 'package:dio/dio.dart';
import 'package:kptube_mobile/core/constants/constants.dart';
import 'package:kptube_mobile/features/auth/models/auth_user.dart';
import 'package:kptube_mobile/features/registration/models/user.dart';

class AuthUserApi {
  final Dio _dio;

  AuthUserApi(this._dio);

  Future<AuthUser> auth({
    required String name,
    required String password,
  }) async {
    try {
      final response = await _dio.get(
        '$authenticationUserUrl$name',
        options: Options(headers: {'X-USERNAME': name, 'X-PASSWORD': password}),
      );

      print('Auth response status: ${response.statusCode}');
      print('Auth response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          throw DioException(
            requestOptions: response.requestOptions,
            message: 'Empty response from server',
          );
        }

        final data = response.data is List
            ? response.data.first
            : response.data;

        if (data == null) {
          throw DioException(
            requestOptions: response.requestOptions,
            message: 'No user data found',
          );
        }

        return AuthUser.fromJson(data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: response.data?['message'] ?? 'Authentication failed',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Server error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
        throw DioException(
          requestOptions: e.requestOptions,
          response: e.response,
          message: e.response?.data?['message'] ?? 'Authentication failed',
        );
      } else {
        print('Connection error: ${e.message}');
        throw DioException(
          requestOptions: e.requestOptions,
          message: 'Connection error: ${e.message}',
        );
      }
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }
}
