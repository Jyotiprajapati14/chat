import 'package:chat_app/app/app_color.dart';
import 'package:chat_app/app/app_data.dart';
import 'package:chat_app/common/widget/user_hearder_widget.dart';
import 'package:chat_app/features/dash/provider/dash_provider.dart';
import 'package:chat_app/features/login/model/user_mdl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashView extends StatefulWidget {
  const DashView({super.key});

  @override
  State<DashView> createState() => _DashViewState();
}

class _DashViewState extends State<DashView> {
  late final DashProvider provider;

  @override
  void initState() {
    super.initState();
    provider = context.read<DashProvider>();
    provider.usersListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 68,
        backgroundColor: AppColor.blue1,
        leadingWidth: 48,
        iconTheme: const IconThemeData(color: Colors.white),
        title: UserHeaderWidget(user: AppData.inst.userMdl),
      ),
      body: Selector<DashProvider, List<UserMdl>>(
        selector: (context, p) => p.users,
        builder: (context, users, child) {
          if (users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: InkWell(
                  onTap: () => provider.onTapUser(context, users[index]),
                  child: _UserCard(user: users[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final UserMdl user;
  const _UserCard({required this.user});

  Color get genderColor =>
      user.gender.toLowerCase() == 'male' ? AppColor.blue1 : AppColor.pink1;

  String get genderText =>
      user.gender.toLowerCase() == 'male' ? 'Male' : 'Female';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: genderColor.withAlpha(38),
              child: Text(
                user.name[0].toUpperCase(),
                style: TextStyle(
                  color: genderColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.phone,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColor.grey12,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: genderColor.withAlpha(30),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                genderText,
                style: TextStyle(
                  color: genderColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
