import 'package:app/global/colors/global_colors.dart';
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
  final Map<String, dynamic> answers;

  const TestScreen({
    Key? key,
    required this.pageTitle,
    required this.controller,
    required this.pagesPosition,
    required this.pagesCount,
    required this.answers,
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
        // mainAxisSize: MainAxisSize.max,
        children: [
          // child | top part
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Questions ${widget.pagesPosition}/${widget.pagesCount}',
                style: const TextStyle(
                  color: globalColorAppPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),

              // child | question
              Text(
                'How many planets are there in our galaxy',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }
}
