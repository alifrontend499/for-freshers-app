import 'package:app/screens/home/components/dialogs/premium_test_dialog.dart';
import 'package:app/screens/test_details/main_view.dart';
import 'package:flutter/material.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

// -- colors | screen
import 'package:app/screens/home/styles/home_colors.dart';

// -- styles | screen
import 'package:app/screens/home/styles/home_styles.dart';

// -- package | unicons
import 'package:unicons/unicons.dart';

class TestCard extends StatelessWidget {
  final String testType;
  final String testName;
  final String testQuestions;
  final String testDescription;
  final bool isPremium;

  const TestCard({
    Key? key,
    required this.testType,
    required this.testName,
    required this.testQuestions,
    required this.testDescription,
    required this.isPremium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: globalColorInkWellHighlight,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: screenColorCardBg,
        ),
        child: Stack(
          children: [
            // -- child | content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // child | head
                Text(
                  testType,
                  style: screenStylesTestCardDifficulty,
                ),
                const SizedBox(height: 35),

                Text(
                  testName,
                  style: screenStylesTestCardHeading,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 7),

                if (testDescription != '') ...[
                  Text(
                    testDescription,
                    style: screenStylesTestCardDesc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 7),
                ],

                Text(
                  "$testQuestions Questions",
                  style: screenStylesTestCardQuestions,
                ),
              ],
            ),

            // -- child | premium icon
            if (isPremium) ...[
              const Positioned(
                right: 0,
                child: Icon(
                  UniconsSolid.lock,
                  size: 17,
                  color: globalColorAppPrimary,
                ),
              ),
            ]
          ],
        ),
      ),
      onTap: () {
        if (isPremium) {
          // showing dialog
          showDialog(
            context: context,
            builder: (context) => const PremiumTestDialog(),
          );
        } else {
          // moving to details screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TestDetailsScreen(testName: testName),
            ),
          );
        }
      },
    );
  }
}
