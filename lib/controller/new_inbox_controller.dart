import 'package:flutter/material.dart';
import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/services/helper/api_base_helper.dart';

import '../services/shared_preferences.dart';
import '../widgets/flutterToastWidget.dart';

class NewInboxHelper {
  NewInboxHelper._();
  static final NewInboxHelper instance = NewInboxHelper._();
  Future<void> addMail(Map<String, dynamic> body) async {
    final ApiBaseHelper _helper = ApiBaseHelper();
    try {
      final response = await _helper.post(Keys.mailsUrl, body,
          {'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'});
    } catch (e) {
      flutterToastWidget(msg: "Add Mail Failed", colors: Colors.redAccent);
    }
  }
}
