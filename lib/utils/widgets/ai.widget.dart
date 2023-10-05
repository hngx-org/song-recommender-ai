import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:song_recommender_ai/utils/res/colors.dart';

class AiMessage extends StatelessWidget {
  final String? text;
  final bool shouldAnimate;
  final ScrollController scrollController;
  const AiMessage({
    Key? key,
    this.text,
    required this.shouldAnimate,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: AppColors.aiWidgetColor,
      ),
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    if (text == "") {
                      if (kDebugMode) {
                        print('enter text');
                      }
                    } else {
                      if (kDebugMode) {
                        print(text);
                      }
                      FlutterClipboard.copy(text.toString()).then((value) {
                        if (kDebugMode) {
                          print('copied');
                        }
                      });
                    }
                  },
                  icon: const Icon(Icons.content_copy))),
          Flexible(
            fit: FlexFit.loose,
            flex: 5,
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Color(0xff333333),
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
              child: shouldAnimate
                  ? AnimatedTextKit(
                      key: UniqueKey(),
                      animatedTexts: [TypewriterAnimatedText(text.toString())],
                      // isRepeatingAnimation: false,
                      totalRepeatCount: 1,
                      onFinished: () {
                        scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 10),
                            curve: Curves.fastEaseInToSlowEaseOut);
                      },
                    )
                  : Text(text.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
