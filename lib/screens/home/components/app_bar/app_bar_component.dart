import 'package:flutter/material.dart';

// -- styles | screen
import 'package:app/screens/home/styles/home_styles.dart';

// -- package | unicons
import 'package:unicons/unicons.dart';

// -- settings | global
import 'package:app/global/settings/global_settings.dart';

// -- widget | global
import 'package:app/global/widget/navigation_drawer/navigation_drawer_widget.dart';

PreferredSize getHomeAppBar(context) {
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
        onPressed: () => globalScaffoldKey.currentState?.openDrawer(),
        color: Colors.black,
        splashColor: Colors.transparent,
        splashRadius: globalSettingsAppBarLeadingSplashRadius,
      ),
      title: const Text(
        'Ontario',
        style: screenStylesAppBarTitle,
      ),
      titleSpacing: 0,
    ),
  );

  return appBar;
}
