import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/core/di/injection.dart';
import 'package:kptube_mobile/features/auth/bloc/auth_bloc.dart';
import 'package:kptube_mobile/features/auth/data/repositories/abstract_auth_repository.dart';
import 'package:kptube_mobile/features/profile/data/repositories/abstract_profile_repository.dart';
import 'package:kptube_mobile/features/registration/bloc/registration_bloc.dart';

import 'core/app/kptube_mobile_app.dart';
import 'features/profile/bloc/profile_bloc.dart';

void main() {
  setupDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegistrationBloc()),
        BlocProvider(
          create: (context) =>
              AuthBloc(authRepository: getIt<AbstractAuthRepository>()),
        ),
        BlocProvider(create: (context) => ProfileBloc(profileRepository: getIt<AbstractProfileRepository>())),
      ],
      child: KptubeMobile(),
    ),
  );
}
