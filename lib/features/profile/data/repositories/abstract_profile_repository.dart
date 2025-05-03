import 'package:kptube_mobile/features/profile/models/profile.dart';

abstract class AbstractProfileRepository {
  Future<Profile> getMyProfile({
    required String? name,
    required String avatar,
    required String header,
    required List history,
    required String videos,
  });
}
