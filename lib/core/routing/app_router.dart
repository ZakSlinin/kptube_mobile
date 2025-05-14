import 'package:auto_route/auto_route.dart';
import 'package:kptube_mobile/features/auth/screens/auth_screen/auth_screen.dart';
import 'package:kptube_mobile/features/home/screens/home_screen/home_screen.dart';
import 'package:kptube_mobile/features/main/screens/main_screen/main_screen.dart';
import 'package:kptube_mobile/features/profile/screens/profile_screen/profile_screen.dart';
import 'package:kptube_mobile/features/registration/screens/registration_screen/registration_screen.dart';
import 'package:flutter/cupertino.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AuthRoute.page),
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: MainRoute.page),
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: RegistrationRoute.page),
  ];
}
