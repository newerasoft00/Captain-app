import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/Model/Roshn%20League/game_weak.dart';

class RoshnMatchController extends GetxController {
  // Define the variables to store the API data
  var roshnFixtures =
      <RoshnMatch>[].obs; // Store the fixtures data as FixtureModel
  final currentDate = DateTime.now().toLocal().toString().split(' ')[0].obs;
  final newDate = DateTime.now().add(const Duration(days: 100));
  final liveMatchesTime = <RoshnMatch>[].obs;
  Timer? _updateTimer; // Declare a Timer variable
  RxString selectedRound = ''.obs;

  // Fetch data from the API
  void fetchData() async {
    final response = await http.get(Uri.parse(UserPreference.getLeagueUrl()));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Extract the 'result' data and convert it to a list of FixtureModel
      final resultData = jsonData['result'] as List<dynamic>;
      roshnFixtures.value = resultData
          .map((fixtureJson) => RoshnMatch.fromJson(fixtureJson))
          .toList();

      // Sort the fixtures by round
      sortFixturesByRound();

      // Find the initial round that hasn't been played yet
      selectedRound.value = findInitialRound();
      if (kDebugMode) {
        print('Initial Round: $selectedRound');
      }
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  void sortFixturesByRound() {
    roshnFixtures.sort((a, b) => a.leagueRound.compareTo(b.leagueRound));
  }

// Find the initial round that hasn't been played yet
  String findInitialRound() {
    for (final fixture in roshnFixtures) {
      if (fixture.eventFinalResult == '-') {
        return fixture.leagueRound;
      }
    }
    return ''; // Return an empty string if all rounds have been played.
  }

  void startTimer() {
    _updateTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchData(); // Fetch and update the event-live-time
    });
  }

  @override
  void refresh() async {
    super.refresh();
    roshnFixtures.clear();
    fetchData();
  }

  @override
  void onInit() async {
    super.onInit();
    fetchData();
    startTimer();
  }

  @override
  void onClose() {
    super.onClose();
    _updateTimer?.cancel();
  }
}
