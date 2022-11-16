import 'dart:convert';

import 'package:app/screens/test_view/loading/content_loading_options.dart';
import 'package:app/screens/test_view/loading/content_loading_question.dart';
import 'package:app/screens/test_view/models/question_and_options_model.dart';
import 'package:flutter/material.dart';

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

class TestViewScreen extends StatefulWidget {
  final String testId;
  final String testName;

  const TestViewScreen({
    Key? key,
    required this.testId,
    required this.testName,
  }) : super(key: key);

  @override
  State<TestViewScreen> createState() => _TestViewScreenState();
}

class _TestViewScreenState extends State<TestViewScreen> {
  late PageController controller = PageController(initialPage: 0);
  late List<Widget> children = [];
  late int pagesCount = 0;
  int currentPage = 0;
  bool contentLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getTestQuestions();
  }

  // get questions list
  List<QuestionModel> getQuestionsList(rawData) {
    if (rawData.isEmpty) return [];

    final List<QuestionModel> data = [];

    for (final dataItem in rawData) {
      // generating questions data
      data.addAll([
        QuestionModel(
          id: dataItem['id'].toString(),
          quizId: dataItem['quiz_id'],
          name: dataItem['name'],
          options: getOptionsList(dataItem['answers']),
        ),
      ]);
    }

    return data;
  }

  // get options list
  List<OptionsModel> getOptionsList(rawData) {
    if (rawData.isEmpty) return [];
    final List<OptionsModel> optionsData = [];

    for (final dataItem in rawData) {
      optionsData.addAll([
        OptionsModel(
          id: dataItem['id'].toString(),
          optionId: dataItem['question_id'],
          name: dataItem['name'],
          description: dataItem['description'],
          isRight: false,
        )
      ]);
    }

    return optionsData;
  }

  Future<void> getTestQuestions() async {
    // loading
    setState(() => contentLoading = true);

    try {
      // getting data from network
      final response =
          await http.get(Uri.parse(apiGetTestQuestionsDetails(widget.testId)));
      final responseStatusCode = response.statusCode;
      final responseBody = response.body;
      final responseBodyData = jsonDecode(responseBody);
      final responseData = responseBodyData['data']['quiz'];

      if (responseStatusCode == 200) {
        final questionsData = responseData['question'];
        final List<QuestionModel> questions = getQuestionsList(questionsData);
        List<Widget> widgetList = [];
        setState(() {
          pagesCount = questions.length;
        });

        int index = 0;
        for (final item in questions) {
          final List<OptionsModel> currentAnswers = item.options;

          print('item.options ${item.options}');

          widgetList.addAll(
            [
              TestScreen(
                pageTitle: 'Page $index',
                controller: controller,
                pagesPosition: index,
                pagesCount: pagesCount,
                questionName: item.name,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: getTestViewAppBar(context, widget.testName),
      body: contentLoading
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
                    // physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) => setState(() => currentPage = index + 1),
                    children: children,
                  ),
                ),

                // child | bottom section
                // Padding(
                //   padding: const EdgeInsets.all(20),
                //   child: Row(
                //     children: [
                //       if (currentPage > 0) ...[
                //         // child | next button
                //         Expanded(
                //           child: ElevatedButton(
                //             style: screenStylesTestNavPrevButton,
                //             onPressed: () {
                //               setState(() => currentPage = currentPage - 1);
                //               controller.jumpToPage(currentPage);
                //             },
                //             child: const Text(TEST_ACTION_PREV),
                //           ),
                //         ),
                //         const SizedBox(width: 20),
                //       ],
                //
                //       // child | next button
                //       Expanded(
                //         child: ElevatedButton(
                //           style: screenStylesTestNavNextButton,
                //           onPressed: () {
                //             if (currentPage <= pagesCount) {
                //               setState(() => currentPage = currentPage + 1);
                //               controller.jumpToPage(currentPage);
                //             }
                //           },
                //           child: const Text(TEST_ACTION_NEXT),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
    );
  }
}
