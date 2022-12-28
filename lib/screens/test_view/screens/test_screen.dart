import 'package:app/global/colors/global_colors.dart';
import 'package:app/global/models/test_model.dart';
import 'package:flutter/material.dart';

// -- screen | styles
import 'package:app/screens/test_view/styles/test_view_styles.dart';

// -- screen | components
import 'package:app/screens/test_view/components/test_option_component.dart';

class TestScreen extends StatefulWidget {
  final String pageTitle;
  final PageController controller;
  final int pagesCount;
  final int pagesPosition;
  final QuestionDataModel questionData;
  final String questionName;
  final String questionImgUrl;
  final List<OptionsDataModel> options;

  const TestScreen({
    Key? key,
    required this.pageTitle,
    required this.controller,
    required this.pagesPosition,
    required this.pagesCount,
    required this.questionData,
    required this.questionName,
    required this.questionImgUrl,
    required this.options,
  }) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // child | top part
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Questions ${widget.pagesPosition + 1}/${widget.pagesCount}',
                style: const TextStyle(
                  color: globalColorAppPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),

              // child | question
              Text(
                widget.questionName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if(widget.questionImgUrl.isNotEmpty) ...[
                const SizedBox(height: 15),
                Image.network('https://miro.medium.com/max/1400/1*DvJgeV_GHPkkA2aXq3Vr5g.png')
              ],
            ],
          ),
          const SizedBox(height: 50),

          // child | options
          TestOption(
            questionData: widget.questionData,
            optionsData: widget.options,
          ),
        ],
      ),
    );
  }
}
