import 'package:flutter/material.dart';
import 'package:kptube_mobile/core/di/injection.dart';

import 'core/app/kptube_mobile_app.dart';

void main() {
  setupDependencies();
  runApp(KptubeMobile());
}
