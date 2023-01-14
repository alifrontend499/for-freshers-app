import 'package:app/global/colors/global_colors.dart';
import 'package:app/global/models/test_model.dart';
import 'package:app/screens/completed_tests/components/app_bar/app_bar_component.dart';
import 'package:app/screens/test_view/pages/test_summary/test_summary_view.dart';
import 'package:app/utilities/helpers/file_operations.dart';
import 'package:app/utilities/helpers/helpers.dart';
import 'package:flutter/material.dart';

// -- widget | global
import 'package:app/global/widget/navigation_drawer/navigation_drawer_widget.dart';
import 'package:page_transition/page_transition.dart';

class CompletedTestsScreen extends StatefulWidget {
  const CompletedTestsScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTestsScreen> createState() => _CompletedTestsScreenState();
}

class _CompletedTestsScreenState extends State<CompletedTestsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<CompletedTestModel>> allCompletedTests = Future(() => []);
  bool contentLoading = false;
  final String tempCardImg =
      'https://cdn.pixabay.com/photo/2014/06/03/19/38/board-361516__340.jpg';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    allCompletedTests = getCompletedTestsData();
  }

  // getting tests data
  Future<List<CompletedTestModel>> getCompletedTestsData() async {
    final List<CompletedTestModel> completedTests =
        await getCompletedTestsHelper();
    print('completedTests $completedTests');
    return completedTests;
  }

  // on pull to refresh
  Future<void> onRefresh() async {
    // loading
    setState(() => contentLoading = true);
    final Future<List<CompletedTestModel>> completedTests =
        getCompletedTestsData();
    // assigning data
    allCompletedTests = completedTests;
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
      appBar: getCompletedTestsAppBar(context, scaffoldKey),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: FutureBuilder(
          future: allCompletedTests,
          builder:
              ((context, AsyncSnapshot<List<CompletedTestModel>> snapshot) {
            if (snapshot.hasData) {
              final List<CompletedTestModel> data = snapshot.data!;
              return RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    final CompletedTestModel item = data[index];
                    return RefreshIndicator(
                      onRefresh: onRefresh,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: TestSummaryView(
                                  completedTestModal: item,
                                ),
                              ),
                            ),
                            splashColor: Colors.transparent,
                            highlightColor: globalColorInkWellHighlight,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                // color: Colors.white,
                                // image: DecorationImage(
                                //   // image: NetworkImage(testImg),
                                //   image: NetworkImage(item.testImg.isNotEmpty ? item.testImg : tempCardImg),
                                //   fit: BoxFit.cover,
                                //   colorFilter: ColorFilter.mode(
                                //     Colors.white.withOpacity(0.2),
                                //     BlendMode.modulate,
                                //   ),
                                // ),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black.withOpacity(0.1),
                                //     blurRadius: 4.0,
                                //     offset: const Offset(2, 2),
                                //   ),
                                // ],
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  // -- child | content
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // child | heading
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              getCapitalizeTextHelper(
                                                item.testName,
                                              ),
                                              style: const TextStyle(
                                                color: globalColorAppPrimary,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            getDateHelper(
                                              item.completedOn,
                                            ),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),

                                      // child | description
                                      Text(
                                        item.testDescription,
                                        style: const TextStyle(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 15),

                                      // child | questions data
                                      Row(
                                        children: [
                                          // child | total questions
                                          Text(
                                            "${item.testQuestions} Questions Total",
                                            style: const TextStyle(
                                              color: globalColorAppPrimary,
                                              // fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(width: 10),

                                          // child | right questions
                                          Text(
                                            "${item.rightAnswersCount} Right",
                                            style: const TextStyle(
                                              color: Colors.green,
                                              // fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(width: 10),

                                          // child | wrong questions
                                          Text(
                                            "${int.parse(item.testQuestions) - item.rightAnswersCount} Wrong",
                                            style: const TextStyle(
                                              color: Colors.redAccent,
                                              // fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    );
                  }),
                ),
              );
            } else {
              if (contentLoading) {
                // return ListView.builder(
                //   itemCount: 7,
                //   itemBuilder: (context, index) {
                //     return const Text('Loading...');
                //   },
                // );
                return const Text('Loading...');
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
