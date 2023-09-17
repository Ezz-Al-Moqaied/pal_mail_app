import 'package:flutter/material.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/screens/edit_profile_screen.dart';
import 'package:pal_mail_app/screens/home_screen.dart';
import 'package:pal_mail_app/screens/profile_screen.dart';
import 'package:pal_mail_app/screens/setting_screen.dart';


class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  final List<Map<String, dynamic>> drawerItem = [
    {
      'title': 'Home',
      'icon': Icons.home, // You can replace this with your desired icon
    },
    {
      'title': 'Profile personly',
      'icon': Icons.account_circle_rounded, // You can replace this with your desired icon
    },
    {
      'title': 'senders',
      'icon': Icons.account_box, // You can replace this with your desired icon
    },
    {
      'title': 'settings',
      'icon': Icons.settings, // You can replace this with your desired icon
    },
    // Add more items as needed
  ];


  @override
  Widget build(BuildContext context) {

    List <Function()> function =[
      (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      },
      (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
      },
          (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfileScreen()));
      },
          (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingScreen()));
      }
    ];

    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 80, left: 20, bottom: 20),
      color: splashColorDegree1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15),
            height: 100,
            width: 100,
            child: Image(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/e/ee/Coat_of_arms_of_State_of_Palestine_%28Official%29.png'))
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Column(
              children: drawerItem
                  .map((e) => InkWell(
                onTap: function[e.length],
                    child: Row(
                children: [
                    Icon(
                      e['icon'],
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      height: 50,
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        e['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                ],
              ),
                  ))
                  .toList()),
          const Spacer(),
          Container(
            margin:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Terms of Service',
                    style: TextStyle(
                        color: Color.fromARGB(255, 179, 178, 178),
                        fontSize: 13),
                  ),
                ),
                Container(
                  width: 1.2,
                  height: 15,
                  color: const Color.fromARGB(255, 179, 178, 178),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Usage Policy',
                    style: TextStyle(
                        color: Color.fromARGB(255, 179, 178, 178),
                        fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}