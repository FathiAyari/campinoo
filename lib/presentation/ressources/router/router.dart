import 'package:campino/presentation/Authentication/Sign_in/sign_in.dart';
import 'package:campino/presentation/Authentication/Sign_up/signup.dart';
import 'package:campino/presentation/Splash_screen/splashscreen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final String splashScreen = "/";
  static final String login = "/login";
  static final String register = "/register";
}

class AppRouting {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => SignupScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
