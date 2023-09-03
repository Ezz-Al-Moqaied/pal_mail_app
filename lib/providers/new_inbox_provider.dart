import 'package:flutter/material.dart';
import 'package:pal_mail_app/controller/new_inbox_controller.dart';

class NewInboxProvider extends ChangeNotifier {
  final NewInboxHelper _helper = NewInboxHelper.instance;
}
