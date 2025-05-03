part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class ProfileUserEvent extends ProfileEvent {
  final String name;

  ProfileUserEvent(this.name);
}
