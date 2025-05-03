import 'package:dio/dio.dart';
import 'package:kptube_mobile/core/constants/constants.dart';
import 'package:kptube_mobile/features/profile/data/repositories/profile_repository_local.dart';
import 'package:kptube_mobile/features/profile/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileApi {
  final Dio _dio;

  MyProfileApi(this._dio);

  Future<Profile> getMyProfile({
    required String? name,
    required String avatar,
    required String header,
    required List history,
    required String videos,
  }) async {
    try {
      if (name == null || name.isEmpty) {
        throw DioException(
          requestOptions: RequestOptions(path: getMyProfileUrl),
          message: 'Name is required',
        );
      }

      final url = '$getMyProfileUrl$name';
      print('Fetching profile from URL: $url');

      final response = await _dio.get(
        url,
        options: Options(
          validateStatus: (status) => status! < 500,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> users = response.data;
        if (users.isEmpty) {
          throw DioException(
            requestOptions: response.requestOptions,
            message: 'User not found',
          );
        }

        final userData = users.first;
        return Profile.fromJson(userData);
      } else {
        final errorMessage =
            response.data?['message'] ?? 'Get my profile failed';
        print('Error response: $errorMessage');
        print('Full response data: ${response.data}');

        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: errorMessage,
        );
      }
    } on DioException catch (e) {
      print('DioException details:');
      print('Error type: ${e.type}');
      print('Error message: ${e.message}');
      if (e.response != null) {
        print('Response status: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      }
      rethrow;
    } catch (e) {
      print('Unexpected error getting profile: $e');
      rethrow;
    }
  }
}
