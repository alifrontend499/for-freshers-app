import 'dart:convert';
import 'package:flutter/material.dart';

// screen | loading
import 'package:app/screens/test_view/loading/content_loading_options.dart';
import 'package:app/screens/test_view/loading/content_loading_question.dart';

// -- models | global
import 'package:app/global/models/test_model.dart';

// -- global | model
import 'package:app/global/state/models/selected_answers_model.dart';

// -- helpers | global
import 'package:app/utilities/helpers/helpers.dart';

// -- screen | consts
import 'package:app/screens/test_view/test_view_consts.dart';

// -- screen | styles
import 'package:app/screens/test_view/styles/test_view_styles.dart';

// -- component | screen
import 'package:app/screens/test_view/components/app_bar/app_bar_component.dart';

// screens
import 'package:app/screens/test_view/screens/test_screen.dart';

// -- http
import 'package:http/http.dart' as http;

// -- utils | apis
import 'package:app/utilities/apis/all_apis.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// global | state
import 'package:app/global/state/global_state.dart';

// -- screen | dialog
import 'package:app/screens/test_view/dialog/cancel_test_dialog.dart';

// -- screen | screens
import 'package:app/screens/test_view/pages/test_result/test_result_view.dart';

class TestViewScreen extends ConsumerStatefulWidget {
  const TestViewScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TestViewScreen> createState() => _TestViewScreenState();
}

class _TestViewScreenState extends ConsumerState<TestViewScreen> {
  late PageController controller = PageController(initialPage: 0);
  late List<Widget> children = [];
  late int pagesCount = 0;
  int currentPage = 0;
  bool contentLoading = false;

  // for result screen
  double rightAnswersPercentage = 0;
  int totalAnswersCount = 0;
  int rightAnswersCount = 0;
  int passPercentage = 80;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getting questions
    getTestQuestions();

