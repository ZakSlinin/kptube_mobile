import 'package:kptube_mobile/core/resources/data_state.dart';
import 'package:kptube_mobile/features/add_content/data/models/video_model.dart';
import 'package:kptube_mobile/features/add_content/domain/repositories/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  @override
  Future<DataState<List<VideoModel>>> getVideo() {
    // TODO: implement getVideo
    throw UnimplementedError();
  }
}