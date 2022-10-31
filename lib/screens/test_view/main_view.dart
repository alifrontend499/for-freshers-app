import 'package:flutter/material.dart';

// -- component | screen
import 'package:app/screens/test_view/components/app_bar/app_bar_component.dart';

class TestViewScreen extends StatefulWidget {
  final String testId;
  final String testName;

  const TestViewScreen({
    Key? key,
    required this.testId,
    required this.testName,
  }) : super(key: key);

  @override
  State<TestViewScreen> createState() => _TestViewScreenState();
}

class _TestViewScreenState extends State<TestViewScreen> {
  final PageController controller = PageController();
  late List<Widget> children = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    children.addAll([
      const PageMain(),
      const PageMain2(),
    ]);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getTestViewAppBar(context, widget.testName),
      body: PageView(
        controller: controller,
        // physics: const BouncingScrollPhysics(),
        allowImplicitScrolling: false,
        children: [
          ...children
        ],
      ),
    );
  }
}

class PageMain extends StatelessWidget {
  const PageMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Text('Page 1'),
    );
  }
}

class PageMain2 extends StatelessWidget {
  const PageMain2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Text('Page 2'),
    );
  }
}

