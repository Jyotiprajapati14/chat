import 'package:flutter/material.dart';

class ScrMsgWidget extends StatelessWidget {
  final double height;
  final String msg;
  const ScrMsgWidget(this.msg, {super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Text(
          msg,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1D4380),
          ),
        ),
      ),
    );
  }
}
