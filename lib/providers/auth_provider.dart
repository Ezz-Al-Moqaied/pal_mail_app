import 'package:flutter/material.dart';
import 'package:pal_mail_app/models/user_model.dart';
import 'package:pal_mail_app/screens/home_screen.dart';
import 'package:pal_mail_app/controller/auth_controller.dart';
import 'package:pal_mail_app/services/helper/api_response.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';

class AuthProvider with ChangeNotifier {
  bool isLogin = true;
  final AuthHelper _authHelper = AuthHelper.instance;

  void isLoginScreen() {
    isLogin = true;
    notifyListeners();
  }

  void isSignScreen() {
    isLogin = false;
    notifyListeners();
  }

  Future<void> loginUser(Map<String, String> data, BuildContext context) async {
    await _authHelper.login(data, context);
  }

  Future<void> registerUser(
      Map<String, String> data, BuildContext context) async {
    await _authHelper.register(data).then((value) {
      if (value) {
        navigatePushReplacement(
            context: context, nextScreen: const HomeScreen());
      }
    });
  }
}
