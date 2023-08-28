import 'package:flutter/material.dart';

Future<Object?> navigatePushReplacementNamed({
  required BuildContext context,
  required String routeName,
}) =>
    Navigator.of(context).pushReplacementNamed(routeName);

Future<Object?> navigatePush({
  required BuildContext context,
  required Widget nextScreen,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );

Future<Object?> navigatePushReplacement({
  required BuildContext context,
  required Widget nextScreen,
}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );

void navigatePop({
  required BuildContext context,
}) =>
    Navigator.pop(context);
