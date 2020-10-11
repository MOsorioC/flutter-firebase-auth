import 'package:flutter/material.dart';
import 'package:login_provider/core/constants/RoutePath.dart';
import 'package:login_provider/ui/views/HomeView.dart';
import 'package:login_provider/ui/views/LoginView.dart';
import 'package:login_provider/ui/views/PrivateView.dart';
import 'package:login_provider/ui/views/SignupView.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutePath.home:
      return MaterialPageRoute(builder: (_) => HomeView());
    case RoutePath.signUp:
      return MaterialPageRoute(builder: (_) => SignUpView());
    case RoutePath.signIn:
      return MaterialPageRoute(builder: (_) => SignInView());
    case RoutePath.privateHome:
      return MaterialPageRoute(builder: (_) => PrivateView());
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ));
  }
}
