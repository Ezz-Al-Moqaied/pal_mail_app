import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/constants/images.dart';
import 'package:pal_mail_app/constants/widget.dart';


import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/screens/newInbox/new_inbox_bottomSheet.dart';
import 'package:pal_mail_app/screens/search_screen.dart';
import 'package:pal_mail_app/widgets/mails_widget.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';

import 'package:pal_mail_app/widgets/status_mail_widget.dart';
import 'package:pal_mail_app/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/tags_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      transform: Matrix4.translationValues(
          homeProvider.xoffset, homeProvider.yoffset, 0)
        ..scale(homeProvider.scalefactor),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(homeProvider.isdraweropen ? 20 : 0),
        color: Colors.white,
      ),
      child: Scaffold(
        bottomSheet: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: colorWhite,
                padding:
                    EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w)),
            onPressed: () {
              CustomModalBottomSheet(context: context).show();
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: inboxtextColor,
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Icon(
                    Icons.add_outlined,
                    size: 24.w.h,
                    color: colorWhite,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "New Inbox",
                  style: TextStyle(fontSize: 20, color: inboxtextColor),
                )
              ],
            )),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),

        child: SingleChildScrollView(

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
                    onPressed: () async {},
                  ),
                  const Spacer(),
                  Image.asset(
                    Images.personIcon,
                  ),
                ],
              ),
              textFormFieldWidget(
                  outlinedBorder: false,
                  controller: searchController,
                  type: TextInputType.text,
                  validate: (value) {
                    return null;
                  },
                  hintText: "search",

                  onTapForm: () {
                    //   showSearch(context: context, delegate: SearchScreen());
                    navigatePush(context: context, nextScreen: SearchScreen());
                  },
                  prefixIcon: IconButton(
                      onPressed: () {}, icon: Icon(Icons.search_outlined)),
                  colors: Colors.white),
              smallSpacer,
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
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ExpansionTile(
                      title: Row(
                        children: [
                          Text(
                            "Official Organization",
                            style:
                                TextStyle(fontSize: 20.sp, color: colorBlack),
                          ),
                          const Spacer(),
                          Text(homeProvider.countCategoryMails(2).toString())
                        ],
                      ),
                      children: [
                        for (var element in homeProvider.mail)
                          if (element.sender!.category!.id == 2)
                            mailsWidget(mails: element, context: context),
                      ]),
                ],
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ExpansionTile(
                    title: Row(
                      children: [
                        Text(
                          "NGOs",
                          style: TextStyle(fontSize: 20.sp, color: colorBlack),
                        ),
                        const Spacer(),
                        Text(homeProvider.countCategoryMails(3).toString())
                      ],
                    ),
                    children: [
                      for (var element in homeProvider.mail)
                        if (element.sender!.category!.id == 3)
                          mailsWidget(mails: element, context: context),
                    ],
                  ),
                ],
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ExpansionTile(
                    title: Row(
                      children: [
                        Text(
                          "Others",
                          style: TextStyle(fontSize: 20.sp, color: colorBlack),
                        ),
                        const Spacer(),
                        Text(homeProvider.countCategoryMails(4).toString())
                      ],
                    ),
                    children: [
                      for (var element in homeProvider.mail)
                        if (element.sender!.category!.id == 4)
                          mailsWidget(mails: element, context: context)
                    ],
                  ),
                ],
              ),
              smallSpacer,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tags",
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),

              TagsWidget(tag: homeProvider.tag),
              mediumSpacer,
              Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.r))),
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () {
                        CustomModalBottomSheet(context: context).show();
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: inboxtextColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.r),
                                )),
                            child: Icon(
                              Icons.add_outlined,
                              size: 24.sp,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text("New Inbox",
                              style: TextStyle(
                                  fontSize: 20.sp, color: inboxtextColor))
                        ],
                      ))),

            ],
          ),
        ),
      ),
    );
  }
}
