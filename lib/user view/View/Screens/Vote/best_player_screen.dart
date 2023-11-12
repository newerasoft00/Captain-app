import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';

import '../../../Controller/Vote controller/vote_controller.dart';

class VotePage extends StatelessWidget {
  final VoteController voteController = Get.put(VoteController());
  VotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        if (voteController.bestPlayers.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(() => FlutterPolls(
                  pollId: '1',
                  pollEnded: voteController.isUserVote.value,
                  onVoted: (PollOption pollOption, int newTotalVotes) async {
                    try {
                      voteController.updateUserVote(pollOption.id.toString());
                      // After voting, fetch the updated user vote data
                      await voteController.fetchUserVoteData();
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
                  votedProgressColor: Colors.teal.withOpacity(0.4),
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
                  pollTitle: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      'Choose the best player'.tr, // Your poll title here
                      wrapWords: true,
                      maxLines: 2,
                      minFontSize: 20,
                      maxFontSize: 22,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  pollOptions: voteController.pollOptions,
                  metaWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      10.pw,
                      Obx(
                        () => Row(
                          children: [
                            CircleAvatar(
                              radius: context.width * 0.012,
                              backgroundColor: voteController.isVoteOpen.value
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                            ),
                            5.pw,
                            AutoSizeText(
                              voteController.isVoteOpen.value
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
        }
      }),
    );
  }
}
