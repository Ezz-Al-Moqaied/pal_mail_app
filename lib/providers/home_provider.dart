import 'package:flutter/material.dart';
import 'package:pal_mail_app/controller/home_controller.dart';
import 'package:pal_mail_app/models/mails_model.dart';

class HomeProvider with ChangeNotifier {
  List<Mail> mail = [];
  int countStatusInbox = 0;
  int countStatusInProgress = 0;
  int countStatusPending = 0;
  int countStatusCompleted = 0;

  final HomeHelper _homeHelper = HomeHelper.instance;

  Future<void> getAllMails() async {
    await _homeHelper.mails().then((value) {
      value.mails?.forEach((element) {
        mail.add(element);
        countStatus(element);
      });
    });
  }

  countStatus(Mail element) {
    if (element.status!.name == "Inbox") {
      countStatusInbox++;
    } else if (element.status!.name == "In Progress") {
      countStatusInProgress++;
    } else if (element.status!.name == "Pending") {
      countStatusPending++;
    } else {
      countStatusCompleted++;
    }
  }
}
