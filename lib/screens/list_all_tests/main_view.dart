import 'dart:convert';

import 'package:flutter/material.dart';

// -- global | widget
import 'package:app/global/widget/navigation_drawer/navigation_drawer_widget.dart';

// -- global | models
import 'package:app/global/models/test_model.dart';

// -- screen | components
import 'package:app/screens/list_all_tests/components/app_bar/app_bar_component.dart';
import 'package:app/screens/list_all_tests/components/tests_listing/tests_listing_header_component.dart';
import 'package:app/screens/list_all_tests/components/tests_listing/test_card_component.dart';

// -- screen | loading
import 'package:app/screens/list_all_tests/loading/content_loading.dart';

// -- http
import 'package:http/http.dart' as http;

// -- utils | apis
import 'package:app/utilities/apis/all_apis.dart';

class ListAllTestsScreen extends StatefulWidget {
  const ListAllTestsScreen({Key? key}) : super(key: key);

  @override
  State<ListAllTestsScreen> createState() => _ListAllTestsScreenState();
}

class _ListAllTestsScreenState extends State<ListAllTestsScreen> {
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
    final response = await http.get(Uri.parse(apiAllTypeTests));

    final List<TestViewModel> allTestsData = [];

    final responseStatusCode = response.statusCode;
    final responseBody = response.body;
    final responseBodyData = jsonDecode(responseBody);
    final responseData = responseBodyData['data']['quiz'];

    if (responseStatusCode == 200) {
      if (responseData.isNotEmpty) {
        for (final item in responseData) {
          final List<TestSingleModel> allTestsOnly = [];

          allTestsOnly.add(
            TestSingleModel(
              testId: item['id'],
              testType: item['type'],
              testName: item['name'],
              testQuestions: item['total_questions'].toString(),
              testDescription: item['text'],
              isPremium: item['is_premium'] == 'true' ? true : false,
              testImg: '',
            ),
          );

          // pushing data item
          allTestsData.add(TestViewModel(type: item['type'], allTests: allTestsOnly));
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
    // assigning data
    allTests = getData();
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
      appBar: getListAllTestsAppBar(context, scaffoldKey),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    final TestViewModel item = data[index];
                    final List<TestSingleModel> allTestsData = item.allTests;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // -- child | content
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allTestsData.length,
                            itemBuilder: ((context, index) {
                              final TestSingleModel testItem = allTestsData[index];
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
                                ],
                              );
                            }),
                          ),
                          const SizedBox(height: 20),
                        ]);
                  }),
                ),
              );
            } else {
              if (contentLoading) {
                return ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return const ListAllTestsContentLoading();
                  },
                );
              } else {
                return const Text(
                  'no data found',
                  textAlign: TextAlign.center,
                );
              }
            }
          }),
        ),
      ),
    );
  }
}
