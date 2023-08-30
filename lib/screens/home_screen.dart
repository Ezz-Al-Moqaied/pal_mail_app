import 'package:flutter/material.dart';
import 'package:pal_mail_app/screens/auth_screen.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            SharedPreferencesHelper.deleteUser();
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return AuthScreen();
              },
            ));
          },
          child: const Icon(Icons.logout),
        ),
        title: const Text("Home Screen"),
      ),
    );
  }
}
