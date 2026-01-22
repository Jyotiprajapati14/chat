import 'package:chat_app/features/login/model/user_mdl.dart';

class AppData {
  static final AppData inst = AppData();
  UserMdl userMdl = UserMdl.fromJson({});
}
