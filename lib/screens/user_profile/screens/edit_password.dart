import 'dart:convert';
import 'package:app/utilities/helpers/shared_preferences_helper.dart';
import 'package:flutter/material.dart';

// -- auth | imports
import 'package:app/screens/auth/auth_consts.dart';
import 'package:app/screens/auth/styles/auth_styles.dart';

// -- screen |  imports
import 'package:app/screens/user_profile/components/app_bar/app_bar_component.dart';

// http
import 'package:http/http.dart' as http;

// apis
import 'package:app/utilities/apis/all_apis.dart';

// snackbar - messages
SnackBar snackBarErrorMessage(String msg) => SnackBar(
  content: Text(msg),
  backgroundColor: Colors.redAccent,
);

SnackBar snackBarSuccessMessage(String msg) => SnackBar(
      content: Text(msg),
      backgroundColor: Colors.greenAccent,
    );

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  String fieldOldPassword = '';
  String fieldNewPassword = '';
  String fieldConfirmNewPassword = '';
  bool isOldPasswordVisible = true;
  bool isNewPasswordVisible = true;
  bool isConfirmNewPasswordVisible = true;
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
        // getting current user details
        final String userToken = await getUserTokenHelper();
        final response = await http.post(
          Uri.parse(apiChangePassword),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $userToken'
          },
          body: jsonEncode(
            <String, String>{
              'old_password': fieldOldPassword,
              'new_password': fieldNewPassword,
            },
          ),
        );
        final responseStatusCode = response.statusCode;
        final responseBodyJson = response.body;
        final responseBody = jsonDecode(responseBodyJson);

        if (responseStatusCode == 200) {
          if (mounted) {
            // showing message
            ScaffoldMessenger.of(context).showSnackBar(snackBarSuccessMessage(AUTH_RESPONSE_PASSWORD_CHANGED_SUCCESS));

            // redirecting back
            Navigator.pop(context);
          }
        } else {
          // showing message
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(snackBarErrorMessage(responseBody['message']));
          }
        }
      } catch (err) {
        print('Error Occurred: $err');
      }

      // loading
      setState(() {
        submitBtnLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getUserEditPasswordAppBar(context),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Column(
            children: [
              // child | top part
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        buildOldPasswordField(),
                        const SizedBox(height: 20),
                        buildPasswordField(),
                        const SizedBox(height: 20),
                        buildConfirmPasswordField(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),

              // child | button
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
                        : const Text('Reset Password'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // form fields | password
  Widget buildOldPasswordField() {
    return TextFormField(
      style: authStylesInput,
      obscureText: isOldPasswordVisible,
      decoration: InputDecoration(
        hintText: INPUT_HINT_OLD_PASSWORD,
        border: authStylesInputBorder,
        focusedBorder: authStylesInputBorderFocused,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isOldPasswordVisible = !isOldPasswordVisible;
            });
          },
          icon: isNewPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      ),
      onChanged: (value) => setState(() => fieldOldPassword = value!),
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

  // form fields | password
  Widget buildPasswordField() {
    return TextFormField(
      style: authStylesInput,
      obscureText: isNewPasswordVisible,
      decoration: InputDecoration(
        hintText: INPUT_HINT_NEW_PASSWORD,
        border: authStylesInputBorder,
        focusedBorder: authStylesInputBorderFocused,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isNewPasswordVisible = !isNewPasswordVisible;
            });
          },
          icon: isNewPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      ),
      onChanged: (value) => setState(() => fieldNewPassword = value!),
      validator: (value) {
        if (value!.isEmpty) {
          // checking for empty value
          return VALIDATION_ERROR_EMPTY_FIELD;
        } else if (fieldNewPassword.length < 6) {
          // checking for empty value
          return VALIDATION_ERROR_6_CHARACTERS_LONG;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  // form fields | confirm password
  Widget buildConfirmPasswordField() {
    return TextFormField(
      style: authStylesInput,
      obscureText: isConfirmNewPasswordVisible,
      decoration: InputDecoration(
        hintText: INPUT_HINT_CONFIRM_NEW_PASSWORD,
        border: authStylesInputBorder,
        focusedBorder: authStylesInputBorderFocused,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isConfirmNewPasswordVisible = !isConfirmNewPasswordVisible;
            });
          },
          icon: isConfirmNewPasswordVisible
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      ),
      onChanged: (value) => setState(() => fieldConfirmNewPassword = value!),
      validator: (value) {
        if (value!.isEmpty) {
          // checking for empty value
          return VALIDATION_ERROR_EMPTY_FIELD;
        } else if (fieldConfirmNewPassword.length < 6) {
          // checking for empty value
          return VALIDATION_ERROR_6_CHARACTERS_LONG;
        } else if (fieldConfirmNewPassword != fieldNewPassword) {
          // checking for empty value
          return VALIDATION_ERROR_VALID_CONFIRM_PASSWORD;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
