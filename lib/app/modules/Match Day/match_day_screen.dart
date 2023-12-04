import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  child: Image.asset(
                    'assets/Image/loading.png',
                  ),
                ));
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                controller.liveMatches.clear();
                controller.fetchLiveMatches();
                controller.fetchRpshnLiveMatches();
              },
              child: ListView.builder(
                itemCount: controller.rliveMatches.length +
                    controller.liveMatches.length,
                itemBuilder: (context, index) {
                  final livematch = controller.liveMatches[index];
                  return LiveMatchWidget(livematch: livematch);
                },
              ),
            );
          }
        },
      ),
    );
  }
}

