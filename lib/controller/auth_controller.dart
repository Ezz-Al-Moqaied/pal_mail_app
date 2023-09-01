import 'package:flutter/material.dart';
import 'package:pal_mail_app/services/helper/api_base_helper.dart';
import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/models/user_model.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';
import 'package:pal_mail_app/widgets/flutterToastWidget.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';

import '../screens/home_screen.dart';

class AuthHelper {
  AuthHelper._();

  static final AuthHelper instance = AuthHelper._();

  Future<void> login(Map<String, String> body, BuildContext context) async {
    final ApiBaseHelper _helper = ApiBaseHelper();
    try {
      final response = await _helper.post(Keys.loginUrl, body, {});
      SharedPreferencesHelper.setUser(UserModel.fromJson(response))
          .then((value) async {
        navigatePushReplacement(
            context: context, nextScreen: const HomeScreen());
      });
    } catch (e) {
      flutterToastWidget(msg: "LogIn Failed", colors: Colors.redAccent);
    }
  }

  Future<bool> register(Map<String, String> body) async {
    final ApiBaseHelper _helper = ApiBaseHelper();
    try {
      final response = _helper.post(Keys.registerUrl, body, {});
      response.then((value) => {print(value)});
      flutterToastWidget(
          msg: "The user has been registered successfully",
          colors: Colors.greenAccent);
      return true;
    } catch (e) {
      flutterToastWidget(
          msg: "The operation did not complete successfully",
          colors: Colors.redAccent);
      return false;
    }
  }
}
