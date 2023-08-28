import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool isSignUp = true;
  buttonSign() {
    isSignUp = true;
    notifyListeners();
  }

  buttonlog() {
    isSignUp = false;
    notifyListeners();
  }
}
