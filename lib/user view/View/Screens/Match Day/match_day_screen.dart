import 'package:auto_size_text/auto_size_text.dart';
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
                    elevation: 0,
                    color: Theme.of(context).cardColor.withOpacity(0.1),
                    margin: const EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 2, right: 2),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              4.pw,
                              Expanded(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedNetworkImage(
                                    width: 15,
                                    height: 15,
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
                                child: AutoSizeText(
                                  livematch.leagueName,
                                  minFontSize: 10,
                                  maxFontSize: 12,
                                  maxLines: 1,
                                  softWrap: true,
                                  wrapWords: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          10.ph,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Spacer(),
                                      Expanded(
                                        flex: 5,
                                        child: AutoSizeText(
                                          livematch.eventHomeTeam,
                                          minFontSize: 10,
                                          maxFontSize: 14,
                                          maxLines: 2,
                                          softWrap: true,
                                          wrapWords: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      5.pw,
                                      Expanded(
                                        flex: 2,
                                        child: CachedNetworkImage(
                                          imageUrl: Uri.encodeFull(
                                              livematch.homeTeamLogo),
                                          width: Get.width * 0.09,
                                          height: Get.width * 0.09,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      livematch.eventFinalResult,
                                      maxFontSize: 20,
                                      minFontSize: 16,
                                    ),
                                    5.ph,
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.09,
                                          child: (livematch.eventlivetime ==
                                                      'Finished' ||
                                                  livematch.eventlivetime ==
                                                      'Half Time')
                                              ? const SizedBox()
                                              : const LinearProgressIndicator(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                        ),
                                        3.ph,
                                        AutoSizeText(
                                          "${livematch.eventlivetime}'",
                                          softWrap: true,
                                          maxFontSize: 12,
                                          wrapWords: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: CachedNetworkImage(
                                          imageUrl: Uri.encodeFull(
                                              livematch.awayTeamLogo),
                                          width: Get.width * 0.09,
                                          height: Get.width * 0.09,
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator
                                                          .adaptive()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      5.pw,
                                      Expanded(
                                        flex: 5,
                                        child: AutoSizeText(
                                          livematch.eventAwayTeam,
                                          minFontSize: 10,
                                          maxFontSize: 14,
                                          maxLines: 2,
                                          softWrap: true,
                                          wrapWords: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Spacer(
                                        flex: 1,
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
