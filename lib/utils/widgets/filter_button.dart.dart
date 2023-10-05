import 'package:flutter/material.dart';
import 'package:song_recommender_ai/utils/res/colors.dart';

class FilterButtonDart extends StatelessWidget {
  final String content;
  final IconData leadingIcon;

  const FilterButtonDart(
      {Key? key, required this.content, required this.leadingIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              leadingIcon,
              color: AppColors.userWidgetColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              content,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.userWidgetColor),
            )
          ],
        ),
      ),
    );
  }
}
