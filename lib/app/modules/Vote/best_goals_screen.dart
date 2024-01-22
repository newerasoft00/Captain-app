import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:captain/app/modules/Vote/widget/buttom_sheet_widget.dart';
import 'package:captain/app/utils/Core/helper/empty_padding.dart';
import 'package:captain/app/utils/Core/themes/app_text_theme.dart';
import 'package:captain/app/widgets/custom_appbar.dart';
import 'package:captain/app/widgets/custom_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'controller/best_goals_controller.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VideoController controller = Get.put(VideoController());
    final playerController = controller.youtubePlayerController;

    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // Specify the allowed orientations for the player
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.landscapeLeft,
        ]);
      },
      player: YoutubePlayer(
        progressIndicatorColor: Colors.red,
        controller: playerController,
        showVideoProgressIndicator: true,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.grey,
        ),
        bottomActions: [
          IconButton(
              onPressed: controller.loadPreviousVideo,
              color: Colors.white,
              icon: const Icon(Icons.skip_previous_rounded)),
          IconButton(
              onPressed: controller.loadNextVideo,
              color: Colors.white,
              icon: const Icon(Icons.skip_next_rounded)),
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
          const PlaybackSpeedButton(),
        ],
        topActions: [
          Expanded(
            child: AutoSizeText(
              playerController.metadata.title,
              minFontSize: 14,
              maxFontSize: 16,
              style: const TextStyle(
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        onReady: () {
          controller.isPlayerReady.value = true;
        },
        onEnded: (data) {
          controller.loadNextVideo();
        },
      ),
      builder: (context, player) => Scaffold(
        appBar: const CustomAppBar(),
        body: ListView(
          children: [
            player,
            40.ph,
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () {
                    showPollBottomSheet(context, controller);
                  },
                  child: CustomText(
                    title: 'Choose Now'.tr,
                    wrapWords: true,
                    style: poppinsMedium.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                    maxFontSize: 18,
                    minFontSize: 16,
                  ),
                )),
            FutureBuilder(
              future: controller.fetchVoteData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Data fetched, so we don't need the loading indicator
                  return const SizedBox();
                } else {
                  // Data is being fetched, show a loading indicator
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
