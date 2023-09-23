import 'package:flutter/material.dart';
import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/services/helper/api_base_helper.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';
import 'package:pal_mail_app/widgets/flutterToastWidget.dart';

class DetailsMailController {
  DetailsMailController._();

  static final DetailsMailController instance = DetailsMailController._();

  updateMail(int id, Map<String, dynamic> body) async {
    ApiBaseHelper helper = ApiBaseHelper();
    try {
      final response = await helper.put(
        "${Keys.mailsUrl}/$id",
        body,
        {'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'},
      );
    } catch (e) {
      flutterToastWidget(msg: "Failed", colors: Colors.redAccent);
      print(e.toString());
    }
  }
}
