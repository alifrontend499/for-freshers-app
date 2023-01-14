import 'package:app/screens/test_view/main_view.dart';
import 'package:app/utilities/helpers/file_operations.dart';
import 'package:app/utilities/routing/routing_consts.dart';
import 'package:flutter/material.dart';

// -- settings | global
import 'package:app/global/settings/global_settings.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

class StartingTestOverDialog extends StatelessWidget {
  final int testId;

  const StartingTestOverDialog({
    Key? key,
    required this.testId,
  }) : super(key: key);

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
            //   Icons.play_arrow,
            //   size: 20,
            //   color: Colors.black,
            // ),
            // SizedBox(width: 10),
            Text(
              'Starting Over',
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
          'You have already completed this test. Starting over will remove all the previous progress.',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 20),

        // child | button
        ElevatedButton(
          onPressed: () async {
            // deleting test from storage (completed test list)
            await deleteSingleCompletedTestHelper(testId);

            Navigator.pushNamed(context, testViewScreenRoute);
          },
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
          child: const Text('Start Over Now'),
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
                  'Cancel Now',
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
