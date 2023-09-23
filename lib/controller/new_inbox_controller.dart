import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pal_mail_app/constants/keys.dart';

import 'package:pal_mail_app/controller/sender_model.dart';
import 'package:pal_mail_app/models/category_modl.dart' as cat;

import 'package:pal_mail_app/models/mails_model.dart';
import 'package:pal_mail_app/services/helper/api_base_helper.dart';
import '../widgets/flutterToastWidget.dart';

class NewInboxHelper {
  NewInboxHelper._();
  static final NewInboxHelper instance = NewInboxHelper._();
  final _helper = ApiBaseHelper();

  Future<Mail?> addMail(Map<String, dynamic> body) async {
    try {
      final response =
          await _helper.post(Keys.mailsUrl, body, Keys.instance.header);
      flutterToastWidget(msg: "Add Mail Success", colors: Colors.green);
      print(Mail.fromJson(response['mail']).id);
      return Mail.fromJson(response['mail']);
    } catch (e) {
      print(e.toString());
      flutterToastWidget(msg: "Add Mail Failed", colors: Colors.redAccent);
      return null;
    }
  }

  // Get sender
  Future<cat.CategoryModel> getCategory() async {
    final response =
        await _helper.get(Keys.categoriesUrl, Keys.instance.header);
    return cat.CategoryModel.fromJson(response);
  }

  Future<SenderModel> getSenders() async {
    final response = await _helper.get(Keys.sendersUrl, Keys.instance.header);
    return SenderModel.fromJson(response);
  }

  // Post Sender if you create new Sender
  Future<Datum?> createSender(Map<String, dynamic> body) async {
    try {
      final response =
          await _helper.post(Keys.sendersUrl, body, Keys.instance.header);
      flutterToastWidget(msg: "Create Sender Success", colors: Colors.green);

      print(Datum.fromJson(response!['sender'][0]).id);
      return Datum.fromJson(response!['sender'][0]);
    } catch (e) {
      print(e.toString());
      flutterToastWidget(msg: "Create Sender Failed", colors: Colors.redAccent);
      return null;
    }
  }

  Future<void> uploadImageHttp(File file, mailId) async {
    try {
      var request =
          http.MultipartRequest("POST", Uri.parse(Keys.attachmentUrl));
//create multipart using filepath, string or bytes
      var pic = await http.MultipartFile.fromPath('image', file.path);
      request.fields['mail_id'] = mailId.toString();
      request.fields['title'] = 'image_${DateTime.now()}';

      request.files.add(pic);
      request.headers.addAll(Keys.instance.header);
      var response = await request.send();

      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      if (response.statusCode == 200) {
        flutterToastWidget(
            msg: "Upload attachment success", colors: Colors.green);
      } else {
        flutterToastWidget(
            msg: "Erro During Communication : ${response.statusCode}",
            colors: Colors.green);
      }
      print(responseString);
    } catch (e) {
      flutterToastWidget(
          msg: "Failed to upload attachment", colors: Colors.red);
    }
  }
}
