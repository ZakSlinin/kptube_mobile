import 'package:dio/dio.dart';
import 'package:kptube_mobile/core/constants/constants.dart';
import 'package:kptube_mobile/core/models/video/video.dart';

import '../../../../core/di/injection.dart';

class MainApi {
  final Dio _dio;

  MainApi(this._dio);

  Future<List<VideoPreview>> getVideosMain() async {
    try {
      final url = '$getVideosUrl';
      print('MainApi: Fetching videos from URL: $url');

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

      print('MainApi: Response status code: ${response.statusCode}');
      print('MainApi: Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> videosData = response.data;
        print('MainApi: Parsing ${videosData.length} videos');

        if (videosData.isEmpty) {
          print('MainApi: No videos data received from server');
          return [];
        }

        final videos = videosData.map((videoData) {
          print('MainApi: Parsing video data: $videoData');
          return VideoPreview.fromJson(videoData);
        }).toList();

        print('MainApi: Successfully parsed ${videos.length} videos');
        if (videos.isNotEmpty) {
          print('MainApi: First video details:');
          print('- ID: ${videos.first.Video_ID}');
          print('- Name: ${videos.first.name}');
          print('- Preview URL: ${videos.first.preview}');
        }

        return videos;
      } else {
        print('MainApi: Failed to fetch videos: ${response.statusCode}');
        print('MainApi: Error response: ${response.data}');
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: response.data?['message'] ?? 'Failed to fetch videos',
        );
      }
    } catch (e, stackTrace) {
      print('MainApi: Error fetching videos');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
