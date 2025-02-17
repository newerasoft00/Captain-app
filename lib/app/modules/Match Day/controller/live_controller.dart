import 'dart:async';
import 'package:get/get.dart';
import '../model/live_match_model.dart';
import '../../../data/service/live.dart';

class LiveMatchController extends GetxController {
  final liveMatches = <LiveMatch>[].obs;
  final rliveMatches = <LiveMatch>[].obs;
  final liveMatchesTime = <LiveMatch>[].obs;
  List<Object> matchesWithAd = <Object>[].obs;
  Timer? _updateTimer; // Declare a Timer variable

  @override
  void onInit() {
    super.onInit();
    startTimer();
    fetchLiveMatches();
  }

  void fetchLiveMatches() async {
    final LiveMatchService service = Get.put(LiveMatchService());
    try {
      final matches = await service.getLiveMatches();
      liveMatches.assignAll(matches);
    } catch (e) {
      // print("Error fetching live matches: $e");
    }
  }

  void fetchRpshnLiveMatches() async {
    final LiveMatchService service = Get.put(LiveMatchService());
    try {
      final matches = await service.getRoshnLiveMatches();
      rliveMatches.assignAll(matches);
    } catch (e) {
      // print("Error fetching live matches: $e");
    }
  }

  void startTimer() {
    _updateTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchLiveMatches(); // Fetch and update the eventlivetime
    });
  }

  @override
  void onClose() {
    _updateTimer?.cancel(); // Cancel the timer when the controller is closed
    super.onClose();
  }
}
