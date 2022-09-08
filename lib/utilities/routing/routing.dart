import 'package:flutter/material.dart';

// -- all routes consts
import 'package:app/utilities/routing/routing_consts.dart';

// -- screens | all
import 'package:app/screens/intro/main_view.dart';
import 'package:app/screens/home/main_view.dart';

Route<dynamic> generatedRoutes(RouteSettings settings) {
  switch(settings.name) {
    case introSliderScreenRoute:
      return MaterialPageRoute(builder: (context) => const IntroSliderScreen());

    case homepageScreenRoute:
      return MaterialPageRoute(builder: (context) => const HomepageScreen());

    default:
      return MaterialPageRoute(builder: (context) => const IntroSliderScreen());
  }
}