// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/app/app_data.dart';
import 'package:chat_app/app_services/firebase/firebase_services.dart';
import 'package:chat_app/app_services/firebase/firestore_services.dart';
import 'package:chat_app/common/dialog/dialog_loader.dart';
import 'package:chat_app/features/login/model/user_mdl.dart';
import 'package:chat_app/features/login/widget/phone_number_dialog.dart';
import 'package:chat_app/route/route_name.dart';
import 'package:chat_app/utils/msg.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  String? gender;

  void setGender(String? value) {
    gender = value;
    notifyListeners();
  }

  Future<void> singup(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!formKey.currentState!.validate()) return;
    if (gender == null) {
      toastMsg("Please select gender");
      return;
    }
    dialogLoader(context);
    try {
      final user = UserMdl(
        name: nameCtrl.text.trim(),
        phone: phoneCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        address: addressCtrl.text.trim(),
        gender: gender!,
        fcm: await AppFirebase.fcmToken() ?? "",
      );
      await FirestoreService.inst.signup(user);
      _goToDash(context, user);
    } catch (e) {
      toastMsg("Please try again");
      logError("LoginProvider/Signup", msg: e);
    } finally {
      dialogClose(context);
    }
  }

  Future<void> login(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await showDialog(
      context: context,
      builder: (c) => PhoneNumberDialog(
        provider: this,
        onLogin: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          dialogLoader(context);
          try {
            var userMdl = await FirestoreService.inst.login(
              phoneCtrl.text.trim(),
            );
            dialogClose(context);
            _goToDash(context, userMdl);
          } catch (e) {
            toastMsg("Please try again");
            dialogClose(context);
            logError("LoginProvider/Login", msg: e);
          }
        },
      ),
    );
  }

  void _goToDash(BuildContext context, UserMdl? user) {
    toastMsg("Login success");
    if (user != null) {
      AppData.inst.userMdl = user;
      toastMsg("Login success");
      Navigator.pushReplacementNamed(context, RouteName.dash);
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }
}
