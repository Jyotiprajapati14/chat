// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productapp/app/app_color.dart';

bool isLive = true;
/*TOAST MESSAGE*/
void msgToast(String value) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: value,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: AppColor.green1,
    textColor: AppColor.white,
    fontSize: 12.0,
  );
}

void msgToastCancel() {
  Fluttertoast.cancel();
}

void msgSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg, style: const TextStyle(color: AppColor.white)),
      duration: const Duration(seconds: 3),
      backgroundColor: AppColor.green1,
    ),
  );
}
