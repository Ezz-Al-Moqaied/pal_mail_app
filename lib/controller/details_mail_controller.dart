import 'package:flutter/material.dart';
import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/widgets/flutterToastWidget.dart';
import 'package:http/http.dart' as http;

class DetailsMailController {
  DetailsMailController._();

  static final DetailsMailController instance = DetailsMailController._();

  Future<void> updateMail(int id, Map<String, dynamic> body) async {
    try {
      // ignore: unused_local_variable
      final response = await http.put(Uri.parse("${Keys.mailsUrl}/$id"),
          body: body, headers: Keys.instance.header);
      flutterToastWidget(msg: "Succes", colors: Colors.green);
    } catch (e) {
      flutterToastWidget(msg: "Failed", colors: Colors.redAccent);
      print(e.toString());
    }
  }
}
