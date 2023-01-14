import 'package:app/global/dialogs/global_starting_test_over_dialog/starting_test_over_dialog.dart';
import 'package:app/global/state/global_state.dart';
import 'package:app/screens/test_view/pages/test_summary/test_summary_view.dart';
import 'package:app/utilities/helpers/file_operations.dart';
import 'package:app/utilities/helpers/helpers.dart';
import 'package:flutter/material.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

// -- styles | screen
import 'package:app/screens/test_details/styles/test_details_styles.dart';

// -- consts | screen
import 'package:app/screens/test_details/test_details_consts.dart';

// -- components | screen
import 'package:app/screens/test_details/components/app_bar/app_bar_component.dart';

// -- widget | global
import 'package:app/global/widget/navigation_drawer/navigation_drawer_widget.dart';

// -- all routes consts
import 'package:app/utilities/routing/routing_consts.dart';

// -- package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -- screens
import 'package:page_transition/page_transition.dart';

import '../../global/models/test_model.dart';

class TestDetailsScreen extends ConsumerStatefulWidget {
  const TestDetailsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TestDetailsScreen> createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends ConsumerState<TestDetailsScreen> {
  final String defaultTestId = '';
  final String defaultTestName = '';
  final String defaultTestImg = '';
  final String defaultTestDescription = '';
  bool isTestAlreadyCompleted = false;
  late CompletedTestModel completedTest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkIfTestAlreadyCompleted();
  }

  Future<void> checkIfTestAlreadyCompleted() async {
    final TestModel? onGoingTest = ref.read(ongoingTestProvider);
    if (onGoingTest != null) {
      final int onGoingTestId = onGoingTest.testId;
      final isTestExist = await checkIfCompletedTestExistHelper(onGoingTestId);
      final CompletedTestModel? completedTestRaw =
          await getCompletedTestByIdHelper(onGoingTestId);
      if (isTestExist && completedTestRaw != null) {
        setState(() {
          isTestAlreadyCompleted = isTestExist;
          completedTest = completedTestRaw;
        });
      }
    } else {
      setState(() {
        isTestAlreadyCompleted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final onGoingTest = ref.read(ongoingTestProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getTestDetailsAppBar(
          context, onGoingTest?.testName ?? defaultTestName),
      drawer: const GlobalNavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // child | scroll view
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        // widget.testImg,
                        'https://cdn.pixabay.com/photo/2014/06/03/19/38/board-361516__340.jpg',
                        fit: BoxFit.fill,
                        height: 250,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      onGoingTest?.testName ?? defaultTestName,
                      style: stylesTestHeading,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      onGoingTest?.testDescription ?? defaultTestDescription,
                      style: stylesTestDescription,
                    ),
                  ],
                ),
              ),
            ),

            // child | buttons
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // if the test is completed
                  if (isTestAlreadyCompleted) ...[
                    getCompletedTestDetailsColumn(),
                    const SizedBox(height: 10),
                  ],

                  ElevatedButton(
                    style: submitBtnStyles,
                    onPressed: () {
                      if (isTestAlreadyCompleted) {
                        // showing dialog
                        showDialog(
                          context: context,
                          builder: (context) => StartingTestOverDialog(testId: completedTest.testId),
                        );
                      } else {
                        Navigator.pushNamed(context, testViewScreenRoute);
                      }
                    },
                    child: Text(isTestAlreadyCompleted
                        ? SCREEN_TEXT_START_OVER
                        : SCREEN_SUBMIT_BUTTON),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, homepageScreenRoute),
                    highlightColor: globalColorInkWellHighlight,
                    borderRadius: BorderRadius.circular(5),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 8,
                      ),
                      child: Text(
                        SCREEN_OTHER_TEXT,
                        style: stylesLinkText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Columns | completed test
  Widget getCompletedTestDetailsColumn() => Row(
        children: [
          // child: left sec
          Expanded(
            child: Row(
              children: [
                const Text(
                  "Completed on : ",
                  style: TextStyle(
                    // fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  getDateHelper(completedTest.completedOn),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // child: left sec
          InkWell(
            onTap: () => Navigator.of(context).push(
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: TestSummaryView(
                  completedTestModal: completedTest,
                ),
              ),
            ),
            highlightColor: globalColorInkWellHighlight,
            borderRadius: BorderRadius.circular(5),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8,
              ),
              child: Text(
                'View Summary',
                style: stylesLinkTextSmall,
              ),
            ),
          ),
        ],
      );
}
