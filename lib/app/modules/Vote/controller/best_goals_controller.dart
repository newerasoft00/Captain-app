import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:get/get.dart';
import 'package:sportsbet/app/data/service/Vote%20Services/goals_vote_services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoController extends GetxController {
  final GoalsVoteService _voteService = GoalsVoteService();

  Rx<DocumentSnapshot?> voteData = Rx<DocumentSnapshot?>(null);
  RxBool isVoteOpen = RxBool(false);
  RxBool isUserVote = false.obs;
  RxList<MapEntry<String, dynamic>> bestGoals =
      <MapEntry<String, dynamic>>[].obs;
  RxList<dynamic> userVote = <dynamic>[].obs;
  RxMap playerStatistics = {}.obs;
  List<PollOption> pollOptions = [];
  final List<String> _urls = [];

  late YoutubePlayerController youtubePlayerController =
      YoutubePlayerController(
    initialVideoId:
        YoutubePlayer.convertUrlToId('https://youtu.be/NYx3RG2m1fk') ??
            'https://youtu.be/NYx3RG2m1fk',
    flags: const YoutubePlayerFlags(
      mute: false,
      autoPlay: true,
      controlsVisibleAtStart: false,
      disableDragSeek: false,
      loop: false,
      isLive: false,
      forceHD: false,
      enableCaption: true,
    ),
  );

  final isPlayerReady = false.obs;

  int _currentIndex = 0;

  @override
  void onInit() async {
    super.onInit();
    await fetchVoteData();
    youtubePlayerController;
  }

  @override
  void onClose() {
    youtubePlayerController.dispose();
    super.onClose();
  }

  void loadNextVideo() {
    if (_currentIndex < _urls.length - 1) {
      _currentIndex++;
      final videoId = YoutubePlayer.convertUrlToId(_urls[_currentIndex]);
      if (videoId != null) {
        youtubePlayerController.load(videoId);
      }
    }
  }

  void loadPreviousVideo() {
    if (_currentIndex > 0) {
      _currentIndex--;
      final videoId = YoutubePlayer.convertUrlToId(_urls[_currentIndex]);
      if (videoId != null) {
        youtubePlayerController.load(videoId);
      }
    }
  }

  void initializeVideo() {
    if (_currentIndex < _urls.length) {
      final videoId = YoutubePlayer.convertUrlToId(_urls[_currentIndex]);
      if (videoId != null) {
        youtubePlayerController.load(videoId);
      }
    }
  }

  onEnded() {
    loadNextVideo();
  }

  Future<void> updateUserVote(String selectedOption) async {
    await _voteService.updateUserVote(this, selectedOption);
  }

  Future<void> fetchVoteData() async {
    await _voteService.fetchVoteData(this);
    _urls.clear();
    _urls.addAll(bestGoals.map((entry) => entry.value['url'].toString()));
    update();
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
