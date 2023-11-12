import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:get/get.dart';
import '../../../modules/Vote/controller/best_goals_controller.dart';
import '../../../utils/Core/helper/shared_preference/shared_preference.dart';

class GoalsVoteService {
  Future<void> fetchVoteData(VideoController controller) async {
    try {
      final voteDoc = await FirebaseFirestore.instance
          .collection('Vote')
          .doc('goals_vote') // Changed to 'goals_vote'
          .get();

      if (voteDoc.exists) {
        final voteData = voteDoc.data() as Map<String, dynamic>;
        controller.isVoteOpen.value = voteData['vote_open'];

        final bestGoalsMap =
            voteData['best_goals'] as List<dynamic>; // Changed to 'best_goals'
        final votes = voteData['user_vote'] as List<dynamic>;

        controller.bestGoals.assignAll(bestGoalsMap.map((entry) {
          final goal = entry['goal'] as String; // Changed to 'goal'
          final voteCount = entry['vote_count'] as int;
          final url = entry['url'] as String; // Added 'url' as a string

          return MapEntry<String, dynamic>(goal, {
            'vote_count': voteCount,
            'url': url,
          });
        }));

        controller.pollOptions = controller.bestGoals.map((entry) {
          final goal = entry.key;
          final voteCount = entry.value['vote_count'] as int;
// 'url' as a string

          return PollOption(
            id: goal,
            title: AutoSizeText(
              goal,
              wrapWords: true,
              minFontSize: 18,
              maxFontSize: 22,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            votes: voteCount,
          );
        }).toList();
      
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
      VideoController controller, String selectedOption) async {
    if (controller.isVoteOpen.value) {
      final userId = UserPreference.getUserid();
      final userVote = {userId: selectedOption};
      final voteDocRef = FirebaseFirestore.instance
          .collection('Vote')
          .doc('goals_vote'); // Changed to 'goals_vote'
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
        final bestPlayerList =
            voteData['best_goals'] as List<dynamic>; // Changed to 'best_goals'

        if (userVotes.any((vote) => vote is Map && vote.containsKey(userId))) {
          if (kDebugMode) {
            print('User already voted for this round');
          }
          return;
        }

        userVotes.add(userVote);

        final goalName = selectedOption; // Changed to 'goal'
        final goalIndex = bestPlayerList.indexWhere((entry) {
          final goal = entry['goal'] as String; // Changed to 'goal'
          return goal == goalName;
        });

        if (goalIndex != -1) {
          final goalEntry = bestPlayerList[goalIndex] as Map<String, dynamic>;
          final voteCount = goalEntry['vote_count'] as int;
          goalEntry['vote_count'] = voteCount + 1;
        }

        await voteDocRef.update({
          'user_vote': userVotes,
          'best_goals': bestPlayerList, // Changed to 'best_goals'
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

  Future<void> fetchUserVoteData(VideoController controller) async {
    try {
      final voteDoc = await FirebaseFirestore.instance
          .collection('Vote')
          .doc('goals_vote') // Changed to 'goals_vote'
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
      VideoController controller, List<dynamic> userVotes) {
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
