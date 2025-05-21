part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class ProfileUserEvent extends ProfileEvent {
  final String name;

  ProfileUserEvent(this.name);
}

class LeaveProfileEvent extends ProfileEvent {}

class ProfileVideoTap extends ProfileEvent {
  final String Video_ID;

  ProfileVideoTap(this.Video_ID);
}

class ProfileNavigateBackEvent extends ProfileEvent {}
