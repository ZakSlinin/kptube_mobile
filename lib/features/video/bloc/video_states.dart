part of 'video_bloc.dart';

class VideoState {}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {
  final String Video_ID;

  VideoLoading({required this.Video_ID});
}

class VideoFailed extends VideoState {
  final String error;

  VideoFailed(this.error);
}

class VideoSuccess extends VideoState {
  final String Video_ID;

  VideoSuccess({required this.Video_ID});

}
