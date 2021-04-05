import 'package:flutter_app/screens/not_found_screen/not_found_screen.dart';
import 'package:flutter_app/screens/authentication/auth_screen.dart';
import 'package:flutter_app/screens/landing/landing_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> routeAll(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute(builder: (context) {
        return AuthScreen();
      });
    } else if (settings.name == "/auth") {
      return MaterialPageRoute(builder: (context) {
        return AuthScreen();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        return NotFoundScreen();
      });
    }
  }
}
