import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/constants/images.dart';
import 'package:pal_mail_app/constants/widget.dart';
import 'package:pal_mail_app/providers/auth_provider.dart';
import 'package:pal_mail_app/services/localizations_extention.dart';
import 'package:pal_mail_app/widgets/flutterToastWidget.dart';
import 'package:pal_mail_app/widgets/login_widget.dart';
import 'package:pal_mail_app/widgets/register_widget.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    TextEditingController emailController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

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
                        ElevatedButton(
                            onPressed: () {
                              authProvider.isLoginScreen();
                            },
                            style: ElevatedButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                                shadowColor: Colors.transparent,
                                backgroundColor: authProvider.isLogin
                                    ? buttonBackGroundColor1
                                    : buttonBackGroundColor2,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.r)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.h, horizontal: 40.w)),
                            child: Text(
                              context.localizations!.logIn,
                              style: TextStyle(
                                  color: authProvider.isLogin
                                      ? buttonColor1
                                      : buttonColor2),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              authProvider.isSignScreen();
                            },
                            style: ElevatedButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                                shadowColor: Colors.transparent,
                                backgroundColor: authProvider.isLogin
                                    ? buttonBackGroundColor2
                                    : buttonBackGroundColor1,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.r)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.h, horizontal: 40.w)),
                            child: Text(
                              context.localizations!.signUp,
                              style: TextStyle(
                                  color: authProvider.isLogin
                                      ? buttonColor2
                                      : buttonColor1),
                            )),
                      ],
                    ),
                  ),
                  largeSpacer,
                  authProvider.isLogin
                      ? LoginWidget(
                          emailController: emailController,
                          passwordController: passwordController,
                          formKey: _formKey,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              authProvider.loginUser({
                                'email': emailController.text,
                                'password': passwordController.text,
                              }, context);
                            }
                          },
                        )
                      : RegisterWidget(
                          emailController: emailController,
                          passwordController: passwordController,
                          confirmPasswordController: confirmPasswordController,
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
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
