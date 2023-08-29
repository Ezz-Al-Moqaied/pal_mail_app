import 'package:flutter/material.dart';

Widget textFormFieldWidget(
        {required TextEditingController controller,
        required TextInputType type,
        String? label,
        IconData? prefixIcon,
        IconButton? suffixIcon,
        required String? Function(String?)? validate,
        Function? onSubmit,
        Function? onChange,
        bool obscureText = false,
        GestureTapCallback? onTapForm,
          required BorderSide borderSide,
          required BorderRadius borderRadius,
        String? hintText,
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
          fillColor: const Color(0xffF7F7FA),
          label: Text(label ?? ''),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
          border:  OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: borderSide)),
    );



