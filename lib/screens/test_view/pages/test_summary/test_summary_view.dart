import 'package:app/global/colors/global_colors.dart';
import 'package:app/global/models/test_model.dart';
import 'package:app/screens/test_view/pages/test_summary/components/app_bar/app_bar_component.dart';
import 'package:flutter/material.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestSummaryView extends ConsumerStatefulWidget {
  final CompletedTestModel completedTestModal;

  const TestSummaryView({
    Key? key,
    required this.completedTestModal,
  }) : super(key: key);

  @override
  ConsumerState<TestSummaryView> createState() => _TestSummaryViewState();
}

class _TestSummaryViewState extends ConsumerState<TestSummaryView> {
  late List<SelectedAnswerModel> selectedAnswers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // setting answers
    setState(() {
      selectedAnswers = widget.completedTestModal.selectedAnswers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTestSummaryAppBar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.completedTestModal?.testName ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: globalColorAppPrimary,
              ),
            ),
            const SizedBox(height: 20),

            // child | selected questions and answers
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: widget.completedTestModal.selectedAnswers.length,
                itemBuilder: ((context, index) {
                  final SelectedAnswerModel selectedAnswerDataItem =
                      widget.completedTestModal.selectedAnswers[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // child | question heading
                      questionHeadingWidget(selectedAnswerDataItem),
                      const SizedBox(height: 5),

                      // child | question name
                      Text(
                        selectedAnswerDataItem.questionData.name,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // child | answers heading
                      answerHeadingWidget(selectedAnswerDataItem),
                      const SizedBox(height: 5),

                      // child | options list
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            selectedAnswerDataItem.questionData.options.length,
                        itemBuilder: ((context, index) {
                          final OptionsDataModel optionsDataItem =
                              selectedAnswerDataItem
                                  .questionData.options[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              optionItemWidget(
                                  selectedAnswerDataItem, optionsDataItem),
                              const SizedBox(height: 3),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // question container
  Widget questionHeadingWidget(SelectedAnswerModel dataItem) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          // child | icon
          Icon(
            Icons.question_answer_rounded,
            size: 17,
            color: globalColorAppPrimary,
          ),
          SizedBox(width: 5),
          Text(
            'Question: ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: globalColorAppPrimary,
              fontSize: 16,
            ),
          ),
        ],
      );

  Widget answerHeadingWidget(SelectedAnswerModel dataItem) => Row(
        children: [
          const Text(
            'Your Answers: ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: globalColorAppPrimary,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            dataItem.wasRight ? 'Right' : 'Wrong',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: dataItem.wasRight ? Colors.green : Colors.red,
              fontSize: 16,
            ),
          ),
        ],
      );

  Widget optionItemWidget(SelectedAnswerModel selectedAnswerDataItem,
      OptionsDataModel optionsDataItem) {
    final bool rightAnswer =
        selectedAnswerDataItem.wasRight == optionsDataItem.isRight;
    return Row(
      children: [
        if (rightAnswer) ...[
          const Icon(
            Icons.check,
            size: 17,
            color: globalColorAppPrimary,
          ),
          const SizedBox(width: 5),
        ],
        Text(
          optionsDataItem.name,
          style: TextStyle(
            fontSize: 15,
            color: optionsDataItem.isRight ? Colors.green : Colors.black,
            fontWeight: rightAnswer ? FontWeight.w600 : FontWeight.w100,
          ),
        ),
      ],
    );
  }
}
