import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/user%20view/Controller/Animation%20Controller/animation_controller.dart';

import '../best_player_screen.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  MyAnimationController c = Get.put(MyAnimationController());

  @override
  void initState() {
    super.initState();
    c.startBannerAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => GestureDetector(
            onTap: () {
              //c.startBannerAnimation();
              Get.to(() => VotePage());
            },
            child: AnimatedContainer(
              onEnd: () {
                c.startBannerAnimation();
              },
              duration: c.bannerDuration,
              height: Get.height * 0.06,
              width: Get.width * 0.55,
              alignment: Alignment.center,
              curve: Curves.linear,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: context.isDarkMode
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).primaryColor,
                  boxShadow: [
                    c.isShadowVisible.value
                        ? BoxShadow(
                            spreadRadius: 0,
                            blurRadius: 0,
                            offset: const Offset(0, 0),
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer)
                        : BoxShadow(
                            spreadRadius: c.isShadowVisible.value ? 5 : 0,
                            blurRadius: 15,
                            offset: const Offset(0, 0),
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer)
                  ]),
              child: Center(
                child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    shadows: [
                      Shadow(
                        blurRadius: 7.0,
                        color: Colors.white,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: AnimatedTextKit(
                    onTap: () => Get.to(() => VotePage()),
                    repeatForever: true,
                    animatedTexts: [
                      FlickerAnimatedText('Choose'.tr),
                      FlickerAnimatedText('Best Player in the Round'.tr),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
