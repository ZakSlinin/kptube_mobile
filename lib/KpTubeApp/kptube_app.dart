import 'package:flutter/material.dart';
import 'package:kptube_mobile/routes/routes.dart';
import 'package:kptube_mobile/theme/theme.dart';

class KptubeApp extends StatelessWidget {
  const KptubeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkTheme,
      routes: routes,
    );
  }
}
