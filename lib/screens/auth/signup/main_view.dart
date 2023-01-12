import 'dart:convert';
import 'package:flutter/material.dart';

// -- consts | global
import 'package:app/global/consts/global_consts.dart';

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

// http
import 'package:http/http.dart' as http;

// apis
import 'package:app/utilities/apis/all_apis.dart';

const SnackBar snackBarErrorMessage = SnackBar(
  content: Text(GLOBAL_UNKNOWN_ERROR_OCCURRED),
  backgroundColor: Colors.redAccent,
);
const SnackBar snackBarSuccessMessage = SnackBar(
  content: Text(AUTH_RESPONSE_SIGNUP_SUCCESS),
  backgroundColor: Colors.greenAccent,
);

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  String fieldFulName = '';
  String fieldEmail = '';
  String fieldPhone = '';
  String fieldPassword = '';
  String fieldConfirmPassword = '';
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  bool submitBtnLoading = false;

  void onSubmit() async {
    final form = formKey.currentState;

    // closing the keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    if (form != null && form.validate()) {
      form.save();

      // loading
      setState(() => submitBtnLoading = true);

      // network request
      try {
        final response = await http.post(
          Uri.parse(apiRegister),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, String>{
              'email': fieldEmail,
              'phone': fieldEmail,
              'password': fieldPassword,
              'name': fieldFulName,
            },
          ),
        );
        final responseStatusCode = response.statusCode;
        final responseBody = response.body;

        if (responseStatusCode == 200) {
          if (mounted) {
            // showing message
            ScaffoldMessenger.of(context).showSnackBar(snackBarSuccessMessage);

            // navigation to homepage
            Navigator.pushNamed(context, loginScreenRoute);
          }
        } else {
          // showing message
          if (mounted) {
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
                                    buildFullNameField(),
                                    const SizedBox(height: 20),
                                    buildEmailField(),
                                    const SizedBox(height: 20),
                                    buildPhoneField(),
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
                      onTap: () =>
                          Navigator.pushNamed(context, loginScreenRoute),
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

  Widget buildFullNameField() {
    return TextFormField(
      style: authStylesInput,
      decoration: InputDecoration(
        hintText: INPUT_HINT_FULL_NAME,
        border: authStylesInputBorder,
        focusedBorder: authStylesInputBorderFocused,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        // errorStyle: stylesInputError,
      ),
      onChanged: (value) => setState(() => fieldFulName = value!),
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

  Widget buildPhoneField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      style: authStylesInput,
      decoration: InputDecoration(
        hintText: INPUT_HINT_PHONE,
        border: authStylesInputBorder,
        focusedBorder: authStylesInputBorderFocused,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        // errorStyle: stylesInputError,
      ),
      onChanged: (value) => setState(() => fieldPhone = value!),
      validator: (value) {
        // final RegExp pattern = RegExp(r"^(\+0?1\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$");
        if (value!.isEmpty) {
          // checking for empty value
          return VALIDATION_ERROR_EMPTY_FIELD;
        } else if (value.length != 10) {
          return VALIDATION_ERROR_VALID_PHONE;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildEmailField() {
    return TextFormField(
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
      onChanged: (value) => setState(() => fieldEmail = value!),
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
  }

  Widget buildPasswordField() {
    return TextFormField(
      style: authStylesInput,
      obscureText: isPasswordVisible,
      decoration: InputDecoration(
        hintText: INPUT_HINT_PASSWORD,
        border: authStylesInputBorder,
        focusedBorder: authStylesInputBorderFocused,
        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
          icon: isPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      ),
      onChanged: (value) => setState(() => fieldPassword = value!),
      validator: (value) {
        if (value!.isEmpty) {
          // checking for empty value
          return VALIDATION_ERROR_EMPTY_FIELD;
        } else if (fieldPassword.length < 6) {
          // checking for empty value
          return VALIDATION_ERROR_6_CHARACTERS_LONG;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildConfirmPasswordField() {
    return TextFormField(
      style: authStylesInput,
      obscureText: isConfirmPasswordVisible,
      decoration: InputDecoration(
        hintText: INPUT_HINT_CONFIRM_PASSWORD,
        border: authStylesInputBorder,
        focusedBorder: authStylesInputBorderFocused,
        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isConfirmPasswordVisible = !isConfirmPasswordVisible;
            });
          },
          icon: isConfirmPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      ),
      onChanged: (value) => setState(() => fieldConfirmPassword = value!),
      validator: (value) {
        if (value!.isEmpty) {
          // checking for empty value
          return VALIDATION_ERROR_EMPTY_FIELD;
        } else if (fieldConfirmPassword.length < 6) {
          // checking for empty value
          return VALIDATION_ERROR_6_CHARACTERS_LONG;
        } else if(fieldConfirmPassword != fieldPassword) {
          // checking for empty value
          return VALIDATION_ERROR_VALID_CONFIRM_PASSWORD;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
