import 'package:flutter/material.dart';
import 'package:productapp/app/app_data.dart';
import 'package:productapp/common/model/credentials_mdl.dart';
import 'package:productapp/db/db.dart';
import 'package:productapp/db/table_name.dart';
import 'package:productapp/main.dart';
import 'package:productapp/route/route_name.dart';
import 'package:productapp/share_pref/share_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppServices {
  AppServices._();
  static Future<void> appStart() async {
    SharePref.inst.sharePref = await SharedPreferences.getInstance();
    await DB.inst.openDB();
  }

  static Future<void> onLogout() async {
    DB.inst.delete(tableName: TableName.favorites);
    SharePref.inst.clear();
    AppData.credentialsMdl = CredentialsMdl();
    Navigator.pushNamedAndRemoveUntil(
      navigatorKey.currentContext!,
      RouteName.login,
      (route) => route.isCurrent,
    );
  }
}
