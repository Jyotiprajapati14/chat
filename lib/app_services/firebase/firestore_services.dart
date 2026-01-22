import 'dart:convert';

import 'package:chat_app/app_services/firebase/firebase_services.dart';
import 'package:chat_app/app_services/firebase/firestore_collection.dart';
import 'package:chat_app/features/login/model/user_mdl.dart';
import 'package:chat_app/utils/msg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService inst = FirestoreService();
  final db = FirebaseFirestore.instance;

  Future<bool> signup(UserMdl user) async {
    try {
      await db
          .collection(FirestoreCollection.users)
          .doc(user.phone)
          .set(user.toJson());
      logSuccess("FirestoreService/Signup", msg: jsonEncode(user.toJson()));
      return true;
    } catch (e) {
      logError("FirestoreService/Signup", msg: e);
      return false;
    }
  }

  Future<UserMdl?> login(String phone) async {
    try {
      final data = await db
          .collection(FirestoreCollection.users)
          .doc(phone)
          .get();
      logSuccess("FirestoreService/Login", msg: jsonEncode(data.data()));
      if (!data.exists) {
        toastMsg("User Not Found");
      } else {
        var user = UserMdl.fromJson(data.data()!);
        await _registerFcm(user);
        return UserMdl.fromJson(data.data()!);
      }
    } catch (e) {
      logError("FirestoreService/Login", msg: e);
    }
    return null;
  }

  Future<bool> _registerFcm(UserMdl user) async {
    try {
      user.fcm = await AppFirebase.fcmToken() ?? "";
      await db.collection(FirestoreCollection.users).doc(user.phone).update({
        "fcm": user.fcm,
      });

      return true;
    } catch (e) {
      logError("FirestoreService/_registerFcm", msg: e);
      return false;
    }
  }
}
