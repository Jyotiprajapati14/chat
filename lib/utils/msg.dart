// ignore_for_file: avoid_print
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastMsg(String value) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: value,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 12.0,
  );
}

toastMsgCancel() {
  Fluttertoast.cancel();
}

void logError(String name, {String type = '', required dynamic msg}) {
  log(
    '\x1B[31m$type${type.isNotEmpty ? ':' : ''}$msg\x1B[0m',
    name: '\x1B[37m$name\x1B[0m',
  );
}

void logInfo(String name, {String type = '', required dynamic msg}) {
  log(
    '\x1B[33m$type${type.isNotEmpty ? ':' : ''}$msg\x1B[0m',
    name: '\x1B[37m$name\x1B[0m',
  );
}

void logSuccess(String name, {String type = '', required dynamic msg}) {
  log(
    '\x1B[32m$type${type.isNotEmpty ? ':' : ''}$msg\x1B[0m',
    name: '\x1B[37m$name\x1B[0m',
  );
}
