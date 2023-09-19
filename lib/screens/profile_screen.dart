import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/screens/edit_profile_screen.dart';
import '../widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Profile Screen', style: TextStyle(fontSize: 18)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 20.0,left: 12,right: 12),
            child: Column(
              children: [
                /// -- IMAGE
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(image: AssetImage('assets/images/1.jpeg'),fit: BoxFit.cover,)),
                ),
                SizedBox(height: 10.h,),
                const Text('name controller',
                    style: TextStyle(fontSize: 20)),
                const Text('mohammedelshawa944@gmail.com',
                    style: TextStyle(fontSize: 16,color: Colors.grey)),
                const SizedBox(height: 20),

                /// -- BUTTON
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfileScreen())),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text('Edit Profile',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 20.h),
                const Divider(),

                /// -- MENU
                ProfileMenuWidget(
                    title: "Settings",
                    icon: Icons.settings,
                    onPress: () {}),
                ProfileMenuWidget(
                    title: "Billing Details",
                    icon: Icons.wallet,
                    onPress: () {}),
                ProfileMenuWidget(
                    title: "User Management",
                    icon: Icons.account_circle_rounded,
                    onPress: () {}),
                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuWidget(
                    title: "Information",
                    icon: Icons.info,
                    onPress: () {}),
                ProfileMenuWidget(
                    title: "Logout",
                    icon: Icons.login,
                    textColor: Colors.red,
                    endIcon: false,
                    onPress: () {
                      // Get.defaultDialog(
                      //   title: "LOGOUT",
                      //   titleStyle: const TextStyle(fontSize: 20),
                      //   content: const Padding(
                      //     padding: EdgeInsets.symmetric(vertical: 15.0),
                      //     child: Text("Are you sure, you want to Logout?"),
                      //   ),
                      //   confirm: Expanded(
                      //     child: ElevatedButton(
                      //       onPressed: () {},
                      //       child: const Text("Yes"),
                      //     ),
                      //   ),
                      //   // cancel: OutlinedButton(
                      //   //     onPressed: () => Get.back(), child: const Text("No")),
                      // );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
