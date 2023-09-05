import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pal_mail_app/controller/new_inbox_controller.dart';

class NewInboxProvider extends ChangeNotifier {
  final NewInboxHelper _helper = NewInboxHelper.instance;
  Future<void> addMailProv(
      {required String subject,
      String? description,
      required String senderId,
      required String archiveNumber,
      required String archiveDate,
      String? decision,
      required String statusId,
      String? finalDescision,
      List? tags,
      List? activities}) async {
    try {
      await _helper.addMail({
        'subject': subject,
        'description': description,
        'sender_id': senderId,
        'archive_number': archiveNumber,
        'archive_date': archiveDate,
        'decision': decision,
        'status_id': statusId,
        'final_decision': finalDescision,
        'tags': json.encode(tags),
        'activities': json.encode(activities),
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
