import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class TypewriterLoading extends StatelessWidget {
  const TypewriterLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontSize: 20.0),
      child: AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText('Loading...',
              speed: const Duration(milliseconds: 50)),
        ],
        isRepeatingAnimation: true,
      ),
    );
  }
}
