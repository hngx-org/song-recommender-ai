import 'package:flutter/material.dart';
import 'package:song_recommender_ai/utils/res/colors.dart';

class SubscribeWarning extends StatefulWidget {
  const SubscribeWarning({super.key});

  @override
  State<SubscribeWarning> createState() => _SubscribeWarningState();
}

class _SubscribeWarningState extends State<SubscribeWarning> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      elevation: 5,
      color: AppColors.aiWidgetColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              'Your credits has been expired. Please subscribe to use SongScript AI\nand keep exploring new music.',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/payment');
                },
                child: const Center(
                    child: Text(
                  'Subscribe',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                )))
          ],
        ),
      ),
    );
  }
}
