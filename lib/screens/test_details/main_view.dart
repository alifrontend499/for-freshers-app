import 'package:flutter/material.dart';

// -- components | screen
import 'package:app/screens/auth/login/components/app_bar/app_bar_component.dart';

class TestDetailsScreen extends StatefulWidget {
  const TestDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TestDetailsScreen> createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends State<TestDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getLoginAppBar(context),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // child | scroll view
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // child | header
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ],
                  ),
                ),
              ),

              // child | buttons
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
