part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileFailed extends ProfileState {
  final String error;
  ProfileFailed(this.error);
}

class ProfileGetSuccess extends ProfileState {
  final Profile profile;
  ProfileGetSuccess(this.profile);
}

class ProfileLeaveLoading extends ProfileState {}

class ProfileLeaveSuccess extends ProfileState {}

class ProfileLeaveFailed extends ProfileState {}

class ProfileVideosLoading extends ProfileState {}

class ProfileVideosSuccess extends ProfileState {
  final List<VideoPreview> videos;
  ProfileVideosSuccess(this.videos);
}

class ProfileVideosFailed extends ProfileState {
  final String error;
  ProfileVideosFailed(this.error);
}

class ProfileVideoTapState extends ProfileState {
  final String Video_ID;
  ProfileVideoTapState(this.Video_ID);
}

class ProfileNavigateBackState extends ProfileState {}

class ProfileNavigateToRegistration extends ProfileState {}

class ProfileNavigateToAuth extends ProfileState {}
