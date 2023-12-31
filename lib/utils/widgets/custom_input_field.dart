import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({super.key, required this.hintText, this.icon});

  final String hintText;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {},
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.indigo, fontSize: 17.0),
        contentPadding: const EdgeInsets.only(left: 20.0, top: 0, bottom: 0),
        suffixIcon: icon,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide.none
            // disabledBorder: UnderlineInputBorder(
            //     borderSide: BorderSide(color: Colors.indigo, width: 2.0))
            ),
      ),
    );
  }
}
