import 'package:flutter/material.dart';
import 'package:pal_mail_app/screens/auth_screen.dart';
import 'package:pal_mail_app/screens/profile_screen.dart';
import 'package:pal_mail_app/screens/sender_screen.dart';
import 'package:pal_mail_app/screens/setting_screen.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List<Map> drawerItem = [
    {'icon': Icons.home, 'title': 'Home'},
    {'icon': Icons.person, 'title': 'Profile Page'},
    {'icon': Icons.account_box, 'title': 'Senders'},
    {'icon': Icons.settings, 'title': 'User Management'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 80, left: 20, bottom: 20),
        width: double.infinity,
        color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15),
                height: 100,
                width: 100,
                child: const Image(
                    image: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/e/ee/Coat_of_arms_of_State_of_Palestine_%28Official%29.png'))),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Column(
                children: drawerItem
                    .map((e) => Row(
                          children: [
                            Icon(
                              e['icon'],
                              color: Colors.white,
                              size: 25,
                            ),
                            const SizedBox(
                              height: 50,
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () async {
                                switch (e["title"]) {
                                  case "Home Page":
                                    print('home');
                                  case "Senders":
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return const SenderScreen();
                                      },
                                    ));
                                  case "Profile Page":
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return const ProfileScreen();
                                      },
                                    ));
                                  case "User Management":
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return const SettingScreen();
                                      },
                                    ));

                                    break;
                                }
                              },
                              child: Text(
                                "${e['title']}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ))
                    .toList()),
            const Spacer(),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Terms Of Service',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Container(
                    width: 1.2,
                    height: 15,
                    color: Colors.white,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Usage Policy',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Container(
                    width: 1.2,
                    height: 15,
                    color: Colors.white,
                  ),
                  TextButton(
                    onPressed: () {
                      SharedPreferencesHelper.deleteUser();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AuthScreen();
                      }));
                    },
                    child: const Text(
                      'LogOut',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
