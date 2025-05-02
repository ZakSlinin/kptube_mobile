import 'package:kptube_mobile/features/registration/models/user.dart';
import 'dart:io';

abstract class AbstractRegistrationRepository {
  Future<User> registrationUser({
    required String name,
    required String email,
    required String password,
    required File avatar,
    required File header,
    required int User_ID,
  });
}