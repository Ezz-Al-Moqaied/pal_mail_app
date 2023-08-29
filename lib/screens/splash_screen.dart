import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/services/util/colors.dart';
import 'package:pal_mail_app/services/util/images.dart';
import 'package:pal_mail_app/services/helper/localizations_extention.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          splashColorDegree1,
          splashColorDegree2,
          splashColorDegree3,
        ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Images.appLogo,
            width: 130.w,
            height: 130.h,
          ),
          SizedBox(
            height: 32.h,
          ),
          Text(
            context.localizations!.splashTitle,
            style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: colorWhite),
          ),
        ],
      ),
    );
  }
}