    // initial checks
    initialStateSetup();
  }

  Future<void> initialStateSetup() async {
    // setting default for | setting global button enable/disable
    ref.read(isAnswerSelectedProvider.notifier).state = false;
    ref.read(isAnswerSelectedProvider.notifier).state = false;
  }

  // get questions list
  List<QuestionDataModel> getQuestionsList(rawData) {
    if (rawData.isEmpty) return [];

    final List<QuestionDataModel> data = [];

    for (final dataItem in rawData) {
      // generating questions data
      data.addAll([
        QuestionDataModel(
          id: dataItem['id'].toString(),
          quizId: dataItem['quiz_id'],
          name: dataItem['name'],
          imgUrl: '',
          options: getOptionsList(dataItem['answers']),
        ),
      ]);
    }

    return data;
  }

  // get options list
  List<OptionsDataModel> getOptionsList(rawData) {
    if (rawData.isEmpty) return [];
    final List<OptionsDataModel> optionsData = [];

    for (final dataItem in rawData) {
      optionsData.addAll([
        OptionsDataModel(
          id: dataItem['id'].toString(),
          optionId: dataItem['question_id'],
          name: dataItem['name'],
          description: dataItem['description'],
          isRight: dataItem['is_right'] == null ? false : true,
        )
      ]);
    }

    return optionsData;
  }

  // getting questions data from network
  Future<void> getTestQuestions() async {
    // loading
    setState(() => contentLoading = true);

    try {
      final onGoingTest = ref.read(ongoingTestProvider);
      // getting data from network
      final response = await http.get(Uri.parse(
          apiGetTestQuestionsDetails(onGoingTest?.testId.toString() ?? '')));
      final responseStatusCode = response.statusCode;
      final responseBody = response.body;
      final responseBodyData = jsonDecode(responseBody);
      final responseData = responseBodyData['data']['quiz'];

      if (responseStatusCode == 200) {
        final questionsData = responseData['question'];
        final List<QuestionDataModel> questions =
            getQuestionsList(questionsData);
        List<Widget> widgetList = [];
        setState(() {
          pagesCount = questions.length;
        });

        int index = 0;
        for (final item in questions) {
          final List<OptionsDataModel> currentAnswers = item.options;

          widgetList.addAll(
            [
              TestScreen(
                pageTitle: 'Page $index',
                controller: controller,
                pagesPosition: index,
                pagesCount: pagesCount,
                questionData: item,
                questionName: item.name,
                questionImgUrl: item.imgUrl,
                options: currentAnswers,
              ),
            ],
          );
          index++;
        }

        setState(() {
          currentPage = 0;
          children = widgetList;
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (err) {
      print('err here there ${err}');
    }

    // loading
    setState(() => contentLoading = false);
  }

  // on back press
  Future<bool> onWillPop() async {
    showDialog(
      context: context,
      builder: (context) => CancelTestDialog(parentRef: ref),
    );
    return false;
  }

  // calculating answers percentage
  Future<void> calculatingAnswersData() async {
    final List<SelectedAnswerModel> selectedAnswersList =
        ref.read(selectedAnswersProvider);
    final Iterable<SelectedAnswerModel> rightAnswersList =
        selectedAnswersList.where((element) => element.wasRight == true);
    final int totalAnswersCountRaw = selectedAnswersList.length;
    final int rightAnswersCountRaw = rightAnswersList.length;

    setState(() {
      totalAnswersCount = totalAnswersCountRaw;
      rightAnswersCount = rightAnswersCountRaw;
      rightAnswersPercentage = getPercentageHelper(
          selectedAnswersList.length, rightAnswersList.length);
    });
  }

  CompletedTestModal? saveCompletedTestDetails() {
    final TestModel? onGoingTest = ref.read(ongoingTestProvider);
    final List<SelectedAnswerModel> selectedAnswers =
        ref.read(selectedAnswersProvider);

    if (onGoingTest != null) {
      final CompletedTestModal completedTest = CompletedTestModal(
        isPremium: onGoingTest.isPremium,
        selectedAnswers: selectedAnswers,
        testDescription: onGoingTest.testDescription,
        testId: onGoingTest.testId,
        testImg: onGoingTest.testImg,
        testName: onGoingTest.testName,
        testQuestions: onGoingTest.testQuestions,
        testType: onGoingTest.testType,
      );
      return completedTest;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isAnswerSelected = ref.watch(isAnswerSelectedProvider);
    final onGoingTest = ref.read(ongoingTestProvider);

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: getTestViewAppBar(
          context, onGoingTest?.testName ?? '', ref, contentLoading),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: contentLoading
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // loading | question
                  const TestViewQuestionContentLoading(),

                  // loading | options
                  Expanded(
                    child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return const TestViewContentLoading();
                      },
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  // child | page view
                  Expanded(
                    child: PageView(
                      controller: controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: children,
                    ),
                  ),

                  // child | bottom section
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        // child | next button
                        Expanded(
                          child: ElevatedButton(
                              style: screenStylesTestNavNextButton(
                                  isAnswerSelected),
                              onPressed: () async {
                                if (isAnswerSelected) {
                                  if (currentPage < (pagesCount - 1)) {
                                    // setting current page
                                    setState(
                                      () => currentPage = currentPage + 1,
                                    );

                                    // changing page
                                    controller.jumpToPage(currentPage);

                                    // setting global button enable/disable
                                    ref
                                        .read(isAnswerSelectedProvider.notifier)
                                        .state = false;
                                  } else {
                                    // calculating answers percentage
                                    await calculatingAnswersData();

                                    // saving completed test details
                                    final CompletedTestModal? completedTestDetails = saveCompletedTestDetails();

                                    // moving to result page
                                    if (mounted) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TestResultView(
                                            rightAnswersPercentage:
                                                rightAnswersPercentage,
                                            totalAnswersCount:
                                                totalAnswersCount,
                                            rightAnswersCount:
                                                rightAnswersCount,
                                            passPercentage: passPercentage,
                                            completedTestDetails: completedTestDetails,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                }
                              },
                              child: currentPage == (pagesCount - 1)
                                  ? const Text(TEST_ACTION_SUBMIT)
                                  : const Text(TEST_ACTION_NEXT)),
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
