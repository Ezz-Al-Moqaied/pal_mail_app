import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/controller/new_inbox_controller.dart';
import 'package:pal_mail_app/providers/new_inbox_provider.dart';
import 'package:pal_mail_app/screens/home_screen.dart';
import 'package:pal_mail_app/widgets/flutterToastWidget.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';
import 'package:pal_mail_app/widgets/text_field_widget.dart';

import '../constants/images.dart';
import '../constants/widget.dart';

class CustomModalBottomSheet {
  final BuildContext context;
  TextEditingController senderController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController decisionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  DateTime _dateTime = DateTime.now();

  Widget basicContainer(double height, Widget widget) {
    return Container(
        padding: EdgeInsets.all(5.w.h),
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30.r))),
        child: widget);
  }

  Widget lineContainer() {
    return Container(
      height: 1,
      width: 400,
      color: Colors.grey[200],
    );
  }

  CustomModalBottomSheet({required this.context});

  void show() {
    showModalBottomSheet(
      backgroundColor: Colors.grey[100],
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r))),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 50,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancle',
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    Text(
                      'New inbox',
                      style: TextStyle(
                          fontSize: 19.sp, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (titleController.text.isNotEmpty) {
                          NewInboxProvider prov = NewInboxProvider();
                          await prov.addMailProv(
                              decision: decisionController.text,
                              description: descriptionController.text,
                              subject: titleController.text,
                              senderId: '16',
                              archiveNumber: "2000",
                              archiveDate: "2023-10-20",
                              statusId: '40',
                              finalDescision: '',
                              activities: [
                                {"body": "any text", "user_id": 6},
                                {"body": "any text2", "user_id": 5}
                              ],
                              tags: [
                                3
                              ]).then((value) {
                            Timer(const Duration(seconds: 1), () {
                              navigatePop(context: context);
                            });
                          });
                        } else {
                          flutterToastWidget(msg: 'Mail must have a title 😄');
                        }
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                smallSpacer,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //part number one
                      basicContainer(
                          180.h,
                          Column(
                            children: [
                              Expanded(
                                child: textFormFieldWidget(
                                  validate: (value) {
                                    senderController.text = value!;
                                    return null;
                                  },
                                  colors: Colors.white,
                                  hintText: 'name',
                                  prefixIcon: Icons.account_circle,
                                  suffixIcon: IconButton(
                                      splashColor: Colors.transparent,
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.info_outline,
                                        color: Colors.blue,
                                      )),
                                  controller: senderController,
                                  type: TextInputType.text,
                                  outlinedBorder: true,
                                ),
                              ),
                              lineContainer(),
                              Expanded(
                                child: textFormFieldWidget(
                                  validate: (value) {
                                    mobileController.text = value!;
                                    return null;
                                  },
                                  outlinedBorder: true,
                                  colors: Colors.white,
                                  hintText: 'Mobile',
                                  prefixIcon: Icons.phone_android_outlined,
                                  controller: mobileController,
                                  type: TextInputType.text,
                                ),
                              ),
                              lineContainer(),
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 11.0.w, left: 11.0.w, top: 10.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Categories',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          'Other',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: textFieldHintColor,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey,
                                          size: 15.sp,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                      smallSpacer,
                      //part number two
                      basicContainer(
                        143.h,
                        Column(
                          children: [
                            Expanded(
                              child: Form(
                                key: formKey,
                                child: textFormFieldWidget(
                                  outlinedBorder: true,
                                  colors: Colors.white,
                                  hintText: 'Title of Mail',
                                  controller: titleController,
                                  type: TextInputType.text,
                                ),
                              ),
                            ),
                            lineContainer(),
                            Expanded(
                              child: textFormFieldWidget(
                                validate: (value) {
                                  descriptionController.text = value!;
                                  return null;
                                },
                                outlinedBorder: true,
                                colors: Colors.white,
                                hintText: 'Describtion',
                                controller: descriptionController,
                                type: TextInputType.text,
                              ),
                            )
                          ],
                        ),
                      ),
                      smallSpacer,
                      //part number three
                      basicContainer(
                          140.h,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2025),
                                      ).then((value) {
                                        _dateTime = value!;
                                      }).catchError((error) {
                                        print(error.toString());
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          color: Colors.red,
                                          size: 25.sp,
                                        ),
                                        SizedBox(
                                          width: 11.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Date',
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Expanded(
                                              child: Text(
                                                _dateTime.toString(),
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey,
                                          size: 20.sp,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              lineContainer(),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0.w.h),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.archive_outlined,
                                        color: textFieldHintColor,
                                        size: 25.sp,
                                      ),
                                      SizedBox(
                                        width: 11.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Archive Number',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            'like: 10/2/2023',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                      smallSpacer,
                      //part number four
                      basicContainer(
                          55.h,
                          Padding(
                            padding: EdgeInsets.all(10.0.w.h),
                            child: Row(
                              children: [
                                Text(
                                  '#',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: border,
                                  ),
                                ),
                                SizedBox(
                                  width: 14.w,
                                ),
                                Text(
                                  'Tags',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 20.sp,
                                )
                              ],
                            ),
                          )),
                      smallSpacer,
                      //part number five
                      basicContainer(
                          60.h,
                          Padding(
                            padding: EdgeInsets.all(10.0.w.h),
                            child: Row(
                              children: [
                                const Icon(Icons.local_offer_outlined),
                                SizedBox(
                                  width: 14.w,
                                ),
                                Container(
                                  width: 70.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.circular(15.r)),
                                  child: const Center(
                                    child: Text(
                                      'inbox',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 20.sp,
                                )
                              ],
                            ),
                          )),
                      smallSpacer,
                      //part number sex
                      basicContainer(
                        120.h,
                        Padding(
                          padding: EdgeInsets.only(left: 12.0.w, top: 12.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Decision',
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ),
                              Expanded(
                                child: textFormFieldWidget(
                                  outlinedBorder: true,
                                  colors: Colors.white,
                                  hintText: 'Add Decision..',
                                  controller: decisionController,
                                  type: TextInputType.text,
                                  validate: (p0) => '',
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      smallSpacer,
                      //part number seven
                      basicContainer(
                          55.h,
                          Padding(
                            padding: EdgeInsets.all(10.0.w.h),
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.image,
                                    color: tagTextColor,
                                  ),
                                  SizedBox(
                                    width: 14.w,
                                  ),
                                  Text(
                                    'Add image',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      color: splashColorDegree1,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey,
                                    size: 20.sp,
                                  )
                                ],
                              ),
                            ),
                          )),
                      smallSpacer,
                      Text(
                        'Activity',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      smallSpacer,
                      basicContainer(
                          55.h,
                          Padding(
                            padding: EdgeInsets.all(10.0.w.h),
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Image.asset(
                                    Images.personIcon,
                                    width: 25.w,
                                    height: 25.h,
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Text(
                                    'Add new Activity ..',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      color: splashColorDegree1,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.send,
                                    color: Colors.grey,
                                    size: 20.sp,
                                  )
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
