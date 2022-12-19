import 'package:flutter/material.dart';

// -- global | colors
import 'package:app/global/colors/global_colors.dart';

// -- screen | model
import 'package:app/screens/test_view/models/question_and_options_model.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// --global | state
import 'package:app/global/state/global_state.dart';

// -- global | model
import 'package:app/global/state/models/selected_answers_model.dart';

// -- global state | helpers
import 'package:app/global/state/helpers/global_state_helper.dart';

class TestOption extends ConsumerStatefulWidget {
  final QuestionModel questionData;
  final List<OptionsModel> optionsData;

  const TestOption({
    Key? key,
    required this.questionData,
    required this.optionsData,
  }) : super(key: key);

  @override
  ConsumerState<TestOption> createState() => _TestOptionState();
}

class _TestOptionState extends ConsumerState<TestOption> {
  List<OptionsModel> optionsData = [];
  bool isSelected = false;
  String selectedOptionId = '';
  Color selectedOptionColor = globalColorAppPrimary;
  Color containerColor = Colors.white;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // setting options data
    setState(() => optionsData = widget.optionsData);
  }

  // when user selects any option
  void checkAnswer(String id) {
    final OptionsModel selectedOption =
        widget.optionsData.firstWhere((item) => item.id == id);

    // setting selected option
    setState(() => selectedOptionId = id);

    if (selectedOption.isRight == true) {
      setState(() => selectedOptionColor = Colors.greenAccent);
    } else {
      setState(() => selectedOptionColor = Colors.redAccent);
    }

    // setting global button enable/disable
    ref.watch(isAnswerSelectedProvider.notifier).state = true;

    // setting global state for
    updateSelectedAnswersProviderGlobalHelper(
      ref,
      SelectedAnswerModel(
        questionId: widget.questionData.id,
        questionData: widget.questionData,
        selectedOn: DateTime.now(),
        selectedOption: selectedOption,
        wasRight: selectedOption.isRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: optionsData.length,
      itemBuilder: ((context, index) {
        final dataItem = optionsData[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // child | option
            InkWell(
              onTap: () {
                print('object');
                final isAnswerSelected = ref.watch(isAnswerSelectedProvider);
                if (isAnswerSelected == false) {
                  checkAnswer(dataItem.id);
                }
              },
              highlightColor: globalColorInkWellHighlight,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: selectedOptionId.isNotEmpty
                      ? dataItem.isRight == true
                          ? Colors.greenAccent
                          : selectedOptionId == dataItem.id
                              ? Colors.redAccent
                              : containerColor
                      : containerColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      offset: const Offset(1, 1),
                      blurRadius: 6,
                      // spreadRadius: 1
                    )
                  ],
                ),
                child: Text(
                  dataItem.name,
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selectedOptionId.isNotEmpty
                        ? dataItem.isRight == true
                            ? Colors.white
                            : selectedOptionId == dataItem.id
                                ? Colors.white
                                : Colors.black
                        : Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            // child | option description
            if (selectedOptionId.isNotEmpty && dataItem.isRight == true) ...[
              const SizedBox(height: 15),
              Text(
                dataItem.description,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
            ],

            const SizedBox(height: 25),
          ],
        );
      }),
    );
  }
}
