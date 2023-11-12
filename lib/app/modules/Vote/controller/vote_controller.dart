import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:get/get.dart';

import '../../../data/service/Vote Services/player_vote_service.dart';

class VoteController extends GetxController {
  final VoteService _voteService = VoteService();
  Rx<DocumentSnapshot?> voteData = Rx<DocumentSnapshot?>(null);
  RxBool isVoteOpen = RxBool(false);
  RxBool isUserVote = false.obs;
  RxList<MapEntry<String, dynamic>> bestPlayers =
      <MapEntry<String, dynamic>>[].obs;
  RxList<dynamic> userVote = <dynamic>[].obs;
  RxMap playerStatistics = {}.obs;
  List<PollOption> pollOptions = [];

  @override
  void onInit() {
    super.onInit();
    _voteService.fetchVoteData(this);
  }

  Future<void> updateUserVote(String selectedOption) async {
    await _voteService.updateUserVote(this, selectedOption);
  }

  Future<void> fetchUserVoteData() async {
    await _voteService.fetchUserVoteData(this);
  }

  void calculatePlayerStatistics(List<dynamic> userVotes) {
    _voteService.calculatePlayerStatistics(this, userVotes);
  }

  bool isUserInUserVote(List<dynamic> userVote, String userId) {
    return _voteService.isUserInUserVote(userVote, userId);
  }
}
