import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textFormFieldWidget(
        {required bool outlinedBorder,
        required TextEditingController controller,
        required TextInputType type,
        double? radius = 15,
        Widget? label,
        IconData? prefixIcon,
        IconButton? suffixIcon,
        String? Function(String?)? validate,
        Function? onSubmit,
        Function(String)? onChange,
        void Function(String?)? onSaved,
        bool obscureText = false,
        GestureTapCallback? onTapForm,
        String? hintText,
        bool readOnly = false,
        Color? colors,
        String lableText = '',
        floatingLabelBehavior = FloatingLabelBehavior.always,
        int maxLines = 1}) =>
    TextFormField(
        onSaved: onSaved,
        readOnly: readOnly,
        onChanged: onChange,
        controller: controller,
        keyboardType: type,
        validator: validate,
        maxLines: maxLines,
        obscureText: obscureText,
        onTap: onTapForm,
        decoration: InputDecoration(
          label: label,
          filled: true,
          hintText: hintText,
          floatingLabelBehavior: floatingLabelBehavior,
          fillColor: colors ?? const Color(0xffF7F7FA),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
          border: outlinedBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius!.r)),
                  borderSide: BorderSide.none)
              : UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.r))),
        ));
