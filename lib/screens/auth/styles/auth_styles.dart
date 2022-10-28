import 'package:flutter/material.dart';

// -- settings | global
import 'package:app/global/settings/global_settings.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

const TextStyle authStylesPageHeading = TextStyle(
  fontSize: 27,
  fontWeight: FontWeight.w600,
  color: globalColorAppPrimary,
);

const TextStyle authStylesPageDescription = TextStyle(
  fontSize: 17,
  color: Colors.black54,
);
const TextStyle authStylesLinkText = TextStyle(
  fontWeight: FontWeight.w600,
  color: globalColorAppPrimary,
);

ButtonStyle authStylesPageButton(bool isLoading) => ElevatedButton.styleFrom(
  minimumSize: const Size(
    double.infinity,
    globalSettingsDefaultButtonHeight,
  ),
  backgroundColor: isLoading ? globalColorAppPrimary.withOpacity(0.5) : globalColorAppPrimary,
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

final OutlineInputBorder authStylesInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: const BorderSide(
    color: globalColorAppPrimary,
    width: 2,
  ),
);
final OutlineInputBorder authStylesInputBorderFocused = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: const BorderSide(
    color: globalColorAppPrimary,
    width: 2,
  ),
);
const TextStyle authStylesInput = TextStyle(
  fontSize: 14.5,
  height: 1.6,
);
