import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:song_recommender_ai/utils/widgets/auth_button.dart';
import 'package:hng_authentication/authentication.dart';
import 'package:hng_authentication/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

class AuthSignUP extends StatefulWidget {
  const AuthSignUP({Key? key}) : super(key: key);

  @override
  _AuthSignUPState createState() => _AuthSignUPState();
}

class _AuthSignUPState extends State<AuthSignUP> {
  bool _isPasswordVisible = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  // final String successRoutePage;
  late Authentication authRepository;

  final logger = Logger();

  @override
  void initState() {
    super.initState();
    authRepository = Authentication(); // Initialize authRepository in initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(
                  width: 18.669641494750977,
                  height: 17.833019256591797,
                ),
                const SizedBox(
                  width: 18.669641494750977,
                  height: 17.833019256591797,
                ),
                const SizedBox(
                  width: 18.669641494750977,
                  height: 17.833019256591797,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      'assets/images/Back.svg',
                      width: 15,
                      height: 15,
                    ),
                  ),
                ),
              ],
            ),
            const Stack(
              children: [
                SizedBox(
                  width: 7.097500324249268,
                  height: 15.84000015258789,
                ),
                SizedBox(
                  width: 24,
                  height: 24,
                ),
              ],
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Text(
                          "Hello there",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        SvgPicture.asset(
                          'assets/images/emoji.svg',
                          width: 15,
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(25.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Please enter you email & password to create an",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "account ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Name",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 8.0,
                  // ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    "Your Email",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 8.0,
                  // ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      suffixIcon: Image.asset(
                        'assets/images/Message_light.png',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    "Create Password",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Image.asset(
                          _isPasswordVisible
                              ? 'assets/images/mdi_eye.png'
                              : 'assets/images/mdi_eye-off.png',
                          width: 10,
                          height: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xff2111ad),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        text: 'I agree to Music AI Public ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'Agreement, Terms and Privacy Policy',
                            style: TextStyle(color: Color(0xff2111ad)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            AuthButton(
                onPressed: () async {
                  final email = emailController.text;
                  final password = passwordController.text;
                  final name = nameController.text;
                  final authRepository = Authentication();

                  // Call the signUp method from the Authentication class
                  try {
                    final user =
                        await authRepository.signUp(email, name, password);
                    if (user != null) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('userEmail', user.email);
                      await prefs.setString('userName', user.name);
                      await prefs.setString('userCookies', '');
                      await prefs.setInt('userCredits', user.credits!);

                      logger.d('Saved user details:');
                      logger.d('User Name: ${prefs.getString('userName')}');
                      logger.d('User Email: ${prefs.getString('userEmail')}');
                      logger
                          .d('User Cookies: ${prefs.getString('userCookies')}');
                      logger.d('User Credits: ${prefs.getInt('userCredits')}');

                      showSnackbar(context, Colors.black, 'SignUp successful');
                      // print('sign up result: >>> $user');
                      print(
                          'sign up result: >>> ${user.id}, ${user.name}, ${user.email}');

                      // Navigate to success page here
                    } else {
                      showSnackbar(context, Colors.red, 'SignUp ERROR');
                    }
                  } catch (e) {
                    // Handle exceptions or errors here
                    if (kDebugMode) {
                      print('Error signing up: $e');
                    }
                    showSnackbar(context, Colors.red,
                        'An error occurred while signing up');
                  }
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )),
            const SizedBox(
              height: 16.0,
            ),
            Stack(
              children: [
                // Your other widgets here
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () {
                      // Handle button press here
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff2111ad),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
