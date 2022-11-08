import 'dart:convert';

import 'package:flutter/material.dart';

// -- consts | screen
import 'package:app/screens/home/home_consts.dart';

// -- components | screen
import 'package:app/screens/home/components/app_bar/app_bar_component.dart';
import 'package:app/screens/home/components/tests_listing/tests_listing_header_component.dart';
import 'package:app/screens/home/components/tests_listing/test_card_component.dart';

// -- widget | global
import 'package:app/global/widget/navigation_drawer/navigation_drawer_widget.dart';

// -- modals | global
import 'package:app/global/modals/test_modal.dart';

// -- http
import 'package:http/http.dart' as http;

// -- utils | apis
import 'package:app/utilities/apis/all_apis.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final String img1 =
      'https://images.collegexpress.com/article/test-prep-timeline-high-school.jpg';
  final String img2 =
      'https://thumbs.dreamstime.com/b/high-school-university-student-hands-taking-exams-writing-examination-paper-answer-sheet-optical-form-standardized-test-136686809.jpg';
  final String img3 =
      'https://institute4learning.com/blog/wp-content/uploads/2013/02/testing.jpg';
  final String img4 =
      'https://www.sparkadmissions.com/wp-content/uploads/2019/10/02_What_You_Need_to_Know_About_the_SSAT-880x486.jpg';
  final String img5 =
      'https://fordhaminstitute.org/sites/default/files/styles/single_main_image/public/2019-01/test-scores-tell-us-something-about-school-quality-petrilli.jpg?itok=xyOyWNbF';
  final String img6 =
      'https://img.republicworld.com/republic-prod/stories/promolarge/xhdpi/tltkvpcrqcbwm2qm_1629961279.jpeg';
  final String img7 =
      'https://imageio.forbes.com/specials-images/imageserve/5fd928fe0cb59b9eb105c330/Test-with-broken-Pencil/960x0.jpg?format=jpg&width=960';
  final String img8 =
      'https://res.cloudinary.com/picked/image/upload/ar_16:9,c_crop/q_60,h_300,f_auto/v1597396333/cms/teaching-1597396332';
  final String img9 =
      'https://imageio.forbes.com/blogs-images/tomvanderark/files/2019/03/Forbes-Standardized-Testing.jpg?format=jpg&width=1200';
  final String img10 =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN9tTJwVRuRlOWeagyNg_nOc5zes2WAL0ilZ8JszZJtkLHxy0bptscboMOxVWJpSuFSFM&usqp=CAU';

  late Future<List<TestModal>> allTests = Future(() => []);
  bool contentLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    allTests = getData();
  }

  Future<List<TestModal>> getData() async {
    // loading
    setState(() => contentLoading = true);

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(Uri.parse(apiListAllTests));

    final List<TestModal> allTestsData = [];
    final responseStatusCode = response.statusCode;
    final responseBody = response.body;
    final responseBodyData = jsonDecode(responseBody);
    final responseData = responseBodyData['data']['quiz'];

    if (responseStatusCode == 200) {
      if(responseData.isNotEmpty) {
        for (final item in responseData) {
          final List<TestSingleModel> allTestsOnly = [];

          for (final singleTestItem in item['test']) {
            allTestsOnly.add(
              TestSingleModel(
                testId: singleTestItem['id'],
                testType: singleTestItem['type'],
                testName: singleTestItem['name'],
                testQuestions: singleTestItem['total_questions'].toString(),
                testDescription: singleTestItem['text'],
                isPremium: false,
                testImg: '',
              ),
            );
          }

          // pushing data item
          allTestsData.add(TestModal(type: item['type'], allTests: allTestsOnly));
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    // loading
    setState(() => contentLoading = false);

    return allTestsData;
  }

  Future<void> onRefresh() async {
    // loading
    setState(() => contentLoading = true);

    final Future<List<TestModal>> data = getData();

    allTests = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalScaffoldKey,
      backgroundColor: Colors.white,
      appBar: getHomeAppBar(context),
      drawer: const GlobalNavigationDrawer(),
      body: FutureBuilder(
        future: allTests,
        builder: ((context, AsyncSnapshot<List<TestModal>> snapshot) {
          if (snapshot.hasData) {
            final List<TestModal> data = snapshot.data!;
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                itemCount: data.length,
                itemBuilder: ((context, index) {
                  final TestModal item = data[index];
                  final List<TestSingleModel> twoTestItems =
                      item.allTests.take(2).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // -- child | header
                      TestListingHeader(
                        testType: item.type,
                        testsCount: item.allTests.length,
                        allTests: item.allTests,
                      ),
                      const SizedBox(height: 15),

                      // -- child | content
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: twoTestItems.length,
                        itemBuilder: ((context, index) {
                          final TestSingleModel testItem = twoTestItems[index];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TestCard(
                                testName: testItem.testName,
                                testType: testItem.testType,
                                testQuestions: testItem.testQuestions,
                                testDescription: testItem.testDescription,
                                isPremium: testItem.isPremium,
                                testImg: testItem.testImg,
                              ),
                              if (index < 1) ...[
                                const SizedBox(height: 15),
                              ],
                            ],
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                }),
              ),
            );
          } else {
            if (contentLoading) {
              return const Padding(
                padding: EdgeInsets.all(20),
                // child: Center(
                child: CircularProgressIndicator(),
                // ),
              );
            }
            return const Text(
              'no data found',
              textAlign: TextAlign.center,
            );
          }
        }),
      ),
    );
  }
}
