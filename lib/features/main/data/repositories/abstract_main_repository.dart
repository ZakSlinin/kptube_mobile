import 'package:kptube_mobile/core/models/video/video.dart';

abstract class AbstractMainRepository {
  Future<List<VideoPreview>> getVideosMain();
}
