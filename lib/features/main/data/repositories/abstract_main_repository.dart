import 'package:kptube_mobile/features/main/models/Video.dart';

abstract class AbstractMainRepository {
  Future<List<Video>> getVideos();
}
