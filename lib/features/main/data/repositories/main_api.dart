import 'package:dio/dio.dart';
import 'package:kptube_mobile/core/constants/constants.dart';
import 'package:kptube_mobile/features/main/models/Video.dart';

class MainScreenApi {
  final Dio _dio;

  MainScreenApi(this._dio);

  Future<Video> getVideos() async {
    try {
      final response = await _dio.get('$getVideosUrl');
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
            message: 'No videos data found',
          );
        }

        return Video.fromJson(data);
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