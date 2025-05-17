import 'package:kptube_mobile/core/models/video/video.dart';
import 'package:kptube_mobile/features/video/data/repositories/abstract_video_repository.dart';
import 'package:kptube_mobile/features/video/data/repositories/video_api.dart';

class VideoRepositoryImpl implements AbstractVideoRepository {
  final VideoApi _videoApi;

  VideoRepositoryImpl(this._videoApi);

  @override
  Future<List<VideoPreview>> getVideo({required String Video_ID}) async {
    try {
      return await _videoApi.getVideos(Video_ID);
    } catch (e) {
      throw VideoException(e.toString());
    }
  }
}

class VideoException implements Exception {
  final String message;

  VideoException(this.message);
}
