import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/core/di/injection.dart';
import 'package:kptube_mobile/features/registration/bloc/registration_bloc.dart';

import 'core/app/kptube_mobile_app.dart';

void main() {
  setupDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegistrationBloc()),
      ],
      child: KptubeMobile(),
    ),
  );
}
