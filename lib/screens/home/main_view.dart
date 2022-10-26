import 'package:flutter/material.dart';

// -- consts | screen
import 'package:app/screens/home/home_consts.dart';

// -- components | screen
import 'package:app/screens/home/components/app_bar/app_bar_component.dart';
import 'package:app/screens/home/components/tests_listing/tests_listing_header_component.dart';
import 'package:app/screens/home/components/tests_listing/test_card_component.dart';

// -- widget | global
import 'package:app/global/widget/navigation_drawer/navigation_drawer_widget.dart';

// -- dummy data
import 'package:app/screens/home/dummy_data.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalScaffoldKey,
      backgroundColor: Colors.white,
      appBar: getHomeAppBar(context),
      drawer: const GlobalNavigationDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          width: double.infinity,
          child: Column(
            children: [
              Column(
                children: [
                  // -- child | header
                  TestListingHeader(
                    testType: screenConstsTestListingTitleEasy,
                    testsCount: 5,
                    allTests: ALL_EASY_TESTS,
                  ),
                  const SizedBox(height: 15),

                  // -- child | bottom sec
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // -- child | test card
                      Expanded(
                        child: TestCard(
                          testName: 'Practice Test 2',
                          testType: 'Easy',
                          testQuestions: '15',
                          testDescription: '',
                          isPremium: true,
                        ),
                      ),
                      SizedBox(width: 15),

                      // -- child | test card
                      Expanded(
                        child: TestCard(
                          testName: 'Test your GK',
                          testType: 'Easy',
                          testQuestions: '10 - 15',
                          testDescription: '',
                          isPremium: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Column(
                children: [
                  // -- child | header
                  TestListingHeader(
                    testType: screenConstsTestListingTitleHard,
                    testsCount: 3,
                    allTests: ALL_HARD_TESTS,
                  ),
                  const SizedBox(height: 15),

                  // -- child | bottom sec
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // -- child | test card
                      Expanded(
                        child: TestCard(
                          testName: 'Practice Test 2',
                          testType: 'Hard',
                          testQuestions: '15',
                          testDescription: '',
                          isPremium: false,
                        ),
                      ),
                      SizedBox(width: 15),

                      // -- child | test card
                      Expanded(
                        child: TestCard(
                          testName: 'Test your GK',
                          testType: 'Hard',
                          testQuestions: '10 - 15',
                          testDescription: '',
                          isPremium: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Column(
                children: [
                  // -- child | header
                  TestListingHeader(
                    testType: screenConstsTestListingTitleHardest,
                    testsCount: 3,
                    allTests: ALL_HARDEST_TESTS,
                  ),
                  const SizedBox(height: 15),

                  // -- child | bottom sec
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // -- child | test card
                      Expanded(
                        child: TestCard(
                          testName: 'Practice Test 2',
                          testType: 'Hardest',
                          testQuestions: '15',
                          testDescription: '',
                          isPremium: false,
                        ),
                      ),
                      SizedBox(width: 15),

                      // -- child | test card
                      Expanded(
                        child: TestCard(
                          testName: 'Test your GK',
                          testType: 'Hardest',
                          testQuestions: '10 - 15',
                          testDescription: '',
                          isPremium: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Column(
                children: [
                  // -- child | header
                  TestListingHeader(
                    testType: "Other",
                    testsCount: 3,
                    allTests: ALL_OTHERS_TESTS,
                  ),
                  const SizedBox(height: 15),

                  // -- child | bottom sec
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // -- child | test card
                      Expanded(
                        child: TestCard(
                          testName: 'Practice Test 2',
                          testType: 'Other',
                          testQuestions: '20-25',
                          testDescription: '',
                          isPremium: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
