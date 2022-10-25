import 'package:flutter/material.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

// -- styles | screen
import 'package:app/screens/home/styles/home_styles.dart';

// -- consts | screen
import 'package:app/screens/home/home_consts.dart';

// -- routes
import 'package:app/utilities/routing/routing_consts.dart';

class TestListingHeader extends StatelessWidget {
  final int testsCount;
  final String testType;

  const TestListingHeader({
    Key? key,
    required this.testsCount,
    required this.testType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // child | left head
        Text(
          testType,
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
          onTap: () => Navigator.pushNamed(context, homepageScreenRoute),
        ),
      ],
    );
  }
}
