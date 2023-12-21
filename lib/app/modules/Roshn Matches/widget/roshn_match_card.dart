import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/app/utils/Core/helper/empty_padding.dart';
import 'package:sportsbet/app/utils/Core/themes/app_text_theme.dart';
import 'package:sportsbet/app/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
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
          _buildTeamInfo(fixture.eventHomeTeam, fixture.homeTeamLogo,
              isHomeTeam: true),
          _buildMatchInfo(context),
          _buildAwayTeamInfo(
            fixture.eventAwayTeam,
            fixture.awayTeamLogo,
          ),
        ],
      ),
    );
  }

  Widget _buildTeamInfo(String teamName, String teamLogoUrl,
      {bool isHomeTeam = true}) {
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            isHomeTeam ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          const Spacer(),
          CustomText(
            title: teamName,
            style: poppinsMedium.copyWith(
              color: Theme.of(Get.context!).colorScheme.onSurface,
            ),
            wrapWords: true,
            minFontSize: 12,
            maxFontSize: 14,
            overflow: TextOverflow.ellipsis,
          ),
          5.pw,
          CachedNetworkImage(
            imageUrl: Uri.encodeFull(teamLogoUrl),
            width: Get.context!.width * 0.08,
            height: Get.context!.isPortrait
                ? Get.context!.width * 0.1
                : Get.context!.width * 0.05,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator.adaptive()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ],
      ),
    );
  }

  Widget _buildAwayTeamInfo(
    String teamName,
    String teamLogoUrl,
  ) {
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CachedNetworkImage(
            imageUrl: Uri.encodeFull(teamLogoUrl),
            width: Get.context!.width * 0.08,
            height: Get.context!.isPortrait
                ? Get.context!.width * 0.1
                : Get.context!.width * 0.05,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator.adaptive()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          5.pw,
          CustomText(
            title: teamName,
            style: poppinsMedium.copyWith(
              color: Theme.of(Get.context!).colorScheme.onSurface,
            ),
            wrapWords: true,
            minFontSize: 12,
            maxFontSize: 14,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildMatchInfo(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildEventDate(),
          _buildEventResult(context),
        ],
      ),
    );
  }

  Widget _buildEventDate() {
    return fixture.eventLive == '0'
        ? CustomText(
            title: fixture.eventDate,
            style: poppinsMedium.copyWith(
              color: Theme.of(Get.context!).colorScheme.onSurface,
            ),
            minFontSize: 11,
            maxFontSize: 13,
          )
        : Obx(
            () => CustomText(
              title: fixture.eventLive,
              style: poppinsMedium.copyWith(
                color: Theme.of(Get.context!).colorScheme.onSurface,
              ),
              minFontSize: 12,
              maxFontSize: 13,
              wrapWords: true,
            ),
          );
  }

  Widget _buildEventResult(BuildContext context) {
    return fixture.eventFinalResult == "-"
        ? CustomText(
            title: formatTime(fixture.eventTime),
            style: poppinsMedium.copyWith(
              color: Theme.of(Get.context!).colorScheme.onSurface,
            ),
            minFontSize: 16,
            maxFontSize: 17,
          )
        : SizedBox(
            width: Get.width * 0.1,
            height: context.isPortrait
                ? context.width * 0.10
                : context.width * 0.06,
            child: CustomText(
              title: fixture.eventFinalResult,
              style: poppinsMedium.copyWith(
                color: Theme.of(Get.context!).colorScheme.onSurface,
              ),
              minFontSize: 15,
              maxFontSize: 16,
            ),
          );
  }

  String formatTime(String time24Hour) {
    final inputFormat = DateFormat('HH:mm');
    final outputFormat = DateFormat('h:mm a');
    final time = inputFormat.parse(time24Hour);
    return outputFormat.format(time);
  }
}
