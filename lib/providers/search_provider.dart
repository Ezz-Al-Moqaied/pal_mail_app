import 'package:flutter/material.dart';

import 'package:pal_mail_app/models/mails_model.dart';
import 'package:pal_mail_app/providers/home_provider.dart';

class SearchProvider with ChangeNotifier {
  List<Mail> mail = [];
  int? categoryID;

  int? statusMailsID;

  Future<void> getAllMails(String text, HomeProvider homeProvider) async {
    mail.clear();
    for (var element in homeProvider.mail) {
      if (((element.description != null &&
                  element.description!.contains(text)) ||
              (element.subject != null && element.subject!.contains(text))) &&
          (categoryID == null ||
              (categoryID != null &&
                  element.sender!.category!.id == categoryID)) &&
          (statusMailsID == null ||
              (statusMailsID != null && element.status!.id == statusMailsID))) {
        mail.add(element);
      }
    }
    notifyListeners();
  }

  clearMail() {
    mail.clear();
    notifyListeners();
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

  setCategoryID(int id) {
    categoryID = id;
    notifyListeners();
  }

  setStatusMailsID(int id) {
    statusMailsID = id;
    notifyListeners();
  }
}
