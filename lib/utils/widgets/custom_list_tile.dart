import 'package:flutter/material.dart';

class PaymentListTile extends StatelessWidget {
  const PaymentListTile({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.check_circle_outline_outlined,
        color: Colors.black,
        size: 20.0,
      ),
      title: Text(title),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      visualDensity: const VisualDensity(vertical: -4.0),
      minLeadingWidth: 10.0,
    );
  }
}
