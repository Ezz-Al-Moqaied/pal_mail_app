import 'package:flutter/material.dart';
import 'package:pal_mail_app/controller/details_mail_controller.dart';
import 'package:pal_mail_app/models/mails_model.dart';

class DetailsMailProvider with ChangeNotifier {
  int? statusMailsID;
  bool isScreenChange = false;
  List<Attachment>? attachments = [];
  List<Activity>? activity = [];

  setActivityList(List<Activity>? acti) {
    activity!.clear();
    for (var element in acti!) {
      activity!.add(element);
    }
  }

  addActivity(Activity acti) {
    activity!.add(acti);
    notifyListeners();
  }

  deleteItemActivity(Activity acti) {
    activity!.remove(acti);
    notifyListeners();
  }

  setAttachmentList(List<Attachment>? attachment) {
    attachments!.clear();
    for (var element in attachment!) {
      attachments!.add(element);
    }
  }

  addAttachments(Attachment attachment) {
    attachments!.add(attachment);
    notifyListeners();
  }

  deleteItemAttachments(Attachment attachment) {
    attachments!.remove(attachment);
    notifyListeners();
  }

  setStatusMailsID(int id) {
    statusMailsID = id;
    notifyListeners();
  }

  setScreenChange(bool value) {
    isScreenChange = value;
    notifyListeners();
  }

  updateMail(int id, Map<String, dynamic> body) async {
    DetailsMailController controller = DetailsMailController.instance;
    controller.updateMail(id, body);
  }
}
