import 'package:kptube_mobile/features/profile/data/repositories/abstract_profile_repository.dart';
import 'package:kptube_mobile/features/profile/data/repositories/profile_api.dart';
import 'package:kptube_mobile/features/profile/data/repositories/profile_repository_local.dart';
import 'package:kptube_mobile/features/profile/models/profile.dart';

class ProfileRepositoryImpl implements AbstractProfileRepository {
  final MyProfileApi _myProfileApi;
  final ProfileLocalData _profileLocalData;

  ProfileRepositoryImpl(this._myProfileApi, this._profileLocalData);

  @override
  Future<Profile> getMyProfile({
    required String? name,
    required String avatar,
    required String header,
    required List history,
    required String videos,
  }) async {
    try {
      final String? localName = await _profileLocalData.getMyProfileData();
      final myProfile = await _myProfileApi.getMyProfile(
        name: localName,
        avatar: avatar,
        header: header,
        history: history,
        videos: videos,
      );
      return myProfile;
    } catch (e) {
      throw ProfileException(e.toString());
    }
  }
}

class ProfileException implements Exception {
  final String message;

  ProfileException(this.message);
}
