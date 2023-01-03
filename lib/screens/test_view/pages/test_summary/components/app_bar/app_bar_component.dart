import 'package:flutter/material.dart';

// -- consts | screen
import 'package:app/screens/test_view/test_view_consts.dart';

// -- styles | screen
import 'package:app/screens/test_view/styles/test_view_styles.dart';

// -- settings | global
import 'package:app/global/settings/global_settings.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -- screen | dialog
import 'package:app/screens/test_view/dialog/cancel_test_dialog.dart';

PreferredSize getTestSummaryAppBar(BuildContext context) {
  PreferredSize appBar = PreferredSize(
    preferredSize: globalSettingsAppBarSize,
    child: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
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
      title: const Padding(
        padding: EdgeInsets.only(left: 15),
        child: Text(
          'Test Summary',
          style: screenStylesAppBarTitle,
        ),
      ),
      titleSpacing: 0,
      centerTitle: true,
    ),
  );

  return appBar;
}
