import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kptube_mobile/features/auth/bloc/auth_bloc.dart';
import 'package:kptube_mobile/features/auth/data/repositories/abstract_auth_repository.dart';
import 'package:kptube_mobile/features/auth/data/repositories/auth_api.dart';
import 'package:kptube_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kptube_mobile/features/auth/data/repositories/auth_repository_local.dart';
import 'package:kptube_mobile/features/main/data/repositories/abstract_main_repository.dart';
import 'package:kptube_mobile/features/main/data/repositories/main_api.dart';
import 'package:kptube_mobile/features/main/data/repositories/main_repository_impl.dart';
import 'package:kptube_mobile/features/profile/bloc/profile_bloc.dart';
import 'package:kptube_mobile/features/profile/data/repositories/abstract_profile_repository.dart';
import 'package:kptube_mobile/features/profile/data/repositories/profile_api.dart';
import 'package:kptube_mobile/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:kptube_mobile/features/profile/data/repositories/profile_repository_local.dart';
import 'package:kptube_mobile/features/registration/bloc/registration_bloc.dart';
import 'package:kptube_mobile/features/registration/data/repositories/abstract_registration_repository.dart';
import 'package:kptube_mobile/features/registration/data/repositories/registration_api.dart';
import 'package:kptube_mobile/features/registration/data/repositories/registration_repository_impl.dart';
import 'package:kptube_mobile/features/registration/data/repositories/registration_repository_local.dart';
import 'package:kptube_mobile/features/video/bloc/video_bloc.dart';
import 'package:kptube_mobile/features/video/data/repositories/abstract_video_repository.dart';
import 'package:kptube_mobile/features/video/data/repositories/video_api.dart';
import 'package:kptube_mobile/features/video/data/repositories/video_repository_impl.dart';

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

  getIt.registerSingleton<AuthBloc>(
    AuthBloc(authRepository: getIt<AbstractAuthRepository>()),
  );

  getIt.registerSingleton<MyProfileApi>(MyProfileApi(getIt<Dio>()));

  getIt.registerSingleton<ProfileLocalData>(ProfileLocalData());

  getIt.registerLazySingleton<AbstractProfileRepository>(
    () =>
        ProfileRepositoryImpl(getIt<MyProfileApi>(), getIt<ProfileLocalData>()),
  );

  getIt.registerSingleton<ProfileBloc>(
    ProfileBloc(profileRepository: getIt<AbstractProfileRepository>()),
  );

  getIt.registerSingleton<MainApi>(MainApi(getIt<Dio>()));

  getIt.registerLazySingleton<AbstractMainRepository>(
    () => MainRepositoryImpl(getIt<MainApi>()),
  );

  getIt.registerSingleton<VideoApi>(VideoApi(getIt<Dio>()));

  getIt.registerLazySingleton<AbstractVideoRepository>(
    () => VideoRepositoryImpl(getIt<VideoApi>()),
  );

  getIt.registerSingleton<VideoBloc>(VideoBloc());
}
