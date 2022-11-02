import 'package:flutter/material.dart';

// -- settings | global
import 'package:app/global/settings/global_settings.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

const TextStyle screenStylesAppBarTitle = TextStyle(
  color: Colors.black,
  fontSize: 19,
);

ButtonStyle screenStylesCancelTestButton = ElevatedButton.styleFrom(
  backgroundColor: Colors.redAccent,
  splashFactory: NoSplash.splashFactory,
  elevation: 0,
  textStyle: const TextStyle(
    fontSize: 15,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);

ButtonStyle screenStylesTestNavPrevButton = ElevatedButton.styleFrom(
  minimumSize: const Size(double.minPositive, globalSettingsDefaultButtonHeight),
  backgroundColor: Colors.grey,
  splashFactory: NoSplash.splashFactory,
  textStyle: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.black
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);
ButtonStyle screenStylesTestNavNextButton = ElevatedButton.styleFrom(
  minimumSize: const Size(double.minPositive, globalSettingsDefaultButtonHeight),
  backgroundColor: globalColorAppPrimary,
  splashFactory: NoSplash.splashFactory,
  textStyle: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);
