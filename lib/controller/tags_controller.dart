import 'package:flutter/material.dart';
import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/models/tage_model.dart';
import 'package:pal_mail_app/services/helper/api_base_helper.dart';
import 'package:pal_mail_app/widgets/flutterToastWidget.dart';

import '../services/shared_preferences.dart';

class TagsHelper {
  TagsHelper._();
  static final TagsHelper instance = TagsHelper._();
  Future<TagsModel> getTags() async {
    final _apiHelper = ApiBaseHelper();
    final response = await _apiHelper.get(Keys.tagsUrl,
        {'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'});
    print(TagsModel.fromJson(response).tags![0].name);
    return TagsModel.fromJson(response);
  }

  Future<void> createTags(Map<String, dynamic> body) async {
    final _apiHelper = ApiBaseHelper();
    try {
      await _apiHelper.post(Keys.tagsUrl, body,
          {'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'});
    } catch (e) {
      flutterToastWidget(msg: 'Create Tag Failed', colors: Colors.red);
    }
  }
}
