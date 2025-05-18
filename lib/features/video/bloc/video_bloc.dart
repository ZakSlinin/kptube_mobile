import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kptube_mobile/core/constants/constants.dart';

part 'video_events.dart';
part 'video_states.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial()) {
    on<GetVideoEvent>(_onGetVideo);
    print('VideoBloc initialized');
  }

  String fixUrl(String url) {
    print('Original URL: $url');
    if (url.isEmpty) {
      print('Empty URL, returning empty string');
      return url;
    }

    if (url.startsWith('http://127.0.0.1:8000/')) {
      final fixedUrl = url.replaceFirst(
        'http://127.0.0.1:8000/',
        'https://kptube.kringeproduction.ru/files/',
      );
      print('Fixed localhost URL: $fixedUrl');
      return fixedUrl;
    }

    if (url.startsWith('http://localhost:8000/')) {
      final fixedUrl = url.replaceFirst(
        'http://localhost:8000/',
        'https://kptube.kringeproduction.ru/files/',
      );
      print('Fixed localhost URL: $fixedUrl');
      return fixedUrl;
    }

    print('URL already correct: $url');
    return url;
  }

  Future<void> _onGetVideo(
    GetVideoEvent event,
    Emitter<VideoState> emit,
  ) async {
    try {
      print('VideoBloc: Starting video loading for ID: ${event.Video_ID}');
      emit(VideoLoading(Video_ID: event.Video_ID));

      final response = await http.get(
        Uri.parse('$getVideosUrl?Video_ID=${event.Video_ID}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final video = data[0];
          final videoUrl = fixUrl(video['video']);
          final previewUrl = fixUrl(video['preview']);

          print('VideoBloc: Received video data');
          print('- Video URL: $videoUrl');
          print('- Preview URL: $previewUrl');

          emit(
            VideoSuccess(
              Video_ID: event.Video_ID,
              videoUrl: videoUrl,
              previewUrl: previewUrl,
            ),
          );
        } else {
          throw Exception('No video data found');
        }
      } else {
        throw Exception('Failed to load video data: ${response.statusCode}');
      }
    } catch (e) {
      print('VideoBloc: Error occurred: $e');
      emit(VideoFailed(e.toString()));
    }
  }
}
