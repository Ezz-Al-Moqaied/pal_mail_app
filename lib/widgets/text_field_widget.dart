import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.errorText,
  });

  final TextEditingController controller;
  final String hintText;
  final String errorText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        controller.text = value;
      },
      onSubmitted: (value) {
        if (value.isEmpty) {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  errorText,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            },
          );
        }
      },
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: textFieldHintColor)),
    );
  }
}
