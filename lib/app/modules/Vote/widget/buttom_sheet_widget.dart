import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:get/get.dart';
import 'package:sportsbet/app/modules/Vote/controller/best_goals_controller.dart';
import 'package:sportsbet/app/utils/Core/helper/empty_padding.dart';

void showPollBottomSheet(
    BuildContext context, VideoController videoController) {
  // Check if data is available before showing the bottom sheet
  if (videoController.bestGoals.isEmpty) {
    // Data is not available yet, show a loading indicator
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator.adaptive());
      },
    );
  } else {
    // Data is available, build the bottom sheet with the data
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() => FlutterPolls(
                pollId: '1',
                pollEnded: videoController.isUserVote.value,
                onVoted: (PollOption pollOption, int newTotalVotes) async {
                  try {
                    videoController.updateUserVote(pollOption.id.toString());
                    // After voting, fetch the updated user vote data
                    await videoController.fetchUserVoteData();
                    if (kDebugMode) {
                      print('Voted: ${pollOption.id}');
                    }
                    return true; // Return true to indicate a successful vote
                  } catch (e) {
                    if (kDebugMode) {
                      print('Error updating user vote: $e');
                    }
                    return false; // Return false to indicate an unsuccessful vote
                  }
                },
                pollOptionsFillColor:
                    Theme.of(context).primaryColor.withOpacity(0.09),
                pollOptionsSplashColor: Colors.white,
                votedProgressColor: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.7),
                heightBetweenOptions: context.height * 0.02,
                votedBackgroundColor: Colors.grey.withOpacity(0.2),
                votesTextStyle: const TextStyle(fontSize: 16),
                pollOptionsBorder: Border.all(
                    color: Theme.of(context).cardColor.withOpacity(0.2)),
                votedPercentageTextStyle: const TextStyle(
                  fontSize: 16,
                ),
                votedCheckmark: const Icon(
                  Icons.check_circle,
                  color: Colors.black,
                  size: 20,
                ),
                pollTitle: Center(
                  child: AutoSizeText(
                    'Choose the best Goal'.tr, // Your poll title here
                    wrapWords: true,
                    maxLines: 2,
                    minFontSize: 20,
                    maxFontSize: 22,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                pollOptions: videoController.pollOptions,
                metaWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    10.pw,
                    Obx(
                      () => Row(
                        children: [
                          CircleAvatar(
                            radius: context.width * 0.012,
                            backgroundColor: videoController.isVoteOpen.value
                                ? Colors.greenAccent
                                : Colors.redAccent,
                          ),
                          5.pw,
                          AutoSizeText(
                            videoController.isVoteOpen.value
                                ? 'open'.tr
                                : 'Closed'.tr,
                            wrapWords: true,
                            minFontSize: 16,
                            maxLines: 1,
                            maxFontSize: 20,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
