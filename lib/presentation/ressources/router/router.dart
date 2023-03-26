import 'package:campino/presentation/Authentication/Sign_in/sign_in.dart';
import 'package:campino/presentation/Authentication/Sign_up/signup.dart';
import 'package:campino/presentation/Splash_screen/splashscreen.dart';
import 'package:campino/presentation/client/views/client_home_view.dart';
import 'package:campino/presentation/on_boarding/on_boarding_page.dart';
import 'package:flutter/material.dart';

class AppRouting {
  static final String splashScreen = "/";
  static final String login = "/login";
  static final String register = "/register";
  static final String onboarding = "/onboarding";
  static final String homeClient = "/home_client";
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => SignupScreen());

      case '/onboarding':
        return MaterialPageRoute(builder: (_) => OnBoardingPage());
      case '/home_client':
        return MaterialPageRoute(builder: (_) => HomePageClient());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
