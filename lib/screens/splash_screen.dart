import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/constants/images.dart';
import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/services/localizations_extention.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    if(SharedPreferencesHelper.isLogged) {
      homeProvider.getAllMails();
    }

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
