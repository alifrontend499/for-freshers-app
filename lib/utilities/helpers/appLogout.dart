import 'package:app/utilities/routing/routing_consts.dart';
import 'package:flutter/material.dart';

//  consts | global
import 'package:app/global/consts/global_consts.dart';

//  package | shared preferences
import 'package:shared_preferences/shared_preferences.dart';

void appLogout(BuildContext context, bool mounted) async {
  // shared preferences
  final sharedPrefs = await SharedPreferences.getInstance();
  await sharedPrefs.remove(SHARED_PREF_KEY_TO_STORE_IS_USER_LOGGED_IN);
  await sharedPrefs.remove(SHARED_PREF_KEY_TO_STORE_USER_TOKEN);
  await sharedPrefs.remove(SHARED_PREF_KEY_TO_STORE_USER_DETAILS);

  // pushing to homepage
  if(mounted) {
    Navigator.pushNamedAndRemoveUntil(context, homepageScreenRoute, (route) => false);
  }
}