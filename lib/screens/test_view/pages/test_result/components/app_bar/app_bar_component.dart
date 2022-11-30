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

PreferredSize getTestResultAppBar(BuildContext context) {
  PreferredSize appBar = PreferredSize(
    preferredSize: globalSettingsAppBarSize,
    child: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Padding(
        padding: EdgeInsets.only(left: 15),
        child: Text(
          'Test Result',
          style: screenStylesAppBarTitle,
        ),
      ),
      titleSpacing: 0,
      centerTitle: true,
    ),
  );

  return appBar;
}
