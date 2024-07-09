import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:captain/app/widgets/custom_loader.dart';
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
        // centerTitle: true,
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
                  child: CustomLoader(
                imagePath: 'assets/Image/no_live_match.json',
                sizeW: context.width * 0.5,
                sizeH: context.height * 0.3,
              )),
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
                  }),
            );
          }
        },
      ),
      // bottomNavigationBar: const CustomAdBanner(),
    );
  }
}
