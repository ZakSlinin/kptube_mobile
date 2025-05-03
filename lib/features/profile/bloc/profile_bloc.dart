import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/features/profile/data/repositories/abstract_profile_repository.dart';
import 'package:kptube_mobile/features/profile/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_events.dart';
part 'profile_states.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AbstractProfileRepository profileRepository;

  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLoading());
      final prefs = await SharedPreferences.getInstance();
      final name = prefs.getString('name');

      if (name == null) {
        emit(ProfileFailed('User not authenticated'));
        return;
      }

      final profile = await profileRepository.getMyProfile(
        name: name,
        avatar: '', // These will be populated from the API response
        header: '',
        history: [],
        videos: '',
      );
      emit(ProfileGetSuccess(profile));
    } catch (e) {
      emit(ProfileFailed(e.toString()));
    }
  }
}
