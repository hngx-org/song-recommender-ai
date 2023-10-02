import 'package:flutter/material.dart';
import 'package:song_recommender_ai/utils/res/icons.dart';

class Utils {
  static PreferredSizeWidget setAppbar(Builder leading, VoidCallback filter) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Music AI',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              color: Color(0xff333333),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Icon(
            AppIcons.waveHandIcon,
            color: Colors.orangeAccent,
            size: 30,
          ),
        ],
      ),
      leading: leading,
      actions: [
        IconButton(
            onPressed: filter,
            icon: Icon(
              AppIcons.filterIcon,
              color: Colors.black.withOpacity(0.23),
            ))
      ],
    );
  }
}
