import 'package:app/global/colors/global_colors.dart';
import 'package:app/global/models/test_model.dart';
import 'package:app/global/state/models/selected_answers_model.dart';
import 'package:app/screens/test_view/pages/test_summary/components/app_bar/app_bar_component.dart';
import 'package:flutter/material.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestSummaryView extends ConsumerStatefulWidget {
  final CompletedTestModal completedTestModal;

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

            // child | selected questions and ansers
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: widget.completedTestModal.selectedAnswers.length,
                itemBuilder: ((context, index) {
                  final SelectedAnswerModel dataItem =
                      widget.completedTestModal.selectedAnswers[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // child | question name
                      const Text(
                        'Question: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: globalColorAppPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        dataItem.questionData.name,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // child | answers
                      const Text(
                        'Answers: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: globalColorAppPrimary,
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: ((context, index) {
                          return const Text('hello');
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
}
