import 'package:flutter/material.dart';

// -- screen | consts
import 'package:app/screens/test_view/test_view_consts.dart';

// -- screen | styles
import 'package:app/screens/test_view/styles/test_view_styles.dart';

// -- component | screen
import 'package:app/screens/test_view/components/app_bar/app_bar_component.dart';

// screens
import 'package:app/screens/test_view/screens/test_screen.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pagesCount = 2;
    children.addAll([
      TestScreen(
        pageTitle: 'First Page',
        controller: controller,
        pagesPosition: 1,
        pagesCount: pagesCount,
      ),
      TestScreen(
        pageTitle: 'Second Page',
        controller: controller,
        pagesPosition: 2,
        pagesCount: pagesCount,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: getTestViewAppBar(context, widget.testName),
      body: Column(
        children: [
          // child | page view
          Expanded(
            child: PageView(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              // onPageChanged: (index) => setState(() => currentPage = index + 1),
              children: children,
            ),
          ),

          // child | bottom section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                if (currentPage > 0) ...[
                  // child | next button
                  Expanded(
                    child: ElevatedButton(
                      style: screenStylesTestNavPrevButton,
                      onPressed: () {
                        final int action = currentPage - 1;
                        setState(() => currentPage = action);
                        controller.jumpToPage(currentPage);
                      },
                      child: const Text(TEST_ACTION_PREV),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],

                // child | next button
                Expanded(
                  child: ElevatedButton(
                    style: screenStylesTestNavNextButton,
                    onPressed: () {
                      if (currentPage < pagesCount) {
                        final int action = currentPage + 1;
                        setState(() => currentPage = action);
                        print('currentPage $currentPage');
                        controller.jumpToPage(currentPage);
                      }
                    },
                    child: const Text(TEST_ACTION_NEXT),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
