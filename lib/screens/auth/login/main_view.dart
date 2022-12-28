import 'dart:convert';
import 'package:flutter/material.dart';

// -- consts | global
import 'package:app/global/consts/global_consts.dart';

// -- helpers | navigation drawer
import 'package:app/global/widget/helpers/navigation_drawer_helpers.dart';

// -- package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -- consts | auth
import 'package:app/screens/auth/auth_consts.dart';

// -- consts | screen
import 'package:app/screens/auth/login/login_consts.dart';

// -- helpers | shared preference
import 'package:app/utilities/helpers/shared_preferences_helper.dart';

// -- model
import '../../../utilities/helpers/shared_preferences/model/shared_preferences_auth_model.dart';

// -- styles | screen
import '../styles/auth_styles.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

// -- all routes consts
import 'package:app/utilities/routing/routing_consts.dart';

// http
import 'package:http/http.dart' as http;

// apis
import 'package:app/utilities/apis/all_apis.dart';

const SnackBar snackBarErrorMessage = SnackBar(
  content: Text(AUTH_RESPONSE_USER_NOT_FOUND),
  backgroundColor: Colors.redAccent,
);
const SnackBar snackBarSuccessMessage = SnackBar(
  content: Text(AUTH_RESPONSE_LOGIN_SUCCESS),
  backgroundColor: Colors.greenAccent,
);

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String fieldEmail = 'aman@gmail.com';
  String fieldPassword = '123456';
  bool isPasswordVisible = true;
  bool submitBtnLoading = false;

  void onSubmit() async {
    final form = formKey.currentState;

    // closing the keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    if (form != null && form.validate()) {
      form.save();

      // loading
      setState(() => submitBtnLoading = true);

      try {
        final response = await http.post(
          Uri.parse(apiLogin),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, String>{
              'email': fieldEmail,
              'password': fieldPassword
            },
          ),
        );
        final responseStatusCode = response.statusCode;
        final responseBodyJson = response.body;
        final responseBody = jsonDecode(responseBodyJson);

        if (responseStatusCode == 200) {
          final responseData = responseBody['data'];
          final AuthUserModel authUserToStore = AuthUserModel(
            userToken: responseData['token'],
            userId: responseData['userid'].toString(),
            userName: responseData['name'],
            userEmail: responseData['email'],
            userPhone: responseData['phone'].toString(),
            userProfileImg: responseData['image']
          );
          // setting auth user
          setUserDetailsHelper(authUserToStore);
          // setting user token
          setUserTokenHelper(responseData['token']);

          if (mounted) {
            // showing error
            ScaffoldMessenger.of(context).showSnackBar(snackBarSuccessMessage);

            // setting current page route
            setPageRoute(ref, GLOBAL_ROUTE_ID_HOME);
            // navigation to homepage
            Navigator.pushNamed(context, homepageScreenRoute);
          }
        } else {
          if (mounted) {
            // showing error
            ScaffoldMessenger.of(context).showSnackBar(snackBarErrorMessage);
          }
        }
      } catch (err) {
        print('Error Occurred: $err');
      }

      // loading
      setState(() => submitBtnLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: getLoginAppBar(context),

      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 0,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // child | scroll view
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // child | header
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // child | header
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  // child | head
                                  Text(
                                    SCREEN_HEADING,
                                    // style: stylesPageHeaderHeading,
                                    style: authStylesPageHeading,
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height: 8),

                                  // child | desc
                                  Text(
                                    SCREEN_DESCRIPTION,
                                    // style: stylesPageHeaderDescription,
                                    style: authStylesPageDescription,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),

                              // child | form
                              Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    buildEmailField(),
                                    const SizedBox(height: 20),
                                    buildPasswordField(),
                                    const SizedBox(height: 15),
                                    InkWell(
                                      onTap: () => !submitBtnLoading
                                          ? Navigator.pushNamed(context,
                                              forgotPasswordScreenRoute)
                                          : false,
                                      highlightColor:
                                          globalColorInkWellHighlight,
                                      borderRadius: BorderRadius.circular(5),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 2,
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          SCREEN_FORGOT_PASSWORD,
                                          style: authStylesLinkText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // child | buttons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: authStylesPageButton(submitBtnLoading),
                      onPressed: () => !submitBtnLoading ? onSubmit() : false,
                      child: submitBtnLoading
                          ? const SizedBox(
                              height: 17,
                              width: 17,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(SCREEN_SUBMIT_BUTTON),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () => !submitBtnLoading
                          ? Navigator.pushNamed(context, signUpScreenRoute)
                          : false,
                      highlightColor: globalColorInkWellHighlight,
                      borderRadius: BorderRadius.circular(5),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 8,
                        ),
                        child: Text(
                          AUTH_NO_ACCOUNT,
                          style: authStylesLinkText,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailField() => TextFormField(
        keyboardType: TextInputType.emailAddress,
        style: authStylesInput,
        decoration: InputDecoration(
          hintText: INPUT_HINT_EMAIL,
          border: authStylesInputBorder,
          focusedBorder: authStylesInputBorderFocused,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          // errorStyle: stylesInputError,
        ),
        onSaved: (value) => setState(() => fieldEmail = value!),
        initialValue: fieldEmail,
        validator: (value) {
          const emailPattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
          final regExpEmail = RegExp(emailPattern);

          if (value!.isEmpty) {
            // checking for empty value
            return VALIDATION_ERROR_EMPTY_FIELD;
          } else if (!regExpEmail.hasMatch(value)) {
            // checking for valid email
            return VALIDATION_ERROR_VALID_EMAIL1;
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  Widget buildPasswordField() => TextFormField(
        style: authStylesInput,
        obscureText: isPasswordVisible,
        decoration: InputDecoration(
          hintText: INPUT_HINT_PASSWORD,
          border: authStylesInputBorder,
          focusedBorder: authStylesInputBorderFocused,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          // errorStyle: stylesInputError,
        ),
        initialValue: fieldPassword,
        onSaved: (value) => setState(() => fieldPassword = value!),
        validator: (value) {
          if (value!.isEmpty) {
            // checking for empty value
            return VALIDATION_ERROR_EMPTY_FIELD;
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );
}
