import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productapp/app/app_data.dart';
import 'package:productapp/common/bloc/comman_state.dart';
import 'package:productapp/common/model/credentials_mdl.dart';
import 'package:productapp/route/route_name.dart';
import 'package:productapp/share_pref/share_pref.dart';
import 'package:productapp/share_pref/share_pref_key.dart';

class LoginCubit extends Cubit<CommonState> {
  LoginCubit(this.context) : super(CommonState.initial);
  BuildContext context;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailIdCon = TextEditingController(
    text: 'test@gmail.com',
  );
  TextEditingController passwordCon = TextEditingController(text: '123456');

  Future<void> onContinue() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!formKey.currentState!.validate()) return;
    AppData.credentialsMdl = CredentialsMdl(
      emailId: emailIdCon.text,
      password: passwordCon.text,
    );
    SharePref.inst.setString(
      SharePrefKey.credentials,
      jsonEncode(AppData.credentialsMdl.toJson()),
    );
    Navigator.pushReplacementNamed(context, RouteName.productList);
  }
}
