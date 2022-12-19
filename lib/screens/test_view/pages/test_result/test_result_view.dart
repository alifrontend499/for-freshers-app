import 'package:app/screens/test_details/main_view.dart';
import 'package:app/screens/test_view/main_view.dart';
import 'package:flutter/material.dart';

// global | routes
import 'package:app/utilities/routing/routing_consts.dart';

// -- screen | consts
import 'package:app/screens/test_view/test_view_consts.dart';

// -- styles | screen
import 'package:app/screens/test_view/styles/test_view_styles.dart';

// -- settings | global
import 'package:app/global/settings/global_settings.dart';

// -- helpers | global
import 'package:app/utilities/helpers/helpers.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

// -- screen | components
import 'package:app/screens/test_view/pages/test_result/components/app_bar/app_bar_component.dart';

// global | state
import 'package:app/global/state/global_state.dart';
import 'package:app/global/state/helpers/global_state_helper.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// models
import 'package:app/global/state/models/selected_answers_model.dart';

class TestResultView extends ConsumerStatefulWidget {
  const TestResultView({Key? key}) : super(key: key);

  @override
  ConsumerState<TestResultView> createState() => _TestResultViewState();
}

class _TestResultViewState extends ConsumerState<TestResultView> {
  double rightQuestionsPercentage = 0;
  int totalQuestionsCount = 0;
  int rightQuestionsCount = 0;
  int passPercentage = 50;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // initial checks
    getData();
  }

  Future<void> getData() async {
    final List<SelectedAnswerModel> questionsData =
        ref.read(selectedAnswersProvider);
    final rightQuestions =
        questionsData.where((element) => element.wasRight == true);
    final int totalQuestionsCountRaw = questionsData.length;
    final int rightQuestionsCountRaw = rightQuestions.length;
    double percentage =
        getPercentageHelper(questionsData.length, rightQuestions.length);
    setState(() {
      totalQuestionsCount = totalQuestionsCountRaw;
      rightQuestionsCount = rightQuestionsCountRaw;
      rightQuestionsPercentage = percentage;
    });
  }

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
                          style: TextStyle(fontSize: 21),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          RESULT_PAGE_HEADING_OTHER(
                              rightQuestionsPercentage.toString()),
                          textAlign: TextAlign.center,
                          style: screenStylesTestResultHead,
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
                            value: rightQuestionsPercentage / 100,
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
                                      '$rightQuestionsCount',
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
                                      '$totalQuestionsCount',
                                      style:
                                          screenStylesCircularPercentageInsideText(
                                              19, FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                const Text(
                                  RESULT_PAGE_QUESTIONS_RIGHT,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
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
                      rightQuestionsPercentage > passPercentage
                          ? 'PASSED'
                          : 'FAILED',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: rightQuestionsPercentage > passPercentage
                            ? Colors.green
                            : Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      rightQuestionsPercentage > passPercentage
                          ? 'You have passed the test with ${rightQuestionsPercentage.toString()}% total score.'
                          : 'You should score at least 50 percent to pass the test. you can always try again',
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
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
                  if(rightQuestionsPercentage < passPercentage) ...[
                    ElevatedButton(
                      onPressed: () {
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
