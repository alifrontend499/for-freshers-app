import 'package:flutter/material.dart';

// -- routing
import 'package:app/utilities/routing/routing.dart' as router;
import 'package:app/utilities/routing/routing_consts.dart';

void main() {

  // running the main app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'For Freshers',
      onGenerateRoute: router.generatedRoutes,
      initialRoute: introSliderScreenRoute,
    );
  }
}
