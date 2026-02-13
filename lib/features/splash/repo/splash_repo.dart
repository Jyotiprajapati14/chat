// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productapp/app/app_data.dart';
import 'package:productapp/common/model/credentials_mdl.dart';
import 'package:productapp/route/route_name.dart';
import 'package:productapp/share_pref/share_pref.dart';
import 'package:productapp/share_pref/share_pref_key.dart';

class SplashRepo {
  SplashRepo(this.context);
  BuildContext context;
  void goto() async {
    var data = await SharePref.inst.getString(SharePrefKey.credentials);
    if (data.isNotEmpty) {
      AppData.credentialsMdl = CredentialsMdl.fromJson(jsonDecode(data));
    }
    Navigator.pushReplacementNamed(
      context,
      data.isNotEmpty ? RouteName.productList : RouteName.login,
    );
  }
}
