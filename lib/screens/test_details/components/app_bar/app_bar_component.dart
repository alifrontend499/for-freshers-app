import 'package:flutter/material.dart';

// -- styles | screen
import 'package:app/screens/home/styles/home_styles.dart';

// -- settings | global
import 'package:app/global/settings/global_settings.dart';

PreferredSize getTestViewAppBar(BuildContext context, String testName) {
  PreferredSize appBar = PreferredSize(
    preferredSize: globalSettingsAppBarSize,
    child: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          size: globalSettingsAppBarLeadingSize,
        ),
        onPressed: () => Navigator.of(context).pop(),
        color: Colors.black,
        splashColor: Colors.transparent,
        splashRadius: globalSettingsAppBarLeadingSplashRadius,
      ),
      title: Text(
        testName,
        style: screenStylesAppBarTitle,
      ),
      titleSpacing: 0,
    ),
  );

  return appBar;
}
