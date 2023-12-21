import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/Core/themes/app_text_theme.dart';
import '../Roshn Matches/widget/banner_ad_widget.dart';
import 'controller/live_controller.dart';
import 'widget/live_match_widget.dart';

class MatchesScreen extends StatelessWidget {
  MatchesScreen({super.key});
  final LiveMatchController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Match'.tr),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.liveMatches.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.liveMatches.clear();
                controller.fetchLiveMatches();
              },
              child: Center(
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    FlickerAnimatedText('No Live Match'.tr,
                        textStyle: poppinsMedium.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary)),
                    FlickerAnimatedText('Wait'.tr,
                        textStyle: poppinsMedium.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary)),
                  ],
                ),
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                controller.liveMatches.clear();
                controller.fetchLiveMatches();
                controller.fetchRpshnLiveMatches();
              },
              child: ListView.separated(
                  itemCount: controller.rliveMatches.length +
                      controller.liveMatches.length,
                  itemBuilder: (context, index) {
                    final livematch = controller.liveMatches[index];
                    return LiveMatchWidget(livematch: livematch);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 5,
                    );
                  }
                  // if (index % 8 == 0) {
                  //   return const Card(
                  //     elevation: 0.5,
                  //     child: Padding(
                  //       padding: EdgeInsets.all(2),
                  //       child: BannerAdWidget(),
                  //     ),
                  //   );
                  // } else {
                  //  return const SizedBox(
                  //     height: 5,
                  //   );
                  // }

                  ),
            );
          }
        },
      ),
    );
  }
}
