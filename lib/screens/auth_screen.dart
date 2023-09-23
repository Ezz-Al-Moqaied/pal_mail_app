import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/constants/images.dart';
import 'package:pal_mail_app/constants/widget.dart';
import 'package:pal_mail_app/providers/auth_provider.dart';
import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/screens/home_screen.dart';
import 'package:pal_mail_app/services/localizations_extention.dart';
import 'package:pal_mail_app/widgets/flutterToastWidget.dart';
import 'package:pal_mail_app/widgets/login_widget.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';
import 'package:pal_mail_app/widgets/register_widget.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  AnimationController? animationController2;
  Color? color = buttonBackGroundColor1;
  Color? color2 = buttonBackGroundColor2;
  Color? textcolor = buttonColor1;
  Color? textcolor2 = buttonColor2;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..reverse();

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    animationController2?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
        body: Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: -100.h,
          child: Container(
            height: 500.h,
            width: 500.w,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.ellipse), fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Images.appLogo,
                  width: 100.w,
                  height: 100.h,
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
        Positioned(
          bottom: 50.h,
          child: Container(
            height: 600.h,
            width: 370.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  largeSpacer,
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: border,
                        ),
                        borderRadius: BorderRadius.circular(24.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24.r),
                                  bottomLeft: Radius.circular(24.r))),
                          duration: Duration(milliseconds: 500),
                          child: ElevatedButton(
                              onPressed: () {
                                authProvider.isLoginScreen();
                                animationController!.forward();
                                animationController2!.reverse();
                                color = buttonBackGroundColor1;
                                textcolor = buttonColor1;
                                color2 = buttonBackGroundColor2;
                                textcolor2 = buttonColor2;
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  splashFactory: NoSplash.splashFactory,
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 24.h, horizontal: 42.w)),
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 500),
                                style: TextStyle(color: color2),
                                child: Text(
                                  context.localizations!.logIn,
                                ),
                              )),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                              color: color2,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24.r),
                                  bottomRight: Radius.circular(24.r))),
                          child: ElevatedButton(
                              onPressed: () {
                                authProvider.isSignScreen();
                                animationController2!.forward();
                                animationController!.reverse();
                                color = buttonBackGroundColor2;
                                textcolor = buttonColor2;
                                color2 = buttonBackGroundColor1;
                                textcolor2 = buttonColor1;
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  shadowColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 24.h, horizontal: 42.w)),
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 500),
                                style: TextStyle(color: textcolor2),
                                child: Text(
                                  context.localizations!.signUp,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  largeSpacer,
                  authProvider.isLogin
                      ? FadeTransition(
                          opacity: animationController!,
                          child: LoginWidget(
                            emailController: emailController,
                            passwordController: passwordController,
                            formKey: _formKey,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                authProvider.loginUser({
                                  'email': emailController.text,
                                  'password': passwordController.text,
                                }, context).then((value){
                                  final homeProvider = Provider.of<HomeProvider>(context , listen: false);
                                  homeProvider.getFetchData();
                                  Timer.periodic(Duration(seconds: 6), (Timer t){
                                    navigatePushReplacement(
                                        context: context, nextScreen: HomeScreen());
                                  });


                                });
                              }
                            },
                          ),
                        )
                      : FadeTransition(
                          opacity: animationController2!,
                          child: RegisterWidget(
                            emailController: emailController,
                            passwordController: passwordController,
                            confirmPasswordController:
                                confirmPasswordController,
                            usernameController: usernameController,
                            formKey: _formKey,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  authProvider.registerUser({
                                    'email': emailController.text,
                                    'password': passwordController.text,
                                    'password_confirmation':
                                        confirmPasswordController.text,
                                    'name': usernameController.text
                                  }, context);
                                } else {
                                  flutterToastWidget(
                                      msg: "Password does not match",
                                      colors: Colors.greenAccent);
                                }
                              }
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
