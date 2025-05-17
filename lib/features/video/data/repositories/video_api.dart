import 'package:dio/dio.dart';
import 'package:kptube_mobile/core/constants/constants.dart';
import 'package:kptube_mobile/core/models/video/video.dart';

class VideoApi {
  final Dio _dio;

  VideoApi(this._dio);


  Future<List<VideoPreview>> getVideos(String Video_ID) async {
    try {
      final url = '$getVideoUrl=$Video_ID';
      print('Fetching videos from URL: $url');

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

      print('Videos response status code: ${response.statusCode}');
      print('Videos response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> videosData = response.data;
        print('Parsing ${videosData.length} videos');
        final videos = videosData
            .map((videoData) => VideoPreview.fromJson(videoData))
            .toList();
        print('Successfully parsed ${videos.length} videos');
        return videos;
      } else {
        print('Failed to fetch videos: ${response.statusCode}');
        print('Error response: ${response.data}');
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: response.data?['message'] ?? 'Failed to fetch videos',
        );
      }
    } catch (e) {
      print('Error fetching videos: $e');
      rethrow;
    }
  }
}