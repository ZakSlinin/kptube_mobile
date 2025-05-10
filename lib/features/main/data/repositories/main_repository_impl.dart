import 'package:kptube_mobile/features/main/data/repositories/abstract_main_repository.dart';
import 'package:kptube_mobile/features/main/data/repositories/main_api.dart';

import '../../models/Video.dart';


class MainRepositoryImpl implements AbstractMainRepository {
  final MainScreenApi _mainScreenApi;

  MainRepositoryImpl(this._mainScreenApi);

  @override
  Future<List<Video>> getVideos() async {
    try {
      final response = await _mainScreenApi.getVideos();

      if (response is! Iterable) {
        throw MainException('API response is not a list');
      }

      final List<Video> videos = [];
      for (final item in response) {
        if (item is Map<String, dynamic>) {
          videos.add(Video.fromJson(item));
        }
      }

      return videos;
    } catch (e) {
      throw MainException('Failed to fetch videos: ${e.toString()}');
    }
  }
}

class MainException implements Exception {
  final String message;

  MainException(this.message);

  @override
  String toString() => message;
}