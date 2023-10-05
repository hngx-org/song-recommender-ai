import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:io';

class PaymentViewModel extends ChangeNotifier {
  // final String _os = Platform.operatingSystem;
  // get os => _os;

  final int _amountToPay = 3;
  get amountToPay => _amountToPay;

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();
    return userId;
  }
}
