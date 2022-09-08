import 'package:flutter/material.dart';

// -- styles | screen
import 'package:app/screens/intro/styles/intro_styles.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

// -- components | screen
import 'package:app/screens/intro/components/app_bar_component.dart';

// -- package | smooth page indicator
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// -- intro pages
import 'package:app/screens/intro/components/intro_pages/page1_component.dart';
import 'package:app/screens/intro/components/intro_pages/page2_component.dart';
import 'package:app/screens/intro/components/intro_pages/page3_component.dart';

class IntroSliderScreen extends StatefulWidget {
  const IntroSliderScreen({Key? key}) : super(key: key);

  @override
  State<IntroSliderScreen> createState() => _IntroSliderScreenState();
}

class _IntroSliderScreenState extends State<IntroSliderScreen> {
  final PageController pageViewController = PageController();
  final double bottomGap = 100;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    // disposing the page controller
    pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: introAppBar,
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: bottomGap),
        child: Column(
          children: [
            // child | page view
            Expanded(
              child: PageView(
                controller: pageViewController,
                physics: const BouncingScrollPhysics(),
                children: const [
                  // child | page 1
                  IntroPage1(),

                  // child | page 2
                  IntroPage2(),

                  // child | page 3
                  IntroPage3(),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomSheet: Container(
        color: Colors.white,
        height: bottomGap,
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // child | page indicators
            SmoothPageIndicator(
              controller: pageViewController,
              count: 3,
              effect: const WormEffect(
                dotColor: globalColorAppSecondary,
                activeDotColor: globalColorAppPrimary,
                dotHeight: 8,
                dotWidth: 8,
                spacing: 17
              ),
            ),
            const SizedBox(height: 25),

            // child | button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ElevatedButton(
                style: screenStylesBuyNowButton,
                onPressed: () {},
                child: const Text('Buy for USD 660')
              ),
            ),
          ],
        ),
      ),
    );
  }
}
