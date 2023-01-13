import 'package:flutter/material.dart';

// -- consts | screen
import 'package:app/screens/completed_tests/completed_tests_consts.dart';

// -- styles | screen
import 'package:app/screens/home/styles/home_styles.dart';

// -- package | unicons
import 'package:unicons/unicons.dart';

// -- settings | global
import 'package:app/global/settings/global_settings.dart';

PreferredSize getCompletedTestsAppBar(
    BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  PreferredSize appBar = PreferredSize(
    preferredSize: globalSettingsAppBarSize,
    child: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          UniconsLine.draggabledots,
          size: globalSettingsAppBarLeadingSize,
        ),
        onPressed: () => scaffoldKey.currentState?.openDrawer(),
        color: Colors.black,
        splashColor: Colors.transparent,
        splashRadius: globalSettingsAppBarLeadingSplashRadius,
      ),
      title: const Text(
        SCREEN_APP_BAR_HEADING,
        style: screenStylesAppBarTitle,
      ),
      titleSpacing: 0,
    ),
  );

  return appBar;
}
