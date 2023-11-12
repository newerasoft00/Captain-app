import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controller/best_goals_controller.dart';

class VideoListWidget extends StatelessWidget {
  const VideoListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final VideoController controller = Get.put(VideoController());
    final playerController = controller.youtubePlayerController;

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
          controller: playerController,
          showVideoProgressIndicator: true,
          progressColors: const ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
          topActions: [
            const SizedBox(width: 8.0),
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
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 25.0,
              ),
              onPressed: () {
                // Handle settings
              },
            ),
          ],
          onReady: () {
            controller.isPlayerReady.value = true;
          },
          onEnded: controller.onEnded()),
      builder: (context, player) {
        return OrientationBuilder(
          builder: (context, orientation) {
            double aspectRatio =
                orientation == Orientation.portrait ? 16 / 9 : 16 / 9;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: YoutubePlayerBuilder(
                onExitFullScreen: () {
                  // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                  SystemChrome.setPreferredOrientations(
                      DeviceOrientation.values);
                },
                player: YoutubePlayer(
                  controller: playerController,
                  aspectRatio: aspectRatio,
                  showVideoProgressIndicator: true,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
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
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      onPressed: () {
                        // Handle settings
                      },
                    ),
                  ],
                  onReady: () {
                    controller.isPlayerReady.value = true;
                  },
                 
                ),
                builder: (context, player) {
                  return YoutubePlayer(controller: playerController);
                },
              ),
            );
          },
        );
      },
    );
  }
}
