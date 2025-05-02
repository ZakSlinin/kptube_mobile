import 'package:flutter/material.dart';
import 'package:kptube_mobile/core/theme/theme.dart';

class KptubeMobile extends StatelessWidget {
  const KptubeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KptubeMobile',
      theme: darkTheme,
      routes: {
      },
    );
  }
}