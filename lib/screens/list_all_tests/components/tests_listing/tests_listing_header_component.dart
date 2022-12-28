import 'package:flutter/material.dart';

// helpers
import 'package:app/utilities/helpers/helpers.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

// -- styles | screen
import 'package:app/screens/home/styles/home_styles.dart';

// -- consts | screen
import 'package:app/screens/home/home_consts.dart';

// -- models | global
import 'package:app/global/models/test_model.dart';

// -- all routes consts
import 'package:app/utilities/routing/routing_consts.dart';

// -- screen
import 'package:app/screens/all_tests/main_view.dart';

// -- package | page transition
import 'package:page_transition/page_transition.dart';

class TestListingHeader extends StatelessWidget {
  final int testsCount;
  final String testType;
  final List<TestSingleModel> allTests;

  const TestListingHeader({
    Key? key,
    required this.testsCount,
    required this.testType,
    required this.allTests,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // child | left head
        Text(
          getCapitalizeTextHelper(testType),
          style: screenStylesTestListingHeading,
        ),

        // child | right head
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: globalColorInkWellHighlight,
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            child: Text(
              '$screenConstsViewAll ($testsCount)',
              style: screenStylesTestListingViewAllLink,
            ),
          ),
          onTap: () => Navigator.of(context).push(
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: AllTestsScreen(
                testType: testType,
                allTests: allTests,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
