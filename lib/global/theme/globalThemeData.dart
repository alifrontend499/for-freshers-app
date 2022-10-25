import 'package:flutter/material.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

ThemeData getGlobalThemeData(BuildContext context) {
  return ThemeData(
    splashColor: Colors.transparent,
    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
    // highlightColor: Colors.red
  );
}
