import 'package:kptube_mobile/core/models/video/video.dart';

abstract class AbstractVideoRepository {
  Future<List<VideoPreview>> getVideo({required String Video_ID});
}
