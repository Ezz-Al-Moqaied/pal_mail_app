import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/constants/widget.dart';

Widget statusMailWidget({
  required Color? colors,
  required int countMail,
  required String status,
}) =>
    Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colors,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                height: 24.h,
                width: 24.w,
              ),
              const Spacer(),
              Text(countMail.toString(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          mediumSpacer,
          Text(status,
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.black.withOpacity(0.3),
              )),
        ],
      ),
    );
