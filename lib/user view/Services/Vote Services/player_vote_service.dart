import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:get/get.dart';

import '../../../Core/helper/shared_preference/shared_preference.dart';
import '../../Controller/Vote controller/vote_controller.dart';

class VoteService {
  Future<void> fetchVoteData(VoteController controller) async {
    try {
      final voteDoc = await FirebaseFirestore.instance
          .collection('Vote')
          .doc('Vote_options')
          .get();

      if (voteDoc.exists) {
        final voteData = voteDoc.data() as Map<String, dynamic>;
        controller.isVoteOpen.value = voteData['vote_open'];

        final bestPlayerMap = voteData['best_player'] as List<dynamic>;
        final votes = voteData['user_vote'] as List<dynamic>;

        if (bestPlayerMap != null) {
          controller.bestPlayers.assignAll(bestPlayerMap.map((entry) {
            final player = entry['player'] as String;
            final voteCount = entry['vote_count'];
            if (voteCount is int) {
              return MapEntry<String, int>(player, voteCount);
            } else if (voteCount is String) {
              final parsedVoteCount = int.tryParse(voteCount);
              if (parsedVoteCount != null) {
                return MapEntry<String, int>(player, parsedVoteCount);
              }
            }

            return MapEntry<String, int>(player, 0);
          }));

          controller.pollOptions = controller.bestPlayers.map((entry) {
            final player = entry.key;
            final voteCount = entry.value;
            return PollOption(
              id: player,
              title: AutoSizeText(
                player,
                wrapWords: true,
                minFontSize: 18,
                maxFontSize: 22,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              votes: voteCount,
            );
          }).toList();
        }

        if (votes.isNotEmpty) {
          controller.userVote.assignAll(votes);
          final userId = UserPreference.getUserid();
          bool userExistsInVote = isUserInUserVote(votes, userId);
          controller.isUserVote.value = userExistsInVote;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching vote data: $e');
      }
    }
  }

  Future<void> updateUserVote(
      VoteController controller, String selectedOption) async {
    if (controller.isVoteOpen.value) {
      final userId = UserPreference.getUserid();
      final userVote = {userId: selectedOption};
      final voteDocRef =
          FirebaseFirestore.instance.collection('Vote').doc('Vote_options');
      final voteDoc = await voteDocRef.get();

      try {
        if (!voteDoc.exists) {
          if (kDebugMode) {
            print('Vote document not found');
          }
          return;
        }
        final voteData = voteDoc.data() as Map<String, dynamic>;
        final userVotes = voteData['user_vote'] as List<dynamic>;
        final bestPlayerList = voteData['best_player'] as List<dynamic>;

        if (userVotes.any((vote) => vote is Map && vote.containsKey(userId))) {
          if (kDebugMode) {
            print('User already voted for this round');
          }
          return;
        }

        userVotes.add(userVote);

        final playerName = selectedOption;
        final playerIndex = bestPlayerList.indexWhere((entry) {
          final player = entry['player'] as String;
          return player == playerName;
        });

        if (playerIndex != -1) {
          final playerEntry =
              bestPlayerList[playerIndex] as Map<String, dynamic>;
          final voteCount = playerEntry['vote_count'] as int;
          bestPlayerList[playerIndex]['vote_count'] = voteCount + 1;
        }

        await voteDocRef.update({
          'user_vote': userVotes,
          'best_player': bestPlayerList,
        });

        if (kDebugMode) {
          print(bestPlayerList);
          print(userVotes);
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error updating user vote: $e');
        }
      }
    }
    controller.update();
  }

  Future<void> fetchUserVoteData(VoteController controller) async {
    try {
      final voteDoc = await FirebaseFirestore.instance
          .collection('Vote')
          .doc('Vote_options')
          .get();

      if (voteDoc.exists) {
        final voteData = voteDoc.data() as Map<String, dynamic>;
        final userVotes = voteData['user_vote'] as List<dynamic>;

        if (userVotes.isNotEmpty) {
          controller.calculatePlayerStatistics(userVotes);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user_vote data: $e');
      }
    }
  }

  void calculatePlayerStatistics(
      VoteController controller, List<dynamic> userVotes) {
    controller.playerStatistics.clear();

    for (var userVote in userVotes) {
      if (userVote is Map<String, dynamic> && userVote.length == 1) {
        final playerName = userVote.values.first.toString();

        if (controller.playerStatistics.containsKey(playerName)) {
          controller.playerStatistics[playerName] =
              controller.playerStatistics[playerName]! + 1;
        } else {
          controller.playerStatistics[playerName] = 1;
        }
      }
    }

    controller.playerStatistics.forEach((player, count) {
      if (kDebugMode) {
        print('$player: $count appearances');
      }
    });
  }

  bool isUserInUserVote(List<dynamic> userVote, String userId) {
    for (var vote in userVote) {
      if (vote is Map && vote.containsKey(userId)) {
        return true;
      }
    }
    return false;
  }
}
