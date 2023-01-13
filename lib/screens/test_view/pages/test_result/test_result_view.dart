import 'package:app/global/models/test_model.dart';
import 'package:app/screens/test_view/main_view.dart';
import 'package:app/screens/test_view/pages/test_summary/test_summary_view.dart';
import 'package:app/utilities/helpers/file_operations.dart';
import 'package:flutter/material.dart';

// global | routes
import 'package:app/utilities/routing/routing_consts.dart';

// -- screen | consts
import 'package:app/screens/test_view/test_view_consts.dart';

// -- styles | screen
import 'package:app/screens/test_view/styles/test_view_styles.dart';

// -- settings | global
import 'package:app/global/settings/global_settings.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

// -- screen | components
import 'package:app/screens/test_view/pages/test_result/components/app_bar/app_bar_component.dart';

// global | state
import 'package:app/global/state/helpers/global_state_helper.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class TestResultView extends ConsumerStatefulWidget {
  final double rightAnswersPercentage;
  final int totalAnswersCount;
  final int rightAnswersCount;
  final int passPercentage;
  final CompletedTestModel completedTestDetails;

  const TestResultView({
    Key? key,
    required this.rightAnswersPercentage,
    required this.totalAnswersCount,
    required this.rightAnswersCount,
    required this.passPercentage,
    required this.completedTestDetails,
  }) : super(key: key);

  @override
  ConsumerState<TestResultView> createState() => _TestResultViewState();
}

class _TestResultViewState extends ConsumerState<TestResultView> {
  // on back pressed
  Future<bool> onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTestResultAppBar(context),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Column(
          children: [
            // child | main content
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Column(
                      children: [
                        const Text(
                          RESULT_PAGE_HEADING,
                          textAlign: TextAlign.center,
                          style: screenStylesTestResultHead,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          RESULT_PAGE_HEADING_OTHER(
                              widget.rightAnswersPercentage.toString()),
                          textAlign: TextAlign.center,
                          style: screenStylesTestResultHeadPercentage,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // progress circle
                    Stack(
                      children: [
                        // circular progress
                        SizedBox(
                          height: 160,
                          width: 160,
                          child: CircularProgressIndicator(
                            value: widget.rightAnswersPercentage / 100,
                            valueColor: const AlwaysStoppedAnimation(
                                globalColorAppPrimary),
                            backgroundColor: Colors.black12,
                            strokeWidth: 9,
                          ),
                        ),
                        Positioned.fill(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${widget.rightAnswersCount}',
                                      style:
                                          screenStylesCircularPercentageInsideText(
                                              25, FontWeight.w600),
                                    ),
                                    const SizedBox(width: 1),
                                    Text(
                                      '/',
                                      style:
                                          screenStylesCircularPercentageInsideText(
                                              23, FontWeight.w400),
                                    ),
                                    const SizedBox(width: 1),
                                    Text(
                                      '${widget.totalAnswersCount}',
                                      style:
                                          screenStylesCircularPercentageInsideText(
                                              19, FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                const Text(
                                  RESULT_PAGE_QUESTIONS_RIGHT,
                                  style: screenStylesTestResultRightQuesText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // other info
                    Text(
                      widget.rightAnswersPercentage > widget.passPercentage
                          ? RESULT_PAGE_TEST_PASSED
                          : RESULT_PAGE_TEST_FAILED,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: widget.rightAnswersPercentage >
                                widget.passPercentage
                            ? Colors.green
                            : Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      widget.rightAnswersPercentage > widget.passPercentage
                          ? RESULT_PAGE_PASSED_TEST_MSG(
                              widget.rightAnswersPercentage.toString())
                          : RESULT_PAGE_FAILED_TEST_MSG(
                              widget.passPercentage.toString()),
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 15),

                    InkWell(
                      onTap: () => Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: TestSummaryView(
                            completedTestModal: widget.completedTestDetails,
                          ),
                        ),
                      ),
                      highlightColor: globalColorInkWellHighlight,
                      borderRadius: BorderRadius.circular(5),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 9),
                        child: Text(
                          RESULT_PAGE_TEST_SUMMARY,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: globalColorAppPrimary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // child | bottom section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // child | button | retry test
                  if (widget.rightAnswersPercentage <
                      widget.passPercentage) ...[
                    ElevatedButton(
                      onPressed: () async {
                        // deleting selected answer state
                        retryTestGlobalHelper(ref);

                        // navigating to test
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TestViewScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(
                          double.minPositive,
                          globalSettingsDefaultButtonHeight,
                        ),
                        backgroundColor: Colors.white.withOpacity(.7),
                        splashFactory: NoSplash.splashFactory,
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        RESULT_PAGE_RETRY_TEST,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],

                  // child | button
                  ElevatedButton(
                    onPressed: () {
                      // deleting selected answer state
                      testCompleteGlobalHelper(ref);

                      // navigating to home
                      Navigator.pushNamedAndRemoveUntil(
                          context, homepageScreenRoute, (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.minPositive,
                          globalSettingsDefaultButtonHeight),
                      backgroundColor: globalColorAppPrimary,
                      splashFactory: NoSplash.splashFactory,
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(RESULT_PAGE_OTHER_TESTS),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
