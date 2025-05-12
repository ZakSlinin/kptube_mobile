import 'package:kptube_mobile/core/models/video/video.dart';
import 'package:kptube_mobile/features/main/data/repositories/abstract_main_repository.dart';
import 'package:kptube_mobile/features/main/data/repositories/main_api.dart';



class MainRepositoryImpl implements AbstractMainRepository {
  final MainScreenApi _mainScreenApi;

  MainRepositoryImpl(this._mainScreenApi);

  @override
  Future<List<VideoPreview>> getVideosMain() async {
    try {
      return await _mainScreenApi.getVideosMain();
    } catch (e) {
      throw MainException(e.toString());
    }
  }
}

class MainException implements Exception {
  final String message;

  MainException(this.message);

  @override
  String toString() => message;
}