import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kptube_mobile/features/auth/bloc/auth_bloc.dart';
import 'package:kptube_mobile/features/auth/data/repositories/abstract_auth_repository.dart';
import 'package:kptube_mobile/features/auth/data/repositories/auth_api.dart';
import 'package:kptube_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kptube_mobile/features/auth/data/repositories/auth_repository_local.dart';
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

  getIt.registerSingleton<AuthUserApi>(AuthUserApi(getIt<Dio>()));

  getIt.registerSingleton<AuthLocalData>(AuthLocalData());

  getIt.registerLazySingleton<AbstractAuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthUserApi>(), getIt<AuthLocalData>()),
  );

  getIt.registerSingleton<AuthBloc>(AuthBloc(getIt<AbstractAuthRepository>()));
}
