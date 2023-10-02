import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const AuthButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: 378,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: const Color(0xff2111ad),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}