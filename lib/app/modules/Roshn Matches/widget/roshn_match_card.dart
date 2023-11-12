import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sportsbet/app/utils/Core/helper/empty_padding.dart';

import '../model/game_weak.dart';

class RoshnMatchCard extends StatelessWidget {
  const RoshnMatchCard({super.key, required this.fixture});
  final RoshnMatch fixture;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                5.pw,
                AutoSizeText(
                  fixture.eventHomeTeam,
                  textAlign: TextAlign.center,
                  wrapWords: true,
                  minFontSize: 12,
                  maxFontSize: 14,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                CachedNetworkImage(
                  imageUrl: Uri.encodeFull(fixture.homeTeamLogo),
                  width: Get.width * 0.08,
                  height: context.isPortrait
                      ? context.width * 0.1
                      : context.width * 0.05,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                fixture.eventLive == '0'
                    ? AutoSizeText(
                        fixture.eventDate,
                      )
                    : Obx(
                        () => AutoSizeText(
                          fixture.eventLive,
                          minFontSize: 12,
                          maxFontSize: 16,
                          wrapWords: true,
                        ),
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
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CachedNetworkImage(
                  imageUrl: Uri.encodeFull(fixture.awayTeamLogo),
                  width: Get.width * 0.08,
                  height: context.isPortrait
                      ? context.width * 0.1
                      : context.width * 0.05,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const Spacer(),
                AutoSizeText(
                  fixture.eventAwayTeam,
                  textAlign: TextAlign.center,
                  wrapWords: true,
                  minFontSize: 12,
                  maxFontSize: 14,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                5.pw,
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
