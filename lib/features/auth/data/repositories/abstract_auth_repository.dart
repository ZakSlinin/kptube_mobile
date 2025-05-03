import 'package:kptube_mobile/features/auth/models/auth_user.dart';
import 'dart:io';

abstract class AbstractAuthRepository {
  Future<AuthUser> authUser({
    required String name,
    required String password,
    required String User_ID,
  });
}