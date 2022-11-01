import 'package:flutter/material.dart';

// -- screen | styles
import 'package:app/screens/test_view/styles/test_view_styles.dart';

class TestScreen extends StatefulWidget {
  final String pageTitle;
  final PageController controller;
  final int currentPage;
  final int pagesCount;

  const TestScreen({
    Key? key,
    required this.pageTitle,
    required this.controller,
    required this.currentPage,
    required this.pagesCount,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisSize: MainAxisSize.max,
        children: [
          const Text('hello'),
        ],
      ),
    );
  }
}
