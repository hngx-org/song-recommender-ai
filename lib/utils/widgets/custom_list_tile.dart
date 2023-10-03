import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatelessWidget {
  const CustomCheckboxListTile(
      {super.key, required this.title, required this.icon});
  //
  final Widget icon;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: false,
      onChanged: (value) {},
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.black)),
      checkboxShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: title,
      secondary: icon,
    );
  }
}
