import 'package:flutter/material.dart';

// -- all routes consts
import 'package:app/utilities/routing/routing.dart' as router;
import 'package:app/utilities/routing/routing_consts.dart';

// -- theme | global
import 'package:app/global/theme/globalThemeData.dart';

void main() {

  // running the main app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'For Freshers',
      onGenerateRoute: router.generatedRoutes,
      initialRoute: homepageScreenRoute,
      theme: getGlobalThemeData(context),
    );
  }
}
