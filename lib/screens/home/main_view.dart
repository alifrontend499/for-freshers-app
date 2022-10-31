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
  final String img1 = 'https://images.collegexpress.com/article/test-prep-timeline-high-school.jpg';
  final String img2 = 'https://thumbs.dreamstime.com/b/high-school-university-student-hands-taking-exams-writing-examination-paper-answer-sheet-optical-form-standardized-test-136686809.jpg';
  final String img3 = 'https://institute4learning.com/blog/wp-content/uploads/2013/02/testing.jpg';
  final String img4 = 'https://www.sparkadmissions.com/wp-content/uploads/2019/10/02_What_You_Need_to_Know_About_the_SSAT-880x486.jpg';
  final String img5 = 'https://fordhaminstitute.org/sites/default/files/styles/single_main_image/public/2019-01/test-scores-tell-us-something-about-school-quality-petrilli.jpg?itok=xyOyWNbF';
  final String img6 = 'https://img.republicworld.com/republic-prod/stories/promolarge/xhdpi/tltkvpcrqcbwm2qm_1629961279.jpeg';
  final String img7 = 'https://imageio.forbes.com/specials-images/imageserve/5fd928fe0cb59b9eb105c330/Test-with-broken-Pencil/960x0.jpg?format=jpg&width=960';
  final String img8 = 'https://res.cloudinary.com/picked/image/upload/ar_16:9,c_crop/q_60,h_300,f_auto/v1597396333/cms/teaching-1597396332';
  final String img9 = 'https://imageio.forbes.com/blogs-images/tomvanderark/files/2019/03/Forbes-Standardized-Testing.jpg?format=jpg&width=1200';
  final String img10 = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN9tTJwVRuRlOWeagyNg_nOc5zes2WAL0ilZ8JszZJtkLHxy0bptscboMOxVWJpSuFSFM&usqp=CAU';

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
                    children: [
                      // -- child | test card
                      Expanded(
                        child: TestCard(
                          testName: 'Practice Test 2',
                          testType: 'Easy',
                          testQuestions: '15',
                          testDescription: '',
                          isPremium: true,
                          testImg: img1,
                        ),
                      ),
                      const SizedBox(width: 15),

                      // -- child | test card
                      Expanded(
                        child: TestCard(
                          testName: 'Test your GK',
                          testType: 'Easy',
                          testQuestions: '10 - 15',
                          testDescription: '',
                          isPremium: true,
                          testImg: img2,
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
                    children: [
                      // -- child | test card
                      Expanded(
                        child: TestCard(
                          testName: 'Practice Test 2',
                          testType: 'Hard',
                          testQuestions: '15',
                          testDescription: '',
                          isPremium: false,
                          testImg: img3,
                        ),
                      ),
                      const SizedBox(width: 15),

                      // -- child | test card
                      Expanded(
                        child: TestCard(
                          testName: 'Test your GK',
                          testType: 'Hard',
                          testQuestions: '10 - 15',
                          testDescription: '',
                          isPremium: false,
                          testImg: img4,
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
                    children: [
                      // -- child | test card
                      Expanded(
                        child: TestCard(
                          testName: 'Practice Test 2',
                          testType: 'Hardest',
                          testQuestions: '15',
                          testDescription: '',
                          isPremium: false,
                          testImg: img5,
                        ),
                      ),
                      const SizedBox(width: 15),

                      // -- child | test card
                      Expanded(
                        child: TestCard(
                          testName: 'Test your GK',
                          testType: 'Hardest',
                          testQuestions: '10 - 15',
                          testDescription: '',
                          isPremium: true,
                          testImg: img6,
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
                    children: [
                      // -- child | test card
                      Expanded(
                        child: TestCard(
                          testName: 'Practice Test 2',
                          testType: 'Other',
                          testQuestions: '20-25',
                          testDescription: '',
                          isPremium: false,
                          testImg: img7,
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
