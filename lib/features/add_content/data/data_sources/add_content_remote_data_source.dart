import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kptube_mobile/features/add_content/data/models/video_model.dart';

class AddContentRemoteDataSource {
  final Dio dio;

  AddContentRemoteDataSource(this.dio);

  Future<Response> uploadVideo({
    required File video,
    required File preview,
    required String name,
    required String description,
    required String owner,
    required dynamic category,
    required bool isGlobal,
  }) async {
    final formData = FormData.fromMap({
      'Video_ID': DateTime.now().millisecondsSinceEpoch.toString(),
      'video': await MultipartFile.fromFile(video.path, filename: 'video.mp4'),
      'preview': await MultipartFile.fromFile(
        preview.path,
        filename: 'preview.jpg',
      ),
      'name': name,
      'description': description,
      'owner': owner,
      'category': category.toString(),
      'isGlobal': isGlobal.toString(),
    });

    // final headers = {
    //   'X-USERNAME': username,
    //   'X-PASSWORD': password,
    //   'Content-Type': 'multipart/form-data',
    // }; доставать username и password из локального хранилища

    try {
      final response = await dio.post(
        'https://your-api-url.com/upload',
        data: formData,
        // options: Options(headers: headers), TODO: расскоментить при реализации headers
      );
      return response;
    } on DioException catch (e) {
      throw Exception('Upload failed: ${e.response?.data ?? e.message}');
    }
  }
}
