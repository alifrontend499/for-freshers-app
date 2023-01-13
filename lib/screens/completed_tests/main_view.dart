import 'package:app/global/models/test_model.dart';
import 'package:app/screens/completed_tests/components/app_bar/app_bar_component.dart';
import 'package:app/utilities/helpers/file_operations.dart';
import 'package:flutter/material.dart';

// -- widget | global
import 'package:app/global/widget/navigation_drawer/navigation_drawer_widget.dart';

class CompletedTestsScreen extends StatefulWidget {
  const CompletedTestsScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTestsScreen> createState() => _CompletedTestsScreenState();
}

class _CompletedTestsScreenState extends State<CompletedTestsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<CompletedTestModel>> allCompletedTests = Future(() => []);
  bool contentLoading = false;

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
          builder: ((context, AsyncSnapshot<List<CompletedTestModel>> snapshot) {
            if (snapshot.hasData) {
              final List<CompletedTestModel> data = snapshot.data!;
              return RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  itemCount: data.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: ((context, index) {
                    final CompletedTestModel item = data[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.testName),
                        const SizedBox(height: 10),
                      ],
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
