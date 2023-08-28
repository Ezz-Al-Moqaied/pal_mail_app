import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/constants/images.dart';
import 'package:pal_mail_app/constants/widget.dart';
import 'package:pal_mail_app/providers/auth_provider.dart';
import 'package:pal_mail_app/services/localizations_extention.dart';
import 'package:provider/provider.dart';

import '../widgets/auth_icon_widget.dart';
import '../widgets/text_field_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return Scaffold(
        body: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // Minisitry Icon and background Image Widget
        Positioned(
          top: -100,
          child: Container(
            height: 571.h,
            width: 571.w,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.ellipse), fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.appLogo,
                  width: 56.w,
                ),
                smallSpacer,
                Text(
                  context.localizations!.splashTitle,
                  style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: colorWhite),
                )
              ],
            ),
          ),
        ),
        // LogIN and Sign up
        Consumer<AuthProvider>(
          builder: (context, auth, child) {
            return Positioned(
              bottom: 50,
              child: Container(
                height: 600.h,
                width: 370.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Bottoms
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: border,
                          ),
                          borderRadius: BorderRadius.circular(24)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                auth.buttonlog();
                              },
                              style: ElevatedButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  shadowColor: Colors.transparent,
                                  backgroundColor: auth.isSignUp == true
                                      ? buttonBackGroundColor2
                                      : buttonBackGroundColor1,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(24.r)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16.h, horizontal: 40.w)),
                              child: Text(
                                context.localizations!.logIn,
                                style: TextStyle(
                                    color: auth.isSignUp == true
                                        ? buttonColor2
                                        : buttonColor1),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                auth.buttonSign();
                              },
                              style: ElevatedButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  shadowColor: Colors.transparent,
                                  backgroundColor: auth.isSignUp == true
                                      ? buttonBackGroundColor1
                                      : buttonBackGroundColor2,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(24.r)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16.h, horizontal: 40.w)),
                              child: Text(
                                context.localizations!.signUp,
                                style: TextStyle(
                                    color: auth.isSignUp == true
                                        ? buttonColor1
                                        : buttonColor2),
                              )),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        TextFieldWidget(
                          controller: emailController,
                          hintText: context.localizations!.emailField,
                          errorText: "Required Field",
                        ),
                        smallSpacer,
                        TextFieldWidget(
                          controller: passwordController,
                          hintText: context.localizations!.passField,
                          errorText: "Required Field",
                        ),
                        smallSpacer,
                        auth.isSignUp == true
                            ? TextFieldWidget(
                                controller: confirmPasswordController,
                                hintText:
                                    context.localizations!.confirmPassField,
                                errorText: "Required Field",
                              )
                            : const SizedBox(),
                      ],
                    ),
                    smallSpacer,
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r)),
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 40.w)),
                        child: SizedBox(
                            width: double.infinity,
                            child: Center(
                                child: Text(auth.isSignUp == true
                                    ? context.localizations!.signUp
                                    : context.localizations!.logIn)))),
                    auth.isSignUp == true
                        ? Container(
                            alignment: Alignment.center,
                            child: Text(
                              "OR",
                              style: TextStyle(
                                  color: textFieldHintColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp),
                            ),
                          )
                        : const SizedBox(),
                    auth.isSignUp == true
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconWidget(imgPath: Images.faceBook),
                              IconWidget(imgPath: Images.twitter),
                              IconWidget(imgPath: Images.google),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ));
  }
}
