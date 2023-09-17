import 'package:flutter/material.dart';
import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/services/helper/api_base_helper.dart';
import '../models/category_modl.dart' as cat;
import '../services/shared_preferences.dart';
import '../widgets/flutterToastWidget.dart';

class NewInboxHelper {

  NewInboxHelper._();

  static final NewInboxHelper instance = NewInboxHelper._();
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<void> addMail(Map<String, dynamic> body) async {
    try {
      final response = await _helper.post(Keys.mailsUrl, body,
          {'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'});
      flutterToastWidget(msg: "Add Mail Success", colors: Colors.green);
    } catch (e) {
      print(e.toString());
      flutterToastWidget(msg: "Add Mail Failed", colors: Colors.redAccent);
    }
  }

  Future<cat.CategoryModel> getCategory() async {
    final response =
    await _helper.get(Keys.categoriesUrl,{'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'} );
    return cat.CategoryModel.fromJson(response);
  }
}

