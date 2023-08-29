import 'package:flutter/material.dart';
import 'package:pal_mail_app/screens/auth_screen.dart';
import 'package:pal_mail_app/services/helper/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            SharedPreferencesHelper.deletUser();
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return AuthScreen();
              },
            ));
          },
          child: Icon(Icons.logout),
        ),
        title: const Text("Home Screen"),
      ),
    );
  }
}
