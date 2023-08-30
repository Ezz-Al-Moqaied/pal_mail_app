import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/constants/images.dart';
import 'package:pal_mail_app/constants/widget.dart';
import 'package:pal_mail_app/services/localizations_extention.dart';
import 'package:pal_mail_app/widgets/auth_icon_widget.dart';
import 'package:pal_mail_app/widgets/text_field_widget.dart';

class RegisterWidget extends StatelessWidget {
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;
  TextEditingController usernameController;
  VoidCallback? onPressed;
  GlobalKey<FormState> formKey;

  RegisterWidget(
      {Key? key,
      required this.usernameController,
      required this.emailController,
      required this.passwordController,
      required this.confirmPasswordController,
      required this.onPressed,
      required this.formKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          textFormFieldWidget(
            validate: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter the username';
              }
              return null;
            },
            type: TextInputType.text,
            controller: usernameController,
            hintText: "username",
          ),
          smallSpacer,
          textFormFieldWidget(
            validate: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter the email';
              }
              return null;
            },
            type: TextInputType.emailAddress,
            controller: emailController,
            hintText: context.localizations!.emailField,
          ),
          smallSpacer,
          textFormFieldWidget(
            validate: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter the password';
              }
              return null;
            },
            type: TextInputType.visiblePassword,
            controller: passwordController,
            obscureText: true,
            hintText: context.localizations!.passField,
          ),
          smallSpacer,
          textFormFieldWidget(
            validate: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter the confirm password';
              }
              return null;
            },
            type: TextInputType.visiblePassword,
            controller: confirmPasswordController,
            obscureText: true,
            hintText: context.localizations!.confirmPassField,
          ),
          mediumSpacer,
          ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r)),
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 40.w)),
              child: SizedBox(
                  width: double.infinity,
                  child: Center(child: Text(context.localizations!.signUp)))),
          smallSpacer,
          Container(
            alignment: Alignment.center,
            child: Text(
              "OR",
              style: TextStyle(
                  color: textFieldHintColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp),
            ),
          ),
          smallSpacer,
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconWidget(imgPath: Images.faceBook),
              IconWidget(imgPath: Images.twitter),
              IconWidget(imgPath: Images.google),
            ],
          )
        ],
      ),
    );
  }
}
