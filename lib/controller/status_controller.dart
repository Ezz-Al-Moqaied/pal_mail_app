import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/models/category_model.dart' as cat;
import 'package:pal_mail_app/models/mails_model.dart';
import 'package:pal_mail_app/models/sender_model.dart';
import 'package:pal_mail_app/services/helper/api_base_helper.dart';

import '../models/status_model.dart';
import '../widgets/flutterToastWidget.dart';

class StatusHelper {
  StatusHelper._();
  static final StatusHelper instance = StatusHelper._();
  final _helper = ApiBaseHelper();
  Future<StatusModel> getStatus() async {
    final response = await _helper.get(Keys.statusUrl, Keys.instance.header);
    return StatusModel.fromJson(response);
  }
}
