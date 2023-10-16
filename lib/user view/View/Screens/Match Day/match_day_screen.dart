import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';

import '../../../Services/Api/live_controller.dart';

class MatchesScreen extends StatelessWidget {
  MatchesScreen({super.key});
  final LiveMatchController controller = Get.put(LiveMatchController());

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
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 2),
                      child: Column(
                        children: [
                          //
                          //
                          //
                          //
                          //
                          Row(
                            children: [
                              4.pw,
                              Expanded(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    width: 30,
                                    height: 30,
                                    imageUrl:
                                        Uri.encodeFull(livematch.leagueLogo),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.blur_on_rounded),
                                  ),
                                ),
                              ),
                              5.pw,
                              Expanded(
                                flex: 7,
                                child: Text(
                                  livematch.leagueName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          5.ph,
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: Uri.encodeFull(
                                            livematch.homeTeamLogo),
                                        width: Get.width * 0.170,
                                        height: Get.width * 0.170,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                      5.ph,
                                      Text(
                                        livematch.eventHomeTeam,
                                        textAlign: TextAlign.center,
                                      ),
                                      5.ph,
                                      Text(
                                        livematch.eventHomeFormation,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: Get.width * 0.105,
                                      height: Get.width * 0.105,
                                      child: FittedBox(
                                        child: Text(
                                          livematch.eventFinalResult,
                                        ),
                                      ),
                                    ),
                                    5.ph,
                                    SizedBox(
                                      width: Get.width * 0.1,
                                      height: Get.width * 0.1,
                                      child: Column(
                                        children: [
                                          (livematch.eventlivetime ==
                                                      'Finished' ||
                                                  livematch.eventlivetime ==
                                                      'Half Time')
                                              ? const SizedBox()
                                              : const LinearProgressIndicator(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                          3.ph,
                                          FittedBox(
                                            child: Text(
                                              livematch.eventlivetime,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: Uri.encodeFull(
                                            livematch.awayTeamLogo),
                                        width: Get.width * 0.170,
                                        height: Get.width * 0.170,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                      5.ph,
                                      FittedBox(
                                        child: Text(
                                          livematch.eventAwayTeam,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      5.ph,
                                      Text(
                                        livematch.eventAwayFormation,
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
                },
              ),
            );
          }
        },
      ),
    );
  }
}
