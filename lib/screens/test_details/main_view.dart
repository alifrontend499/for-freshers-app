import 'package:app/global/state/global_state.dart';
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

// -- package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -- screens
import 'package:app/screens/test_view/main_view.dart';

class TestDetailsScreen extends ConsumerStatefulWidget {
  const TestDetailsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TestDetailsScreen> createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends ConsumerState<TestDetailsScreen> {
  final String defaultTestId = '';
  final String defaultTestName = '';
  final String defaultTestImg = '';
  final String defaultTestDescription = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final onGoingTest = ref.read(ongoingTestProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getTestDetailsAppBar(
          context, onGoingTest?.testName ?? defaultTestName),
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
                      onGoingTest?.testName ?? defaultTestName,
                      style: stylesTestHeading,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      onGoingTest?.testDescription ?? defaultTestDescription,
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
                        builder: (context) => const TestViewScreen(),
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
