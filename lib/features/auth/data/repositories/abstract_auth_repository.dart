import 'package:kptube_mobile/features/auth/models/auth_user.dart';

abstract class AbstractAuthRepository {
  Future<AuthUser> authUser({
    required String name,
    required String password,
  });
}