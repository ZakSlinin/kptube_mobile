import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/core/di/injection.dart';
import 'package:kptube_mobile/features/auth/bloc/auth_bloc.dart';
import 'package:kptube_mobile/features/auth/data/repositories/abstract_auth_repository.dart';
import 'package:kptube_mobile/features/main/bloc/main_bloc.dart';
import 'package:kptube_mobile/features/main/data/repositories/abstract_main_repository.dart';
import 'package:kptube_mobile/features/registration/bloc/registration_bloc.dart';
import 'package:kptube_mobile/features/registration/data/repositories/abstract_registration_repository.dart';
import 'package:kptube_mobile/features/video/bloc/video_bloc.dart';

import 'core/app/kptube_mobile_app.dart';
import 'features/profile/bloc/profile_bloc.dart';

void main() {
  setupDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  RegistrationBloc(getIt<AbstractRegistrationRepository>()),
        ),
        BlocProvider(
          create:
              (context) =>
                  AuthBloc(authRepository: getIt<AbstractAuthRepository>()),
        ),
        BlocProvider(create: (context) => getIt<ProfileBloc>()),
        BlocProvider(
          create:
              (context) =>
                  MainBloc(mainRepository: getIt<AbstractMainRepository>()),
        ),
        BlocProvider(create: (context) => VideoBloc()),
      ],
      child: KptubeMobile(),
    ),
  );
}
