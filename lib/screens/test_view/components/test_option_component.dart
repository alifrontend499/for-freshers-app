import 'package:app/global/colors/global_colors.dart';
import 'package:app/screens/test_view/models/question_and_options_model.dart';
import 'package:flutter/material.dart';

class TestOption extends StatefulWidget {
  final List<OptionsModel> optionsData;

  const TestOption({
    Key? key,
    required this.optionsData,
  }) : super(key: key);

  @override
  State<TestOption> createState() => _TestOptionState();
}

class _TestOptionState extends State<TestOption> {
  bool isSelected = false;
  String selectedOptionId = '';
  Color selectedOptionColor = globalColorAppPrimary;
  Color containerColor = Colors.white;

  void checkAnswer(String id) {
    final OptionsModel selectedOption = widget.optionsData.firstWhere((item) => item.id == id);

    setState(() {
      selectedOptionId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.optionsData.length,
      itemBuilder: ((context, index) {
        final dataItem = widget.optionsData[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // child | option
            InkWell(
              onTap: () => checkAnswer(dataItem.id),
              highlightColor: globalColorInkWellHighlight,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: selectedOptionId == dataItem.id ? selectedOptionColor : containerColor,
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
                    color: selectedOptionId == dataItem.id ? Colors.white : Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            // child | option description
            if (isSelected) ...[
              const SizedBox(height: 5),
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

