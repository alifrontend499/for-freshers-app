import 'package:app/utilities/routing/routing_consts.dart';
import 'package:flutter/material.dart';

// -- styles | screen
import '../styles/auth_styles.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String fieldEmail = '';
  String fieldPassword = '';

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
                                    'Sign In',
                                    // style: stylesPageHeaderHeading,
                                    style: authStylesPageHeading,
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height: 8),

                                  // child | desc
                                  Text(
                                    'Login to your account now',
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
                                      onTap: () {},
                                      highlightColor:
                                          globalColorInkWellHighlight,
                                      borderRadius: BorderRadius.circular(5),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 2,
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          'Forgot Password?',
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
                      style: authStylesPageButton,
                      onPressed: () {},
                      child: const Text('SIGN IN'),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, signUpScreenRoute),
                      highlightColor: globalColorInkWellHighlight,
                      borderRadius: BorderRadius.circular(5),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 8,
                        ),
                        child: Text(
                          'Create a new account',
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
          hintText: "Enter Email",
          border: authStylesInputBorder,
          focusedBorder: authStylesInputBorderFocused,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          // errorStyle: stylesInputError,
        ),
        onSaved: (value) => setState(() => fieldEmail = value!),
        validator: (value) {
          const emailPattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
          final regExpEmail = RegExp(emailPattern);

          if (value!.isEmpty) {
            // checking for empty value
            return "The field can not be empty";
          } else if (!regExpEmail.hasMatch(value)) {
            // checking for valid email
            return "Email should be valid";
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  Widget buildPasswordField() => TextFormField(
        style: authStylesInput,
        decoration: InputDecoration(
          hintText: "Enter Password",
          border: authStylesInputBorder,
          focusedBorder: authStylesInputBorderFocused,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          // errorStyle: stylesInputError,
        ),
        onSaved: (value) => setState(() => fieldPassword = value!),
        validator: (value) {
          if (value!.isEmpty) {
            // checking for empty value
            return "The field can not be empty";
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );
}
