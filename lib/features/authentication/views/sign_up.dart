import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:song_recommender_ai/utils/widgets/auth_button.dart';

class AuthSignUP extends StatefulWidget {
  const AuthSignUP({Key? key}) : super(key: key);

  @override
  _AuthSignUPState createState() => _AuthSignUPState();
}

class _AuthSignUPState extends State<AuthSignUP> {
  bool _isPasswordVisible = false;
  final TextEditingController _passwordController = TextEditingController();

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
                    controller: TextEditingController(),
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
                    controller: TextEditingController(),
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
                    controller: _passwordController,
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
              height:35.0,
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
                            style: TextStyle(
                              color: Color(0xff2111ad)
                            ),
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
              onPressed: () {

              },
              
              child: const Text(
                  'Continue',
                  style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                )
              ),
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
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),
           Stack(
              children: [
                const SizedBox(
                  width: 117,
                  height: 0,
                ),
                const SizedBox(
                  width: 117,
                  height: 0,
                ),
                const Text(
                  "or continue with",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: 110,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    const Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: 26,
                              height: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      width: 110,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    const Column(
                      children: [
                        Stack(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 29.817768096923828,
                                ),
                                SizedBox(
                                  width: 12.832032203674316,
                                  height: 24.140625,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      width: 110,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    const Column(
                      children: [
                        SizedBox(
                          width: 13.20000171661377,
                          height: 12.91874885559082,
                        ),
                        SizedBox(
                          width: 21.387493133544922,
                          height: 11.13749885559082,
                        ),
                        SizedBox(
                          width: 6.056249141693115,
                          height: 12.350000381469727,
                        ),
                        SizedBox(
                          width: 21.487504959106445,
                          height: 11.13749885559082,
                        ),
                        SizedBox(
                          width: 27.4999942779541,
                          height: 27.4999942779541,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: const Color(0xff2111ad),
                  ),
                ),
                const Column(
                  children: [
                    SizedBox(
                      width: 5.958334445953369,
                      height: 7.041665077209473,
                    ),
                  ],
                ),
                const Text(
                  "I agree to Chatbot_AI  Public Agreement, Terms, & Privacy Policy.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  width: 378,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: const Color(0xff2111ad),
                  ),
                ),
                const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
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
