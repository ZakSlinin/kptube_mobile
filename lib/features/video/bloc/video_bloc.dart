import 'package:flutter_bloc/flutter_bloc.dart';

part 'video_events.dart';
part 'video_states.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial()) {
    on<GetVideoEvent>(_onGetVideo);
    print('VideoBloc initialized');
  }

  Future<void> _onGetVideo(
    GetVideoEvent event,
    Emitter<VideoState> emit,
  ) async {
    try {
      print('VideoBloc: Starting video loading for ID: ${event.Video_ID}');
      emit(VideoLoading(Video_ID: event.Video_ID));
      print('VideoBloc: Emitted VideoLoading state');

      // Здесь будет загрузка видео
      await Future.delayed(const Duration(seconds: 1)); // Имитация загрузки

      emit(VideoSuccess(Video_ID: event.Video_ID));
      print('VideoBloc: Emitted VideoSuccess state');
    } catch (e) {
      print('VideoBloc: Error occurred: $e');
      emit(VideoFailed(e.toString()));
    }
  }
}
