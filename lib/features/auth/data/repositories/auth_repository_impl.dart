import 'package:kptube_mobile/features/auth/data/repositories/abstract_auth_repository.dart';
import 'package:kptube_mobile/features/auth/data/repositories/auth_api.dart';
import 'package:kptube_mobile/features/auth/models/auth_user.dart';

import 'auth_repository_local.dart';



class AuthRepositoryImpl implements AbstractAuthRepository {
  final AuthUserApi _authApi;
  final AuthLocalData _authLocalData;

  AuthRepositoryImpl(this._authApi, this._authLocalData);

  @override
  Future<AuthUser> authUser({required String name,
    required String password}) async {
    try {
      final user = await _authApi.auth(name: name, password: password);
      final User_ID = await user.User_ID;
      _authLocalData.saveAuthData(name, password, User_ID!);
      return user;
    } catch (e) {
      throw AuthException('Failed to auth: ${e.toString()}');
    }
  }
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}