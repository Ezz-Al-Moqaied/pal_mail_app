import 'package:flutter/material.dart';

abstract class Styles {
  static OutlineInputBorder primaryRoundedOutlineInputBorder =
  OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: Colors.black,
      width: 2,
    ),
  );
}