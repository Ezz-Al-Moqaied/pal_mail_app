import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/models/user_model.dart';
import 'package:pal_mail_app/screens/inbox_screen.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';
import 'package:pal_mail_app/widgets/flutterToastWidget.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';

class AuthHelper {
  AuthHelper._();

  static final AuthHelper instance = AuthHelper._();

  Future<void> login(Map<String, String> body, BuildContext context) async {
    final response = await http.post(
      Uri.parse(Keys.loginUrl),
      body: body,
    );
    if (response.statusCode == 200) {
      SharedPreferencesHelper.setUser(userModelFromJson(response.body))
          .then((value) async {
        navigatePushReplacement(
            context: context, nextScreen: const HomeScreen());
      });
    } else {
      flutterToastWidget(
          msg: "Check the data process", colors: Colors.redAccent);
    }
  }


  Future<bool> register(Map<String, String> body) async {
    final response = await http.post(
      Uri.parse(Keys.registerUrl),
      body: body,
    );
    if (response.statusCode == 200) {
      flutterToastWidget(
          msg: "The user has been registered successfully",
          colors: Colors.greenAccent);
      return true;
    } else if (response.statusCode == 200) {
      SharedPreferencesHelper.setUser(userModelFromJson(response.body)).then((value){
        flutterToastWidget(msg: "Email is used", colors: Colors.deepOrangeAccent);
      });

    } else {
      flutterToastWidget(
          msg: "The operation did not complete successfully",
          colors: Colors.redAccent);
    }
    return false;
  }

}
