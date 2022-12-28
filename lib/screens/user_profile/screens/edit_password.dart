import 'package:flutter/material.dart';

// -- global |  imports
import 'package:app/global/consts/global_consts.dart';
import 'package:app/global/colors/global_colors.dart';

// -- auth | imports
import 'package:app/screens/auth/auth_consts.dart';
import 'package:app/screens/auth/styles/auth_styles.dart';

// -- screen |  imports
import 'package:app/screens/user_profile/components/app_bar/app_bar_component.dart';

// -- utilities |  imports
import '../../../utilities/helpers/shared_preferences/model/shared_preferences_auth_model.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  String fieldOldPassword = '';
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
      Future.delayed(const Duration(seconds: 1));

      // loading
      setState(() => submitBtnLoading = false);
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
      decoration: InputDecoration(
        hintText: INPUT_HINT_OLD_PASSWORD,
        border: authStylesInputBorder,
        focusedBorder: authStylesInputBorderFocused,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
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
      obscureText: isPasswordVisible,
      decoration: InputDecoration(
        hintText: INPUT_HINT_PASSWORD,
        border: authStylesInputBorder,
        focusedBorder: authStylesInputBorderFocused,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
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
      obscureText: isConfirmPasswordVisible,
      decoration: InputDecoration(
        hintText: INPUT_HINT_CONFIRM_PASSWORD,
        border: authStylesInputBorder,
        focusedBorder: authStylesInputBorderFocused,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
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
        } else if (fieldConfirmPassword != fieldPassword) {
          // checking for empty value
          return VALIDATION_ERROR_VALID_CONFIRM_PASSWORD;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
