import 'package:flutter/material.dart';
import 'package:song_recommender_ai/utils/res/icons.dart';

class Utils {
  static Future<void> showConfirmationDialog(BuildContext context, String title,
      String content, String button, VoidCallback onConfirm) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(
                child: Text(button),
                onPressed: () {
                  // Call the callback function to perform the delete action
                  onConfirm();
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        });
  }

  static PreferredSizeWidget setAppbar(Builder leading, VoidCallback filter) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'SongScript AI',
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
      actions: const [
        /* IconButton(
            onPressed: filter,
            icon: Icon(
              AppIcons.filterIcon,
              color: Colors.black.withOpacity(0.23),
            )) */
      ],
    );
  }
}
