import 'package:flutter/material.dart';
import 'package:song_recommender_ai/utils/res/colors.dart';

class UserMessage extends StatelessWidget {
  final String? text;
  const UserMessage({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          color: AppColors.userWidgetColor),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 150),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 3,
          top: 8,
        ),
        child: Text(
          text ?? '...',
          style: const TextStyle(
            color: Color(0xffd1d5db),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
