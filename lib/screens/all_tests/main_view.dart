import 'package:flutter/material.dart';

// -- widget | global
import 'package:app/global/widget/navigation_drawer/navigation_drawer_widget.dart';

// -- modals | global
import 'package:app/global/modals/test_modal.dart';

// -- components | screen
import 'package:app/screens/all_tests/components/app_bar/app_bar_component.dart';
import 'package:app/screens/home/components/tests_listing/test_card_component.dart';


class AllTestsScreen extends StatefulWidget {
  final String testType;
  final List<TestModal> allTests;

  const AllTestsScreen({
    Key? key,
    required this.testType,
    required this.allTests,
  }) : super(key: key);

  @override
  State<AllTestsScreen> createState() => _AllTestsScreenState();
}

class _AllTestsScreenState extends State<AllTestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAllTestsAppBar(context, widget.testType),
      drawer: const GlobalNavigationDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        physics: const BouncingScrollPhysics(),
        itemCount: widget.allTests.length,
        itemBuilder: (context, index) {
          final item = widget.allTests[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TestCard(
                testType: item.testType,
                testName: item.testName,
                testQuestions: item.testQuestions,
                testDescription: item.testDescription,
                isPremium: item.isPremium,
                testImg: item.testImg,
              ),
              const SizedBox(height: 15),
            ],
          );
        },
      ),
    );
  }
}
