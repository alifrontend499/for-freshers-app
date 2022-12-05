import 'dart:convert';

//  consts | global
import 'package:app/global/consts/global_consts.dart';

//  package | shared preferences
import 'package:shared_preferences/shared_preferences.dart';

// model | shared preferences
import 'package:app/utilities/helpers/shared_preferences/model/shared_preferences_auth_model.dart';

// auth
Future<bool> isUserLoggedInHelper() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  return sharedPrefs.getBool(SHARED_PREF_KEY_TO_STORE_IS_USER_LOGGED_IN) ??
      false;
}

Future<void> setUserDetailsHelper(AuthUserModel userDetails) async {
  final sharedPrefs = await SharedPreferences.getInstance();
  final encodedUserDetails = jsonEncode(userDetails.toJson());
  // setting user to shared preferences
  sharedPrefs.setString(
      SHARED_PREF_KEY_TO_STORE_USER_DETAILS, encodedUserDetails);
  sharedPrefs.setBool(SHARED_PREF_KEY_TO_STORE_IS_USER_LOGGED_IN, true);
}

Future<AuthUserModel> getUserDetailsHelper() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  final String userDetails =
      sharedPrefs.getString(SHARED_PREF_KEY_TO_STORE_USER_DETAILS)!;
  final userDetailsData = jsonDecode(userDetails);

  return AuthUserModel(
    userName: userDetailsData['userName'],
    userProfileImg: userDetailsData['userProfileImg'],
    userFirstName: userDetailsData['userFirstName'],
    userLastName: userDetailsData['userLastName'],
  );
}
