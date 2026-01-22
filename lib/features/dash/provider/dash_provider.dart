import 'dart:async';

import 'package:chat_app/app/app_data.dart';
import 'package:chat_app/app_services/firebase/firestore_services.dart';
import 'package:chat_app/features/login/model/user_mdl.dart';
import 'package:chat_app/route/route_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashProvider extends ChangeNotifier {
  List<UserMdl> users = [];
  StreamSubscription<QuerySnapshot>? _userSubscription;
  void usersListener() {
    _userSubscription = FirestoreService.inst.db
        .collection('users')
        .snapshots()
        .listen((snapshot) {
          users = snapshot.docs
              .where((doc) => doc.id != AppData.inst.userMdl.phone)
              .map((doc) => UserMdl.fromJson(doc.data()))
              .toList();
          notifyListeners();
        });
  }

  void onTapUser(BuildContext context, UserMdl user) {
    Navigator.pushNamed(context, RouteName.chat, arguments: user);
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
