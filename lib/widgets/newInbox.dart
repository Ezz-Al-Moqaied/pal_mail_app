import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/widgets/text_field_widget.dart';

import '../constants/colors.dart';
import '../constants/widget.dart';

class NewInbox extends StatelessWidget {
  NewInbox({super.key});
  
  Widget basicContainer(Widget widget) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30.r))),
        child: widget);
  }

  TextEditingController senderController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController describtionController = TextEditingController();
  TextEditingController DecisionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Done',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          smallSpacer,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                //part number one
                basicContainer(Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textFormFieldWidget(
                      colors: colorWhite,
                      outlinedBorder: false,
                      hintText: 'Sender',
                      prefixIcon: Icons.person_2_outlined,
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.info_outline,
                            color: Colors.blue,
                          )),
                      controller: senderController,
                      type: TextInputType.text,
                      validate: (p0) => '',
                    ),
                    textFormFieldWidget(
                      colors: colorWhite,
                      outlinedBorder: false,
                      hintText: 'Mobile',
                      prefixIcon: Icons.phone_android_outlined,
                      controller: mobileController,
                      type: TextInputType.text,
                      validate: (p0) => '',
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: 11.0.w, left: 11.0.w, top: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                            const Spacer(),
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
                    )
                  ],
                )),
                smallSpacer,
                //part number two
                basicContainer(
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textFormFieldWidget(
                        colors: colorWhite,
                        outlinedBorder: true,
                        hintText: 'Title of Mail',
                        controller: titleController,
                        type: TextInputType.text,
                        validate: (p0) => '',
                      ),
                      textFormFieldWidget(
                        colors: colorWhite,
                        outlinedBorder: true,
                        hintText: 'Describtion',
                        controller: describtionController,
                        type: TextInputType.text,
                        validate: (p0) => '',
                      )
                    ],
                  ),
                ),
                smallSpacer,
                //part number three
                basicContainer(Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0.w.h),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                '2 mar 10/2/2023',
                                style: TextStyle(
                                  fontSize: 12.sp,
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
                    Padding(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                  ],
                )),
                smallSpacer,
                //part number four
                basicContainer(Padding(
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
                basicContainer(Row(
                  children: [
                    const Icon(Icons.arrow_forward),
                    SizedBox(
                      width: 14.w,
                    ),
                    Container(
                      width: 70.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(24.r)),
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
                )),
                smallSpacer,
                basicContainer(
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textFormFieldWidget(
                        colors: colorWhite,
                        outlinedBorder: false,
                        hintText: 'Describtion',
                        controller: DecisionController,
                        type: TextInputType.text,
                        validate: (p0) => '',
                      )
                    ],
                  ),
                ),
                smallSpacer,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
