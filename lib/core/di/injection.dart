import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kptube_mobile/features/registration/bloc/registration_bloc.dart';
import 'package:kptube_mobile/features/registration/data/repositories/abstract_registration_repository.dart';
import 'package:kptube_mobile/features/registration/data/repositories/registration_api.dart';
import 'package:kptube_mobile/features/registration/data/repositories/registration_repository_impl.dart';
import 'package:kptube_mobile/features/registration/data/repositories/registration_repository_local.dart';

final getIt = GetIt.I;

void setupDependencies() {
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerSingleton<RegistrationApi>(RegistrationApi(getIt<Dio>()));

  getIt.registerSingleton<RegistrationLocalData>(RegistrationLocalData());

  getIt.registerLazySingleton<AbstractRegistrationRepository>(
    () => RegistrationRepositoryImpl(
      getIt<RegistrationApi>(),
      getIt<RegistrationLocalData>(),
    ),
  );

  getIt.registerSingleton<RegistrationBloc>(
    RegistrationBloc(getIt<AbstractRegistrationRepository>()),
  );
}
