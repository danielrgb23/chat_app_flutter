import 'package:chat_app/feature/initial/presentation/page/initital_scream.dart';
import 'package:chat_app/feature/login/presentation/page/login_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const LoginScreen());

      case 'initScream':
        return _materialRoute(InitialScream());

      case 'login':
        return _materialRoute(const LoginScreen());

      default:
        return _materialRoute(const LoginScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
