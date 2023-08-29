import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

flutterToastWidget({
  required String msg,
  Color colors = Colors.red
}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colors,
        textColor: Colors.white,
        fontSize: 15.0);
