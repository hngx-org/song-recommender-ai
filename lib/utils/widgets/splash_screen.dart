import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      final userId = sp.getString('userId');
      if (!context.mounted) return;
      if (userId != null) {
        Navigator.pushReplacementNamed(context, '/chat');
      } else {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    });
    return const Scaffold(
      body: Center(
        child: Text('Song AI splash'),
      ),
    );
  }
}
