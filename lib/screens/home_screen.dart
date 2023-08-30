import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/constants/images.dart';
import 'package:pal_mail_app/constants/widget.dart';
import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/screens/auth_screen.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';
import 'package:pal_mail_app/widgets/status_mail_widget.dart';
import 'package:pal_mail_app/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            largeSpacer,
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notes_sharp,
                    size: 30.sp,
                  ),
                  onPressed: () async {
                    print(":");
                    await homeProvider.getAllMails();
                  },
                ),
                const Spacer(),
                Image.asset(
                  Images.personIcon,
                ),
              ],
            ),
            textFormFieldWidget(
                controller: searchController,
                type: TextInputType.text,
                validate: (value) {},
                hintText: "search",
                prefixIcon: Icons.search,
                colors: Colors.white),
            mediumSpacer,
            Row(
              children: [
                Expanded(
                  child: statusMailWidget(
                      colors: Colors.red,
                      countMail: homeProvider.countStatusInbox,
                      status: "Inbox"),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: statusMailWidget(
                      colors: Colors.yellow,
                      countMail: homeProvider.countStatusPending,
                      status: "Pending"),
                ),
              ],
            ),
            smallSpacer,
            Row(
              children: [
                Expanded(
                  child: statusMailWidget(
                      colors: Colors.blueAccent,
                      countMail: homeProvider.countStatusInProgress,
                      status: "In progress"),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: statusMailWidget(
                      colors: Colors.green,
                      countMail: homeProvider.countStatusCompleted,
                      status: "Completed"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
