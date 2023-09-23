import 'package:flutter/material.dart';

Widget textFormFieldWidget(
        {required TextEditingController controller,
        required TextInputType type,
        String? label,
        IconButton? prefixIcon,
        IconButton? suffixIcon,
        required String? Function(String?)? validate,
        Function? onSubmit,
        Function? onChange,
        bool obscureText = false,
        GestureTapCallback? onTapForm,
        String? hintText,
        bool readOnly = false,
        Color? colors,
        floatingLabelBehavior = FloatingLabelBehavior.always,
        int maxLines = 1}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validate,
      readOnly: readOnly,
      maxLines: maxLines,
      obscureText: obscureText,
      onTap: onTapForm,
      decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          floatingLabelBehavior: floatingLabelBehavior,
          fillColor: colors != null ? Colors.white : const Color(0xffF7F7FA),
          label: Text(label ?? ''),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide.none)

      ),
    );
