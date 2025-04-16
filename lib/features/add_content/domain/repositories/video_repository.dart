import 'package:kptube_mobile/core/resources/data_state.dart';
import 'package:kptube_mobile/features/add_content/domain/entities/video.dart';

abstract class VideoRepository {
  Future<DataState<List<VideoEntity>>> getVideo();
}