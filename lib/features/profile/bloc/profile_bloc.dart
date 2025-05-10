import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/features/profile/data/repositories/abstract_profile_repository.dart';
import 'package:kptube_mobile/features/profile/models/profile.dart';
import 'package:kptube_mobile/features/profile/models/video.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_events.dart';
part 'profile_states.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AbstractProfileRepository profileRepository;

  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
    on<LeaveProfileEvent>(_onLeaveProfile);
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
    } catch (e) {
      emit(ProfileLeaveFailed());
    }
  }

  Future<List<ProfileVideo>> getVideos(String username) async {
    try {
      return await profileRepository.getVideos(username);
    } catch (e) {
      print('Failed to load videos: $e');
      rethrow;
    }
  }
}
