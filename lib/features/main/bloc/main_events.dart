part of 'main_bloc.dart';

abstract class MainEvent {}

class GetMainEvent extends MainEvent {}

class VideoTap extends MainEvent {
  final String Video_ID;

  VideoTap({required this.Video_ID});
}

class NavigateToHomeEvent extends MainEvent {}
