import 'package:app/screens/test_view/screens/test_screen.dart';
import 'package:flutter/material.dart';

// -- screen | styles
import 'package:app/screens/test_view/styles/test_view_styles.dart';

// -- component | screen
import 'package:app/screens/test_view/components/app_bar/app_bar_component.dart';

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

    pagesCount = 1;
    children.addAll([
      TestScreen(
        pageTitle: 'First Page',
        controller: controller,
        currentPage: currentPage,
        pagesCount: pagesCount,
      ),
      TestScreen(
        pageTitle: 'Second Page',
        controller: controller,
        currentPage: currentPage,
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
              onPageChanged: (index) => setState(() => currentPage = index + 1),
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
                        controller.jumpToPage(0);
                      },
                      child: const Text('Prev'),
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
                        controller.jumpToPage(currentPage + 1);
                      }
                    },
                    child: const Text('Next'),
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
