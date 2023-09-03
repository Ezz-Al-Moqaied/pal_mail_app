import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textFormFieldWidget(
        {required bool outlinedBorder,
        required TextEditingController controller,
        required TextInputType type,
        String? label,
        IconData? prefixIcon,
        IconButton? suffixIcon,
        required String? Function(String?)? validate,
        Function? onSubmit,
        Function? onChange,
        bool obscureText = false,
        GestureTapCallback? onTapForm,
        String? hintText,
        Color? colors,
        floatingLabelBehavior = FloatingLabelBehavior.always,
        int maxLines = 1}) =>
    TextFormField(
        controller: controller,
        keyboardType: type,
        validator: validate,
        maxLines: maxLines,
        obscureText: obscureText,
        onTap: onTapForm,
        decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          floatingLabelBehavior: floatingLabelBehavior,
          fillColor: colors != null ? Colors.white : const Color(0xffF7F7FA),
          label: Text(label ?? ''),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
          border: outlinedBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  borderSide: BorderSide.none)
              : const UnderlineInputBorder(),
        ));
