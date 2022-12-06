import 'package:flutter/material.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

const TextStyle ndStylesTopBarHead = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w600,
);
const TextStyle ndStylesTopBarDesc = TextStyle(
  fontSize: 13,
);

TextStyle ndStylesLinkText({bool isActive = false}) => TextStyle(
      fontSize: 15,
      color: isActive ? Colors.white : Colors.black,
    );

// logout dialog
TextStyle logoutDialogTitleStyles = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
);
TextStyle logoutDialogContentStyles = const TextStyle(
  fontSize: 15,
);
final ButtonStyle logoutDialogBtnOk = ElevatedButton.styleFrom(
  splashFactory: NoSplash.splashFactory,
  minimumSize: const Size(80, 37),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
  elevation: 0,
  backgroundColor: globalColorAppPrimary,
  textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
);
final ButtonStyle logoutDialogBtnCancel = ElevatedButton.styleFrom(
  splashFactory: NoSplash.splashFactory,
  minimumSize: const Size(80, 37),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
  elevation: 0,
  backgroundColor: Colors.grey.withOpacity(.8),
  textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
);
