import 'package:flutter/material.dart';

// -- all routes consts
import 'package:app/utilities/routing/routing_consts.dart';

// -- consts | screen
import 'package:app/screens/intro/intro_consts.dart';

// -- styles | screen
import 'package:app/screens/intro/styles/intro_styles.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

// -- package | unicons
import 'package:unicons/unicons.dart';

// -- settings | global
import 'package:app/global/settings/global_settings.dart';

PreferredSize getIntroAppBar(pageContext) {
  PreferredSize appBar = PreferredSize(
    preferredSize: globalSettingsAppBarSize,
    child: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      // leading: IconButton(
      //   icon: const Icon(
      //     UniconsLine.angle_left,
      //     size: globalSettingsAppBarLeadingSize,
      //   ),
      //   onPressed: () {},
      //   color: Colors.black,
      //   splashColor: Colors.transparent,
      //   splashRadius: globalSettingsAppBarLeadingSplashRadius,
      // ),

      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: globalSettingsAppBarRightPadding),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: globalColorInkWellHighlight,
              borderRadius: BorderRadius.circular(5),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                child: Text(
                  screenConstsAppBarSkipIntroScreen,
                  style: screenStylesAppBarActionText,
                ),
              ),
              onTap: () => Navigator.pushNamedAndRemoveUntil(pageContext, homepageScreenRoute, (route) => false),
            ),
          ),
        ),
      ],
    ),
  );

  return appBar;
}