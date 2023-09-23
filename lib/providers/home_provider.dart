import 'package:flutter/material.dart';
import 'package:pal_mail_app/controller/home_controller.dart';
import 'package:pal_mail_app/models/mails_model.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category_modl.dart';
import '../models/status_model.dart';
import '../models/tage_model.dart';

class HomeProvider with ChangeNotifier {
  List<Mail> mail = [];
  List<Mail> categoryOfficialOrganizations = [];
  List<Mail> categoryOther = [];
  List<Mail> categoryNGOs = [];
  List<Category> category = [];
  List<Mail> categoryForeign = [];
  List<String> tag = ["All Tags"];
  List<StatusMails> statusMails = [];
  int countStatusInbox = 0;
  int countStatusInProgress = 0;
  int countStatusPending = 0;
  int countStatusCompleted = 0;
  int? statusMailsID;
  double xoffset = 0;
  double yoffset = 0;
  double scalefactor = 1;
  bool isdraweropen = false;

  final HomeHelper _homeHelper = HomeHelper.instance;


  getFetchData () async {
    getAllMails();
    getStatusMails();
    getTage();
    getCategory();
  }

  Future<void> getFetchDataLoadding () async {
    await getAllMails();
    await getStatusMails();
    await getTage();
    await getCategory();
  }


  Future<void> getCategory() async {
    await _homeHelper.getCategory().then((value) {
      category.clear();
      categoryModelToJson(value);
      for (var element in value.categories!) {
        category.add(element);
      }
    });
  }

  Future<void> getAllMails() async {
    await _homeHelper.getMails().then((value) {
      mail.clear();
      mailsModelToJson(value);
      for (var element in value.mails!) {
        mail.add(element);
        countStatusMails(element);
        categoryMails(element);
      }
      print(mail.length);
    });
  }

  Future<void> getStatusMails() async {
    await _homeHelper.getStatusMails().then((value) {
      statusMails.clear();
      statusModelToJson(value);
      for (var element in value.statuses!) {
        statusMails.add(element);
      }
    });
  }

  Color countStatusMails(Mail mail) {
    if (mail.status!.name == "Inbox") {
      countStatusInbox++;
      return Colors.red;
    } else if (mail.status!.name == "In Progress" &&
        mail.status!.name != null) {
      countStatusInProgress++;
      return Colors.yellow;
    } else if (mail.status!.name == "Pending" && mail.status!.name != null) {
      countStatusPending++;
      return Colors.blueAccent;
    } else {
      countStatusCompleted++;
      return Colors.green;
    }
  }

  categoryMails(Mail mail) {
    if (mail.sender!.category!.id == 1) {
      categoryOther.add(mail);
    } else if (mail.sender!.category!.id == 2) {
      categoryOfficialOrganizations.add(mail);
    } else if (mail.sender!.category!.id == 3) {
      categoryNGOs.add(mail);
    } else if (mail.sender!.category!.id == 4) {
      categoryForeign.add(mail);
    }
  }

  int countCategoryMails(int id) {
    int count = 0;
    for (var element in mail) {
      if (element.sender!.category!.id == id) {
        count++;
      }
    }
    return count;
  }

  Future<void> getTage() async {
    await _homeHelper.getTage().then((value) {
      tag.clear();
      tagsModelToJson(value);
      for (var element in value.tags!) {
        tag.add(element.name!);
      }
    });
  }

  setStatusMailsID(int id) {
    statusMailsID = id;
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
