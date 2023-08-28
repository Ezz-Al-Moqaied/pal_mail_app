import 'package:flutter/material.dart';

import '../constants/colors.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    required this.imgPath,
  });
  final String imgPath;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: border),
            color: colorWhite,
            borderRadius: BorderRadius.circular(25)),
        child: Image.asset(
          imgPath,
          fit: BoxFit.contain,
        ));
  }
}
