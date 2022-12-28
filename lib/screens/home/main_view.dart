import 'dart:convert';

import 'package:flutter/material.dart';

// -- components | screen
import 'package:app/screens/home/components/app_bar/app_bar_component.dart';
import 'package:app/screens/home/components/tests_listing/tests_listing_header_component.dart';
import 'package:app/screens/home/components/tests_listing/test_card_component.dart';

// -- widget | global
import 'package:app/global/widget/navigation_drawer/navigation_drawer_widget.dart';

// -- models | global
import 'package:app/global/models/test_model.dart';

// -- http
import 'package:http/http.dart' as http;

// -- utils | apis
import 'package:app/utilities/apis/all_apis.dart';

import 'loading/content_loading.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<TestViewModel>> allTests = Future(() => []);
  bool contentLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    allTests = getData();
  }

  Future<List<TestViewModel>> getData() async {
    // loading
    setState(() => contentLoading = true);

    // getting data from network
    final response = await http.get(Uri.parse(apiListAllTests));

    final List<TestViewModel> allTestsData = [];
    final responseStatusCode = response.statusCode;
    final responseBody = response.body;
    final responseBodyData = jsonDecode(responseBody);
    final responseData = responseBodyData['data']['quiz'];

    if (responseStatusCode == 200) {
      if (responseData.isNotEmpty) {
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
                isPremium: singleTestItem['is_premium'] == 'true' ? true : false,
                testImg: '',
              ),
            );
          }

          // pushing data item
          allTestsData
              .add(TestViewModel(type: item['type'], allTests: allTestsOnly));
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    // loading
    setState(() => contentLoading = false);

    return allTestsData;
  }

  // on pull to refresh
  Future<void> onRefresh() async {
    // loading
    setState(() => contentLoading = true);
    final Future<List<TestViewModel>> data = getData();
    // assigning data
    allTests = data;
    // loading
    setState(() => contentLoading = false);
  }

  // on back press
  Future<bool> onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const GlobalNavigationDrawer(),
      appBar: getHomeAppBar(context, scaffoldKey),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: FutureBuilder(
          future: allTests,
          builder: ((context, AsyncSnapshot<List<TestViewModel>> snapshot) {
            if (snapshot.hasData) {
              final List<TestViewModel> data = snapshot.data!;
              return RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 20),
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    final TestViewModel item = data[index];
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
                            final TestSingleModel testItem =
                            twoTestItems[index];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TestCard(
                                  testId: testItem.testId.toString(),
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
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const HomeContentLoading();
                  },
                );
              }
              return const Text(
                'no data found',
                textAlign: TextAlign.center,
              );
            }
          }),
        ),
      ),
    );
  }
}
