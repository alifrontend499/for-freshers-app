import 'package:flutter/material.dart';

// -- settings | global
import 'package:app/global/settings/global_settings.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

const TextStyle screenStylesAppBarActionText =  TextStyle(
  color: globalColorAppPrimary,
  // fontSize: 15,
  fontWeight: FontWeight.w600
);

ButtonStyle screenStylesBuyNowButton = ElevatedButton.styleFrom(
  minimumSize: const Size(double.infinity, globalSettingsDefaultButtonHeight),
  primary: globalColorAppPrimary,
  splashFactory: NoSplash.splashFactory,
  textStyle: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5)
  )
);
ButtonStyle screenStylesBuyNowButton2 = ElevatedButton.styleFrom(
    minimumSize: const Size(double.infinity, globalSettingsDefaultButtonHeight),
);

const TextStyle screenStylesPageHeading =  TextStyle(
  color: globalColorAppPrimary,
  fontSize: 22,
  fontWeight: FontWeight.w600,
  height: 1.4,
);

const TextStyle screenStylesPageDescription =  TextStyle(
  color: Colors.black54,
  fontSize: 15,
  height: 1.6,
);