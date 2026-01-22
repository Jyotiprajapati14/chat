// ignore_for_file: deprecated_member_use

import 'package:chat_app/app/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future dialogLoader(BuildContext context, {String title = 'Please wait...'}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SpinKitCircle(color: AppColor.blue1, size: 75),
              if (title.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 13,
                    ).copyWith(decoration: TextDecoration.none),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

void dialogClose(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  }
}
