import 'package:flutter/material.dart';

// global | widget
import 'package:app/global/dialogs/global_premium_test_dialog/premium_test_dialog.dart';
// global | model
import 'package:app/global/models/test_model.dart';

// -- state | global
import 'package:app/global/state/global_state.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

// -- styles | screen
import 'package:app/screens/home/styles/home_styles.dart';

// screens
import 'package:app/screens/test_details/main_view.dart';

// -- package | unicons
import 'package:unicons/unicons.dart';

// -- package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// helpers
import 'package:app/utilities/helpers/helpers.dart';

class TestCard extends ConsumerWidget {
  final TestModel testDetails;
  bool showDescription;

  TestCard({
    Key? key,
    required this.testDetails,
    this.showDescription = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: globalColorInkWellHighlight,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Colors.white,
          image: DecorationImage(
            // image: NetworkImage(testImg),
              image: const NetworkImage(
                  'https://cdn.pixabay.com/photo/2014/06/03/19/38/board-361516__340.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.2), BlendMode.modulate)
            // opacity: .6,
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.1),
          //     blurRadius: 5.0,
          //     offset: const Offset(4, 4),
          //   ),
          // ],
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Stack(
          children: [
            // -- child | content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // child | head
                Text(
                  getCapitalizeTextHelper(testDetails.testType),
                  style: screenStylesTestCardDifficulty,
                ),
                const SizedBox(height: 35),

                Text(
                  testDetails.testName,
                  style: screenStylesTestCardHeading,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 7),

                if (showDescription) ...[
                  Text(
                    testDetails.testDescription,
                    style: screenStylesTestCardDesc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 7),
                ],

                Text(
                  "${testDetails.testQuestions} Questions",
                  style: screenStylesTestCardQuestions,
                ),
              ],
            ),

            // -- child | premium icon
            if (testDetails.isPremium) ...[
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
        if (testDetails.isPremium) {
          // showing dialog
          showDialog(
            context: context,
            builder: (context) => const GlobalPremiumTestDialog(),
          );
        } else {
          // setting global state
          ref.watch(ongoingTestProvider.notifier).state = testDetails;

          // moving to details screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TestDetailsScreen()),
          );
        }
      },
    );
  }
}
