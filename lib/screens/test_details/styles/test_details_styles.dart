import 'package:flutter/material.dart';

// -- settings | global
import 'package:app/global/settings/global_settings.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

final ButtonStyle submitBtnStyles = ElevatedButton.styleFrom(
  minimumSize: const Size(
    double.infinity,
    globalSettingsDefaultButtonHeight,
  ),
  backgroundColor: globalColorAppPrimary,
  splashFactory: NoSplash.splashFactory,
  textStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.1
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);

const TextStyle stylesLinkText = TextStyle(
  fontWeight: FontWeight.w600,
  color: globalColorAppPrimary,
);

const TextStyle stylesTestHeading = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: globalColorAppPrimary,
);
const TextStyle stylesTestDescription = TextStyle(
  color: Colors.black,
  fontSize: 14.5,
);