import 'package:flutter/material.dart';
import 'package:kptube_mobile/core/routing/app_router.dart';
import 'package:kptube_mobile/core/theme/theme.dart';

class KptubeMobile extends StatelessWidget {
  KptubeMobile({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KptubeMobile',
      theme: darkTheme,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
