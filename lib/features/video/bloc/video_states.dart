part of 'video_bloc.dart';

abstract class VideoState {}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {
  final String Video_ID;

  VideoLoading({required this.Video_ID});
}

class VideoSuccess extends VideoState {
  final String Video_ID;
  final String videoUrl;
  final String previewUrl;

  VideoSuccess({
    required this.Video_ID,
    required this.videoUrl,
    required this.previewUrl,
  });
}

class VideoFailed extends VideoState {
  final String error;

  VideoFailed(this.error);
}
