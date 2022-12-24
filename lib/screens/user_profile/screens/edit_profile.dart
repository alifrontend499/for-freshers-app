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

class EditProfileScreen extends StatefulWidget {
  final AuthUserModel userDetails;

  const EditProfileScreen({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final String tempUserImg =
      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80';
  final formKey = GlobalKey<FormState>();
  String fieldFulName = '';
  String fieldEmail = '';
  String fieldPhone = '';
  String fieldPassword = '';
  String fieldConfirmPassword = '';
  bool submitBtnLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      fieldFulName = widget.userDetails.userName;
      fieldEmail = widget.userDetails.userEmail;
      fieldPhone = widget.userDetails.userPhone;
    });
  }

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
      appBar: getUserEditProfileAppBar(context),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // child | profile image
                      imageContainer(),
                      const SizedBox(height: 30),

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
                          ],
                        ),
                      ),
                    ],
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
                        : const Text('Save Details'),
                  ),
                ],
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
            child: widget.userDetails.userProfileImg.isNotEmpty
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
        Positioned(
          right: 0,
          bottom: 7,
          child: InkWell(
            onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 15, left: 15, right: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // child | top indicator
                      Container(
                        height: 6,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 15),


                      // child | link
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: globalColorAppPrimary,
                                ),
                                child: const Icon(
                                  Icons.camera,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 15),

                              const Text(
                                'Use Camera',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: .7
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 1),

                      // child | link
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: globalColorAppPrimary,
                                ),
                                child: const Icon(
                                  Icons.perm_media_outlined,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 15),

                              const Text(
                                'Choose from Gallery',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: .7,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
            ),
            highlightColor: Colors.transparent,
            child: Container(
              height: 35,
              width: 35,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: globalColorAppPrimary,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.4),
                    // spreadRadius: 10,
                    offset: const Offset(2, 2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.edit_outlined,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // form fields | user name
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
      initialValue: fieldFulName,
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

  // form fields | phone
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
      initialValue: fieldPhone,
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

  // form fields | email
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
      initialValue: fieldEmail,
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
}
