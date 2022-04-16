
import 'package:flutter/material.dart';
import 'package:nutriapp/pages/login/widgets/login.dart';
import 'package:nutriapp/pages/navegation/widgets/navigation.dart';
import 'package:nutriapp/pages/objetivos/widgets/objetivo.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.objetivos: (_) => const Objetivo(),
      Routes.login: (_) => const LoginPage(),
      Routes.navigation: (_) => const Navigation(),
    };

abstract class Routes {
  static const objetivos = '/objetivos';
  static const navigation= '/navigation';
  static const login = '/login';
}
