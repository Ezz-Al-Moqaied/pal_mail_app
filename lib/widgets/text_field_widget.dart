import 'package:flutter/material.dart';

Widget textFormFieldWidget(
        {required TextEditingController controller,
        required TextInputType type,
        String? label,
        IconData? prefixIcon,
        IconButton? suffixIcon,
        double? numfontSize,
        required String? Function(String?)? validate,
        Function? onSubmit,
        Function? onChange,
        bool obscureText = false,
        GestureTapCallback? onTapForm,
        required BorderSide borderSide,
        required BorderRadius borderRadius,
        String? hintText,
        Color? colors,
        floatingLabelBehavior = FloatingLabelBehavior.always,
        int maxLines = 1}) =>
    TextFormField(
      style: TextStyle(
        fontSize: numfontSize,
      ),
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
          fillColor: colors != null ? Colors.white : Colors.white,
          label: Text(label ?? ''),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderRadius: borderRadius, borderSide: borderSide)),
    );
