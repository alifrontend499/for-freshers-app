import 'package:flutter/material.dart';

// -- styles | screen
import 'package:app/screens/intro/styles/intro_styles.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // child | image
              Image.asset(
                'assets/images/intro-screen/tempimg.png',
                height: 150,
              ),
              const SizedBox(height: 40),

              // child | heading
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Pass the test with For Freshers',
                  style: screenStylesPageHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),

              // child | heading
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                  style: screenStylesPageDescription,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
