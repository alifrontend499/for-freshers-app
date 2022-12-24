import 'package:flutter/material.dart';

// -- packages | imports
import 'package:page_transition/page_transition.dart';

// -- global |  imports
import 'package:app/global/widget/navigation_drawer/navigation_drawer_widget.dart';
import 'package:app/global/colors/global_colors.dart';

// -- screen |  imports
import 'package:app/screens/user_profile/components/app_bar/app_bar_component.dart';
import 'package:app/screens/user_profile/screens/edit_profile.dart';

// -- utilities |  imports
import '../../../utilities/helpers/shared_preferences/model/shared_preferences_auth_model.dart';
import 'package:app/utilities/helpers/shared_preferences_helper.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final String tempUserImg =
      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80';
  late AuthUserModel userDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getting details
    getUserDetails();
  }

  // Function
  void getUserDetails() async {
    AuthUserModel userDetailsRaw = await getUserDetailsHelper();
    setState(() => userDetails = userDetailsRaw);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const GlobalNavigationDrawer(),
      appBar: getUserProfileAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // child | profile image
              imageContainer(),
              const SizedBox(height: 20),

              // child | edit profile button
              editProfileButton(),
              const SizedBox(height: 15),

              // child | profile name
              profileItemContainer(
                'NAME',
                userDetails.userName,
                Icons.person,
              ),

              // child | profile email
              profileItemContainer(
                'EMAIL',
                userDetails.userEmail,
                Icons.alternate_email_outlined,
              ),

              // child | profile phone
              profileItemContainer(
                'PHONE',
                userDetails.userPhone,
                Icons.local_phone_sharp,
              ),

              // child | profile phone
              profileItemContainer(
                'Password',
                '**********',
                Icons.password,
                isPasswordField: true,
              ),

              // child | profile phone
              profileItemContainer(
                'PREMIUM USER',
                'Not a premium user',
                Icons.star,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // profile content containers
  Widget imageContainer() {
    return Stack(
      children: [
        // child | image
        SizedBox(
          height: 120,
          width: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: userDetails.userProfileImg.isNotEmpty
                // ? Image.network(userDetails.userProfileImg)
                ? Image.network(tempUserImg)
                : Container(
                    color: Colors.grey.withOpacity(.4),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
          ),
        ),

        // child | icon
        // Positioned(
        //   right: 0,
        //   bottom: 7,
        //   child: InkWell(
        //     onTap: () {},
        //     child: Container(
        //       height: 35,
        //       width: 35,
        //       padding: const EdgeInsets.all(3),
        //       decoration: BoxDecoration(
        //         color: globalColorAppPrimary,
        //         borderRadius: BorderRadius.circular(50),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.black.withOpacity(.4),
        //             // spreadRadius: 10,
        //             offset: const Offset(2, 2),
        //             blurRadius: 5,
        //           ),
        //         ],
        //       ),
        //       child: const Icon(
        //         Icons.edit_outlined,
        //         size: 18,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // profile edit button
  Widget editProfileButton() {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).push(
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: EditProfileScreen(userDetails: userDetails),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: globalColorAppPrimary,
        padding: const EdgeInsets.only(
          top: 9,
          bottom: 7,
          left: 24,
          right: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text('Edit Profile'),
    );
  }

  // profile item containers
  Widget profileItemContainer(
    String itemName,
    String itemValue,
    IconData icon, {
    bool isPasswordField = false,
  }) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 15,
          left: 20,
          right: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // child | right part
            Container(
              height: 37,
              width: 37,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: globalColorAppPrimary,
              ),
              child: Icon(
                icon,
                size: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 15),

            // child | left part
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    itemName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    itemValue,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            // child | password content
            if (isPasswordField) ...[
              Container(
                height: 37,
                width: 37,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.withOpacity(.5),
                ),
                child: const Icon(
                  Icons.edit,
                  size: 18,
                  color: globalColorAppPrimary,
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
