import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:kptube_mobile/features/registration/data/repositories/abstract_registration_repository.dart';
import 'package:kptube_mobile/features/registration/data/repositories/registration_api.dart';
import 'package:kptube_mobile/features/registration/data/repositories/registration_repository_impl.dart';

final getIt = GetIt.I;

void setupDependencies() {
  getIt.registerSingleton<RegistrationApi>(
    RegistrationApi(getIt<Dio>()),
  );

  getIt.registerSingleton<AbstractRegistrationRepository>(
    RegistrationRepositoryImpl(getIt<RegistrationApi>()),
  );
}