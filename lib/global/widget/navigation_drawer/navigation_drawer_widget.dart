import 'package:app/screens/auth/auth_consts.dart';
import 'package:flutter/material.dart';

// screen | consts
import 'package:app/global/widget/navigation_drawer/navigation_drawer_consts.dart';

// helpers
import 'package:app/utilities/helpers/shared_preferences_helper.dart';

// -- drawer | styles
import 'package:app/global/widget/navigation_drawer/styles/navigation_drawer_styles.dart';

// -- global | colors
import 'package:app/global/colors/global_colors.dart';

// -- all routes consts
import 'package:app/utilities/routing/routing_consts.dart';

// model
import '../../../utilities/helpers/shared_preferences/model/shared_preferences_auth_model.dart';

// helpers
import 'package:app/utilities/helpers/appLogout.dart';
import 'package:app/utilities/helpers/helpers.dart';

final globalScaffoldKey = GlobalKey<ScaffoldState>();
const double defaultGap = 15.0;
const double nbLinkBottomGap = 8.0;

// snackbar | success
const SnackBar snackBarSuccessMessage = SnackBar(
  content: Text(SNACK_MSG_LOGOUT_SUCCESS),
  backgroundColor: Colors.greenAccent,
);

class GlobalNavigationDrawer extends StatefulWidget {
  const GlobalNavigationDrawer({Key? key}) : super(key: key);

  @override
  State<GlobalNavigationDrawer> createState() => _GlobalNavigationDrawerState();
}

class _GlobalNavigationDrawerState extends State<GlobalNavigationDrawer> {
  bool isUserLoggedIn = false;
  late AuthUserModel userDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checking user
    getUserDetails();
  }

  // Function
  void getUserDetails() async {
    bool isLoggedIn = await isUserLoggedInHelper();
    AuthUserModel userDetailsRaw = await getUserDetailsHelper();
    // setting value
    setState(() {
      isUserLoggedIn = isLoggedIn;
      userDetails = userDetailsRaw;
    });
  }

  // log user out
  void logUserOut() async {
    // closing the dialog
    Navigator.pop(context);
    // closing the left drawer
    Navigator.of(context).pop();

    // logging user out
    appLogout();

    // hide all existing snack bars
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    // showing snack bar
    ScaffoldMessenger.of(context).showSnackBar(snackBarSuccessMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // child | top bar
          getTopBar(),

          // SizedBox(height: 2),
          // Divider(
          //   color: globalColorAppPrimary,
          // ),
          const SizedBox(height: 10),

          // child | navigation links
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: defaultGap - 5,
                right: defaultGap - 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // child | links top view
                  Expanded(
                    child: Column(
                      children: [
                        // child | link
                        navigationLink(
                          Icons.home_outlined,
                          'Home',
                          isActive: true,
                        ),
                        const SizedBox(height: nbLinkBottomGap),

                        // child | link
                        navigationLink(
                          Icons.lightbulb_circle_outlined,
                          'All Tests',
                        ),
                        const SizedBox(height: nbLinkBottomGap),

                        // child | link
                        navigationLink(
                          Icons.check_circle_outlined,
                          'Completed Tests',
                        ),
                        const SizedBox(height: nbLinkBottomGap),

                        // child | link
                        navigationLink(
                          Icons.timelapse_sharp,
                          'Pending Tests',
                        ),
                        const SizedBox(height: nbLinkBottomGap),

                        // child | link
                        navigationLink(
                          Icons.star_outline,
                          'Get Premium',
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (isUserLoggedIn) ...[
            Padding(
              padding: const EdgeInsets.only(
                left: defaultGap - 5,
                right: defaultGap - 5,
              ),
              child: navigationLinkLogout(),
            ),
            const SizedBox(height: defaultGap - 5),
          ],
        ],
      ),
    );
  }

  // navigation link
  Widget navigationLink(
    IconData linkIcon,
    String linkText, {
    double iconSize = 22,
    bool isActive = false,
  }) {
    return InkWell(
      onTap: () {},
      highlightColor: globalColorInkWellHighlight,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? globalColorAppPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 12,
          top: 12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // child | icon
            Container(
              width: 35,
              // color: Colors.red,
              alignment: Alignment.centerLeft,
              child: Icon(
                linkIcon,
                size: iconSize,
                color: isActive ? Colors.white : Colors.black,
              ),
            ),

            // child | text
            Text(
              linkText,
              style: ndStylesLinkText(isActive: isActive),
            ),
          ],
        ),
      ),
    );
  }

  // navigation link | logout
  Widget navigationLinkLogout() {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            titlePadding: const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 10),
            contentPadding: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
            actionsPadding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 10),
            title: Text(
              "Logging out",
              style: logoutDialogTitleStyles,
            ),
            content: Text(
              'Are you sure you want to logout?',
              style: logoutDialogContentStyles,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: logoutDialogBtnCancel,
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => logUserOut(),
                      style: logoutDialogBtnOk,
                      child: const Text('Ok'),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
      highlightColor: globalColorInkWellHighlight,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 12,
          top: 12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // child | icon
            Container(
              width: 35,
              // color: Colors.red,
              alignment: Alignment.centerLeft,
              child: const Icon(
                Icons.logout_outlined,
                size: 22,
                color: Colors.black,
              ),
            ),

            // child | text
            Text(
              'Logout',
              style: ndStylesLinkText(isActive: false),
            ),
          ],
        ),
      ),
    );
  }

  // top bar
  Widget getTopBar() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 45,
        bottom: 8,
        left: defaultGap - 5,
        right: defaultGap - 5,
      ),
      child: InkWell(
        onTap: () {
          // closing drawer
          Navigator.pop(context);

          if (isUserLoggedIn) {
            // if user logged in

          } else {
            // navigating
            Navigator.pushNamed(context, loginScreenRoute);
          }
        },
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
                child: isUserLoggedIn
                    ? Image.network(userDetails.userProfileImg)
                    : const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
              ),
              const SizedBox(width: 15),

              // child | user details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isUserLoggedIn
                        ? "${getCapitalizeTextHelper(userDetails.userFirstName)} ${getCapitalizeTextHelper(userDetails.userLastName)}"
                        : SCREEN_SIGN_IN,
                    style: ndStylesTopBarHead,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                    SCREEN_VIEW_ACCOUNT,
                    style: ndStylesTopBarDesc,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
