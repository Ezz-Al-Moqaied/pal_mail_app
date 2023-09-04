import 'package:flutter/material.dart';
import 'package:pal_mail_app/constants/colors.dart';


class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {


  @override
  Widget build(BuildContext context) {
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