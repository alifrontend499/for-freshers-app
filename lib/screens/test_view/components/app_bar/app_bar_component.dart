import 'package:flutter/material.dart';

// -- consts | screen
import 'package:app/screens/test_view/test_view_consts.dart';

// -- styles | screen
import 'package:app/screens/test_view/styles/test_view_styles.dart';

// -- settings | global
import 'package:app/global/settings/global_settings.dart';

PreferredSize getTestViewAppBar(BuildContext context, String testName) {
  PreferredSize appBar = PreferredSize(
    preferredSize: globalSettingsAppBarSize,
    child: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          testName,
          style: screenStylesAppBarTitle,
        ),
      ),
      titleSpacing: 0,
      // centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {},
            style: screenStylesCancelTestButton,
            child: const Text(CANCEL_TEST),
          ),
        ),
      ],
    ),
  );

  return appBar;
}
