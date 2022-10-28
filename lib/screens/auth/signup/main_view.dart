import 'package:flutter/material.dart';

// -- consts | auth
import 'package:app/screens/auth/auth_consts.dart';
// -- consts | screen
import 'package:app/screens/auth/signup/signup_consts.dart';

// -- styles | screen
import '../styles/auth_styles.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

// -- all routes consts
import 'package:app/utilities/routing/routing_consts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  String fieldFirstName = '';
  String fieldLastName = '';
  String fieldEmail = '';
  String fieldPassword = '';
  String fieldConfirmPassword = '';
  bool submitBtnLoading = true;

  void onSubmit() async {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();

      // closing the keyboard
      FocusManager.instance.primaryFocus?.unfocus();

      // showing loading
      setState(() => submitBtnLoading = true);

      await Future.delayed(const Duration(seconds: 2));

      // hiding loading
      setState(() => submitBtnLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    buildFirstNameField(),
                                    const SizedBox(height: 20),

                                    buildLastNameField(),
                                    const SizedBox(height: 20),

                                    buildEmailField(),
                                    const SizedBox(height: 20),

                                    buildPasswordField(),
                                    const SizedBox(height: 20),

                                    buildConfirmPasswordField(),
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
                      onPressed: () {},
                      child: const Text(SCREEN_SUBMIT_BUTTON),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, loginScreenRoute),
                      highlightColor: globalColorInkWellHighlight,
                      borderRadius: BorderRadius.circular(5),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 8,
                        ),
                        child: Text(
                          AUTH_ALREADY_HAVE_AN_ACCOUNT,
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

  Widget buildFirstNameField() => TextFormField(
    style: authStylesInput,
    decoration: InputDecoration(
      hintText: INPUT_HINT_FIRST_NAME,
      border: authStylesInputBorder,
      focusedBorder: authStylesInputBorderFocused,
      contentPadding:
      const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
      // errorStyle: stylesInputError,
    ),
    onSaved: (value) => setState(() => fieldFirstName = value!),
    validator: (value) {
      if (value!.isEmpty) {
        // checking for empty value
        return VALIDATION_ERROR_EMPTY_FIELD;
      }
      return null;
    },
    autovalidateMode: AutovalidateMode.onUserInteraction,
  );

  Widget buildLastNameField() => TextFormField(
    style: authStylesInput,
    decoration: InputDecoration(
      hintText: INPUT_HINT_LAST_NAME,
      border: authStylesInputBorder,
      focusedBorder: authStylesInputBorderFocused,
      contentPadding:
      const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
      // errorStyle: stylesInputError,
    ),
    onSaved: (value) => setState(() => fieldLastName = value!),
    validator: (value) {
      if (value!.isEmpty) {
        // checking for empty value
        return VALIDATION_ERROR_EMPTY_FIELD;
      }
      return null;
    },
    autovalidateMode: AutovalidateMode.onUserInteraction,
  );



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
        decoration: InputDecoration(
          hintText: INPUT_HINT_PASSWORD,
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
            return VALIDATION_ERROR_EMPTY_FIELD;
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  Widget buildConfirmPasswordField() => TextFormField(
    style: authStylesInput,
    decoration: InputDecoration(
      hintText: INPUT_HINT_CONFIRM_PASSWORD,
      border: authStylesInputBorder,
      focusedBorder: authStylesInputBorderFocused,
      contentPadding:
      const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
      // errorStyle: stylesInputError,
    ),
    onSaved: (value) => setState(() => fieldConfirmPassword = value!),
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
