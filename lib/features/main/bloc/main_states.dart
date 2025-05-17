part of 'main_bloc.dart';

class MainState {}

class MainInitial extends MainState {}

class MainLoading extends MainState {}

class MainFailed extends MainState {}

class MainSuccess extends MainState {
  final List<VideoPreview> videos;
  MainSuccess(this.videos);
}

class MainVideoTap extends MainState {}
