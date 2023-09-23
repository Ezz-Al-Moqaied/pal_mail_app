import 'package:flutter/material.dart';
import 'package:pal_mail_app/controller/auth_controller.dart';
import 'package:pal_mail_app/screens/home_screen.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {

  bool isLogin = true;
  final AuthHelper _authHelper = AuthHelper.instance;
  double loginOpacity = 1;
  double signOpacity = 0;
  void isLoginScreen() {
    isLogin = true;
    loginOpacity = 1;
    signOpacity = 0;
    notifyListeners();
  }

  void isSignScreen() {
    isLogin = false;
    signOpacity = 1;
    loginOpacity = 0;
    notifyListeners();
  }

  Future<void> loginUser(Map<String, String> data, BuildContext context) async {
    await _authHelper.login(data, context);
  }

  Future<void> registerUser(Map<String, String> data,
      BuildContext context) async {
    await _authHelper.register(data).then((value) {
      if (value) {
        navigatePushReplacement(context: context, nextScreen: HomeScreen());
      }
    });
  }
}
