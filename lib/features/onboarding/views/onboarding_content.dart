import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height * 0.1,
        ),
        Image.asset(
          image,
          height: height * 0.5,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 30.0),
        ),
        SizedBox(
          height: height * 0.03,
        ),
        Text(description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16.0,
            )),
        const Spacer(),
      ],
    );
  }
}
