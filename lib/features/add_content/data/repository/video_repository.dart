import 'package:kptube_mobile/core/resources/data_state.dart';
import 'package:kptube_mobile/features/add_content/data/models/video.dart';
import 'package:kptube_mobile/features/add_content/domain/repository/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  @override
  Future<DataState<List<VideoModel>>> getVideo() {
    // TODO: implement getVideo
    throw UnimplementedError();
  }
}