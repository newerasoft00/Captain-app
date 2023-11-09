import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sportsbet/user%20view/View/Screens/on_boarding/controller/page_indecator_controller.dart';
import 'package:sportsbet/user%20view/View/Screens/on_boarding/widget/onboarding_screen_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnBoardingController c = Get.put(OnBoardingController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: context.height * 0.085),
        child: PageView(
          controller: c.controller,
          onPageChanged: c.onPageChanged,
          children: const [
            SizedBox(
              height: double.infinity,
              child: OnBoardingWidget(
                backImage: 'assets/Image/Fill 1.png',
                mainImage: 'assets/Image/illustration111.png',
                title: 'Welcome To Roshan League',
                body: 'Create account with Phone Number or Google account',
              ),
            ),
            SizedBox(
              height: double.infinity,
              child: OnBoardingWidget(
                backImage: 'assets/Image/Mask21.png',
                mainImage: 'assets/Image/Group 168onboarding2.png',
                title: 'Predict the game Score',
                body:
                    'Discover roshan league Matches Round by Round and make a prediction in matches to win',
              ),
            ),
            SizedBox(
              height: double.infinity,
              child: OnBoardingWidget(
                backImage: 'assets/Image/Fill 1.png',
                mainImage: 'assets/Image/Asset 6@3x.png',
                title: 'The Winner',
                body:
                    'User With Most Correct prediction will win the Prize . you can get bet point by predict match final score',
              ),
            ),
            SizedBox(
              height: double.infinity,
              child: OnBoardingWidget(
                backImage: 'assets/Image/Mask21.png',
                mainImage: 'assets/Image/Group 98roshan get started.png',
                title: 'Get Started',
                body: 'Get started and Discover more Fetcher!',
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: const Color(0xFF005048),
        height: context.height * 0.088,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => TextButton(
                  onPressed: () => (c.page.value == 0) ? () {} : c.backButton(),
                  child: (c.page.value == 0)
                      ? const Text('')
                      : const Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                )),
            SmoothPageIndicator(
              effect: const WormEffect(
                  dotColor: Colors.grey, activeDotColor: Colors.yellowAccent),
              controller: c.controller,
              count: 4,
            ),
            Obx(
              () => TextButton(
                  onPressed: () =>
                      (c.page.value == 3) ? c.goButton() : c.nextButton(),
                  child: Text(
                    (c.page.value == 3) ? 'Go' : 'Next',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.w600),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
