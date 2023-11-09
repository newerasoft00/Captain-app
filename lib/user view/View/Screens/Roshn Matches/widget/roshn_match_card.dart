import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../Model/Roshn League/game_weak.dart';

class RoshnMatchCard extends StatelessWidget {
  const RoshnMatchCard({super.key, required this.fixture});
  final RoshnMatch fixture;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  fixture.eventHomeTeam,
                  textAlign: TextAlign.center,
                ),
                CachedNetworkImage(
                  imageUrl: Uri.encodeFull(fixture.homeTeamLogo),
                  width: Get.width * 0.09,
                  height: context.isPortrait
                      ? context.width * 0.12
                      : context.width * 0.06,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    fixture.eventLive == '0'
                        ? AutoSizeText(
                            fixture.eventDate,
                          )
                        : SizedBox(
                            child: FittedBox(
                                child: Obx(
                              () => Text(
                                fixture.eventLive,
                              ),
                            )),
                          ),
                    fixture.eventFinalResult == "-"
                        ? AutoSizeText(
                            formatTime(fixture.eventTime),
                            softWrap: true,
                          )
                        : SizedBox(
                            width: Get.width * 0.1,
                            height: context.isPortrait
                                ? context.width * 0.10
                                : context.width * 0.06,
                            child: FittedBox(
                              child: Text(
                                fixture.eventFinalResult,
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CachedNetworkImage(
                  imageUrl: Uri.encodeFull(fixture.awayTeamLogo),
                  width: Get.width * 0.09,
                  height: context.isPortrait
                      ? context.width * 0.12
                      : context.width * 0.06,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                FittedBox(
                  child: Text(
                    fixture.eventAwayTeam,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String formatTime(String time24Hour) {
  final inputFormat = DateFormat('HH:mm');
  final outputFormat = DateFormat('h:mm a');
  final time = inputFormat.parse(time24Hour);
  return outputFormat.format(time);
}
