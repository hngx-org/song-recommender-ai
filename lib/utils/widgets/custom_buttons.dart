import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      this.color,
      required this.buttonTitle,
      this.onPress,
      this.textStyleColor,
      this.height});

  final Color? color;
  final String buttonTitle;
  final void Function()? onPress;
  final Color? textStyleColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        elevation: 1.0,
        child: MaterialButton(
            onPressed: onPress,
            height: height,
            minWidth: double.infinity,
            child: Text(buttonTitle,
                style: TextStyle(
                    color: textStyleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15))),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}
