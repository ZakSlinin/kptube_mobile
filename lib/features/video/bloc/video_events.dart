part of 'video_bloc.dart';

class VideoEvent {}

class GetVideoEvent extends VideoEvent {
  final String Video_ID;

  GetVideoEvent({required this.Video_ID});
}
