import 'package:flutter/material.dart';

// -- all routes consts
import 'package:app/utilities/routing/routing_consts.dart';

// -- screens | all
import 'package:app/screens/intro/main_view.dart';
import 'package:app/screens/home/main_view.dart';
import 'package:app/screens/auth/login/main_view.dart';
import 'package:app/screens/auth/signup/main_view.dart';
import 'package:app/screens/auth/forgot_password/main_view.dart';
import 'package:app/screens/user_profile/main_view.dart';

Route<dynamic> generatedRoutes(RouteSettings settings) {
  switch(settings.name) {
    case introSliderScreenRoute:
      return MaterialPageRoute(builder: (context) => const IntroSliderScreen());
    case homepageScreenRoute:
      return MaterialPageRoute(builder: (context) => const HomepageScreen());
    case loginScreenRoute:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case signUpScreenRoute:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case forgotPasswordScreenRoute:
      return MaterialPageRoute(builder: (context) => const ForgotPasswordScreen());
    case userProfileScreenRoute:
      return MaterialPageRoute(builder: (context) => const UserProfileScreen());
    default:
      return MaterialPageRoute(builder: (context) => const IntroSliderScreen());
  }
}