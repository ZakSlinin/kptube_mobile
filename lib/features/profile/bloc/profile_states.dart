part of 'profile_bloc.dart';

class ProfileState {}

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