import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthSignUP extends StatefulWidget {
  const AuthSignUP({Key? key}) : super(key: key);

  @override
  _AuthSignUPState createState() => _AuthSignUPState();
}

class _AuthSignUPState extends State<AuthSignUP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    children:[
                     const Text(
                      "Hello there",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8.0,),
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
          Stack(
            children: [
              const Text(
                "Your Email",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                width: 8.17718505859375,
                height: 13.176136016845703,
              ),
              const SizedBox(
                width: 8.17718505859375,
                height: 13.176136016845703,
              ),
              // const Text(
              //   "someuser@gmail.com",
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              const SizedBox(
                width: 378,
                height: 0,
              ),
              Column(
                children: [
                  Container(
                    width: 17.333332061767578,
                    height: 13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Image.asset(
                    "assets/images/Message_light.png",
                    width: 17.333332061767578,
                    height: 4.3333330154418945,
                  ),
                ],
              ),
            ],
          ),
          const Stack(
            children: [
              Text(
                "Create Password",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 378,
                height: 0,
              ),
              Column(
                children: [
                  SizedBox(
                    width: 23.833328247070312,
                    height: 20.583332061767578,
                  ),
                ],
              ),
              Stack(
                children: [
                  SizedBox(
                    width: 7,
                    height: 7,
                  ),
                  SizedBox(
                    width: 7,
                    height: 7,
                  ),
                  SizedBox(
                    width: 7,
                    height: 7,
                  ),
                  SizedBox(
                    width: 7,
                    height: 7,
                  ),
                  SizedBox(
                    width: 7,
                    height: 7,
                  ),
                  SizedBox(
                    width: 7,
                    height: 7,
                  ),
                  SizedBox(
                    width: 7,
                    height: 7,
                  ),
                  SizedBox(
                    width: 7,
                    height: 7,
                  ),
                  SizedBox(
                    width: 7,
                    height: 7,
                  ),
                  SizedBox(
                    width: 7,
                    height: 7,
                  ),
                ],
              ),
            ],
          ),
          const Stack(
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
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
    );
  }
}
