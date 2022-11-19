import 'package:flutter/material.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

// -- styles | screen
import 'package:app/screens/test_details/styles/test_details_styles.dart';

// -- consts | screen
import 'package:app/screens/test_details/test_details_consts.dart';

// -- components | screen
import 'package:app/screens/test_details/components/app_bar/app_bar_component.dart';

// -- widget | global
import 'package:app/global/widget/navigation_drawer/navigation_drawer_widget.dart';

// -- all routes consts
import 'package:app/utilities/routing/routing_consts.dart';

// -- screens
import 'package:app/screens/test_view/main_view.dart';

class TestDetailsScreen extends StatefulWidget {
  final String testId;
  final String testName;
  final String testImg;
  final String testDescription;

  const TestDetailsScreen({
    Key? key,
    required this.testId,
    required this.testName,
    required this.testImg,
    required this.testDescription,
  }) : super(key: key);

  @override
  State<TestDetailsScreen> createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends State<TestDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getTestDetailsAppBar(context, widget.testName),
      drawer: const GlobalNavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // child | scroll view
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        // widget.testImg,
                        'https://cdn.pixabay.com/photo/2014/06/03/19/38/board-361516__340.jpg',
                        fit: BoxFit.fill,
                        height: 250,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.testName,
                      style: stylesTestHeading,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.testDescription,
                      style: stylesTestDescription,
                    ),
                  ],
                ),
              ),
            ),

            // child | buttons
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: submitBtnStyles,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestViewScreen(
                          testName: widget.testName,
                          testId: widget.testId,
                        ),
                      ),
                    ),
                    child: const Text(SCREEN_SUBMIT_BUTTON),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, homepageScreenRoute),
                    highlightColor: globalColorInkWellHighlight,
                    borderRadius: BorderRadius.circular(5),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 8,
                      ),
                      child: Text(
                        SCREEN_OTHER_TEXT,
                        style: stylesLinkText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
