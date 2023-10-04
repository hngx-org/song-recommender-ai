import 'package:flutter/material.dart';
import 'package:song_recommender_ai/features/onboarding/repositories/list_onboard.dart';
import 'package:song_recommender_ai/features/onboarding/views/onboarding_content.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                itemCount: onboardingContent.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemBuilder: (context, index) => OnboardingContent(
                    image: onboardingContent[index].image,
                    title: onboardingContent[index].title,
                    description: onboardingContent[index].description)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return PaymentView();
                      // }));
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400),
                    )),
                const Expanded(child: SizedBox()),
                ...List.generate(
                    onboardingContent.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Indicator(
                            height: height,
                            width: width,
                            isActive: index == _pageIndex,
                          ),
                        )),
                const Expanded(child: SizedBox()),
                TextButton(
                    onPressed: () {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.ease);
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator(
      {super.key,
      required this.height,
      required this.width,
      this.isActive = false});

  final double height;
  final double width;

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: height * 0.012,
      width: width * 0.025,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: isActive ? Colors.black : Colors.grey),
    );
  }
}
