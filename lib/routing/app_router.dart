import 'package:flutter/foundation.dart';
import 'package:flutter_app/screens/home/home_page.dart';
import 'package:flutter_app/screens/loading/loading_screen.dart';
import 'package:flutter_app/screens/not_found_screen/not_found_screen.dart';
import 'package:flutter_app/screens/authentication/auth_screen.dart';
import 'package:flutter_app/screens/landing/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/page_names.dart';
import 'package:flutter_app/views/test_database.dart';
import 'package:flutter_app/views/test_encrypt_private_key.dart';
import 'package:flutter_app/views/test_encryption.dart';

class AppRouter {
  static Route<dynamic> routeAll(RouteSettings settings) {
    if (settings.name == LANDING) {
      return MaterialPageRoute(builder: (context) {
        return LandingScreen();
      });
    } else if (settings.name == AUTH_PAGE) {
      return MaterialPageRoute(builder: (context) {
        return AuthScreen();
      });
    } else if (settings.name == HOME) {
      return MaterialPageRoute(builder: (context) {
        return HomePage();
      });
    } else if (settings.name == LOADING) {
      return MaterialPageRoute(builder: (context) {
        return LoadingScreen(load: settings.arguments as Map<String, AsyncCallback>);
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        return NotFoundScreen();
      });
    }
  }
}
