import 'dart:convert';

//  consts | global
import 'package:app/global/consts/global_consts.dart';

//  package | shared preferences
import 'package:shared_preferences/shared_preferences.dart';

// -- models | global
import 'package:app/global/models/test_model.dart';

// model | shared preferences
import 'package:app/utilities/helpers/shared_preferences/model/shared_preferences_auth_model.dart';

// functions | AUTH
// getter | is user logged
Future<bool> isUserLoggedInHelper() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  return sharedPrefs.getBool(SHARED_PREF_KEY_TO_STORE_IS_USER_LOGGED_IN) ??
      false;
}
// setter | user details
Future<void> setUserDetailsHelper(AuthUserModel userDetails) async {
  final sharedPrefs = await SharedPreferences.getInstance();
  final encodedUserDetails = jsonEncode(userDetails.toJson());
  // setting user to shared preferences
  sharedPrefs.setString(
      SHARED_PREF_KEY_TO_STORE_USER_DETAILS, encodedUserDetails);
  sharedPrefs.setBool(SHARED_PREF_KEY_TO_STORE_IS_USER_LOGGED_IN, true);
}
// getter | user details
Future<AuthUserModel> getUserDetailsHelper() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  final String userDetails =
      sharedPrefs.getString(SHARED_PREF_KEY_TO_STORE_USER_DETAILS)!;
  final userDetailsData = jsonDecode(userDetails);

  return AuthUserModel(
    userToken: userDetailsData['userToken'],
    userId: userDetailsData['userId'],
    userName: userDetailsData['userName'],
    userEmail: userDetailsData['userEmail'],
    userProfileImg: userDetailsData['userProfileImg'],
    userPhone: userDetailsData['userPhone']
  );
}
// setter | user details
Future<void> setUserTokenHelper(String userToken) async {
  final sharedPrefs = await SharedPreferences.getInstance();
  // setting user to shared preferences
  sharedPrefs.setString(SHARED_PREF_KEY_TO_STORE_USER_TOKEN, userToken);
}
// getter | user details
Future<String> getUserTokenHelper() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  // setting user to shared preferences
  final userToken = sharedPrefs.getString(SHARED_PREF_KEY_TO_STORE_USER_TOKEN)!;
  return userToken;
}