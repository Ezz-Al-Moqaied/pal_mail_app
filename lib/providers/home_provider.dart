import 'package:flutter/material.dart';
import 'package:pal_mail_app/controller/home_controller.dart';
import 'package:pal_mail_app/models/mails_model.dart';

class HomeProvider with ChangeNotifier {
  List<Mail> mail = [];
  int countStatusInbox = 0;
  int countStatusInProgress = 0;
  int countStatusPending = 0;
  int countStatusCompleted = 0;

  double xoffset = 0;
  double yoffset = 0;
  double scalefactor = 1;
  bool isdraweropen = false;

  final HomeHelper _homeHelper = HomeHelper.instance;

  Future<void> getAllMails() async {
    final res = await _homeHelper.getmails().then((value) {
      mailsModelToJson(value);
      for (var element in value.mails!) {
        mail.add(element);
        countStatus(element);
      }
    });
  }

  countStatus(Mail element) async {
    if (element.status?.name == "Inbox") {
      countStatusInbox++;
    } else if (element.status?.name == "In Progress") {
      countStatusInProgress++;
    } else if (element.status?.name == "Pending") {
      countStatusPending++;
    } else {
      countStatusCompleted++;
    }
  }

  void drawerOpen() {
    xoffset = 0;
    yoffset = 0;
    scalefactor = 1;
    isdraweropen = false;
    notifyListeners();
  }

  Future<void> updateData() async {
    await getAllMails();
    notifyListeners();
  }

  void cleanDate() {
    mail.clear();
    countStatusInbox = 0;
    countStatusInProgress = 0;
    countStatusPending = 0;
    countStatusCompleted = 0;
  }

  void drawerClose() {
    xoffset = 320;
    yoffset = 90;
    scalefactor = 0.8;
    isdraweropen = true;
    notifyListeners();
  }
}
