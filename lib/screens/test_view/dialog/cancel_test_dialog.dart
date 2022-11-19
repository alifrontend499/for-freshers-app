import 'package:flutter/material.dart';

// -- settings | global
import 'package:app/global/settings/global_settings.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

// -- screen | consts
import 'package:app/screens/test_view/test_view_consts.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CancelTestDialog extends StatelessWidget {
  final WidgetRef parentRef;

  const CancelTestDialog({Key? key, required this.parentRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(20),
      children: [
        // child | heading
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            // Icon(
            //   Icons.lock,
            //   size: 20,
            //   color: Colors.black,
            // ),
            // SizedBox(width: 10),
            Text(
              HEADING_CANCEL_TEST,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // child | description
        const Text(
          DESCRIPTION_CANCEL_TEST,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 20),

        // child | button
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            minimumSize: const Size(
              double.infinity,
              globalSettingsDefaultButtonHeight,
            ),
            backgroundColor: globalColorAppPrimary,
            splashFactory: NoSplash.splashFactory,
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(ACTION_CONFIRM_CANCEL_TEST),
        ),

        const SizedBox(height: 15),

        Column(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              highlightColor: globalColorInkWellHighlight,
              borderRadius: BorderRadius.circular(5),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: Text(
                  ACTION_CONTINUE_CANCEL_TEST,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: globalColorAppPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
