import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/features/profile/data/repositories/abstract_profile_repository.dart';
import 'package:kptube_mobile/features/profile/models/profile.dart';
import 'package:kptube_mobile/core/models/video/video.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_events.dart';
part 'profile_states.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AbstractProfileRepository profileRepository;

  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
    on<LeaveProfileEvent>(_onLeaveProfile);
    on<ProfileVideoTap>(_onVideoTap);
    on<ProfileNavigateBackEvent>(_onNavigateBack);
    on<ProfileNavigateToRegistrationEvent>(_onNavigateToRegistration);
    on<ProfileNavigateToAuthEvent>(_onNavigateToAuth);
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      print('Starting profile loading...');
      emit(ProfileLoading());
      final prefs = await SharedPreferences.getInstance();
      final name = prefs.getString('name');

      print('Retrieved name from SharedPreferences: $name');

      if (name == null) {
        print('No name found in SharedPreferences, user not authenticated');
        emit(ProfileFailed('User not authenticated'));
        return;
      }

      print('Loading profile for user: $name');
      final profile = await profileRepository.getMyProfile(
        name: name,
        avatar: '',
        header: '',
        history: [],
        videos: '',
      );

      print('Profile loaded successfully: ${profile.name}');
      print('Profile details:');
      print('- Avatar: ${profile.avatar}');
      print('- Header: ${profile.header}');
      print('- Videos count: ${profile.videoIds.length}');
      print('- Subscribers: ${profile.subscribers}');

      emit(ProfileGetSuccess(profile));
    } catch (e) {
      print('Failed to load profile: $e');
      emit(ProfileFailed(e.toString()));
    }
  }

  Future<void> _onLeaveProfile(
    LeaveProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLeaveLoading());

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      emit(ProfileLeaveSuccess());
      emit(ProfileNavigateToRegistration());
    } catch (e) {
      emit(ProfileLeaveFailed());
    }
  }

  Future<List<VideoPreview>> getVideos(String username) async {
    try {
      return await profileRepository.getVideos(username);
    } catch (e) {
      print('Failed to load videos: $e');
      rethrow;
    }
  }

  Future<void> _onVideoTap(
    ProfileVideoTap event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      print('ProfileBloc: video tapped with ID: ${event.Video_ID}');
      emit(ProfileVideoTapState(event.Video_ID));
      print('ProfileBloc: emitted ProfileVideoTapState');
    } catch (e) {
      print('Error: $e');
    }
  }

  void _onNavigateBack(
    ProfileNavigateBackEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(ProfileNavigateBackState());
  }

  void _onNavigateToRegistration(
    ProfileNavigateToRegistrationEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(ProfileNavigateToRegistration());
  }

  void _onNavigateToAuth(
    ProfileNavigateToAuthEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(ProfileNavigateToAuth());
  }
}
