import 'package:flutter/material.dart';

// -- drawer | styles
import 'package:app/global/widget/navigation_drawer/styles/navigation_drawer_styles.dart';

// -- global | colors
import 'package:app/global/colors/global_colors.dart';

// Then close the drawer
// Navigator.pop(context);

final globalScaffoldKey = GlobalKey<ScaffoldState>();
const double defaultGap = 15.0;

class GlobalNavigationDrawer extends StatelessWidget {
  const GlobalNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // child | top bar
          Padding(
            padding: const EdgeInsets.only(
              top: 45,
              bottom: 8,
              left: defaultGap - 5,
              right: defaultGap - 5,
            ),
            child: InkWell(
              onTap: () {},
              highlightColor: globalColorInkWellHighlight,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // child | user image/icon
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: globalColorAppPrimary,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 15),

                    // child | user details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Sign In',
                          style: ndStylesTopBarHead,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'View your account',
                          style: ndStylesTopBarDesc,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          // SizedBox(height: 2),
          // Divider(
          //   color: globalColorAppPrimary,
          // ),
          SizedBox(height: 2),

          // child | navigation links
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: defaultGap,
                  right: defaultGap,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // child | link

                    navigationLink(Icons.home, 'Home'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navigationLink(
    IconData linkIcon,
    String linkText,
  ) =>
      InkWell(
        onTap: () {},
        highlightColor: globalColorAppPrimary,

        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
          child: Row(
            children: [
              Icon(linkIcon),
              const SizedBox(
                width: 10,
              ),
              Text(linkText),
            ],
          ),
        ),
      );
}
