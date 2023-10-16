import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/Core/utils/strings.dart';
import 'package:sportsbet/Model/Roshn%20League/game_weak.dart';

class RoshnMatchController extends GetxController {
  // Define the variables to store the API data
  var roshnFixtures =
      <RoshnMatch>[].obs; // Store the fixtures data as FixtureModel
  final currentDate = DateTime.now().toLocal().toString().split(' ')[0].obs;
  final newDate = DateTime.now().add(const Duration(days: 100));
  final liveMatchesTime = <RoshnMatch>[].obs;
  Timer? _updateTimer; // Declare a Timer variable

  // Fetch data from the API
  void fetchData() async {
    final apiURL =
        '$allsportsapi$fixturesEndPoint$allsportsapiKey&from=2023-9-25&to=2024-05-27&leagueId=${UserPreference.getSelectedLeaguekeys()}';
    final response = await http.get(Uri.parse(UserPreference.getLeagueUrl()));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Extract the 'result' data and convert it to a list of FixtureModel
      final resultData = jsonData['result'] as List<dynamic>;
      roshnFixtures.value = resultData
          .map((fixtureJson) => RoshnMatch.fromJson(fixtureJson))
          .toList();
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  void startTimer() {
    _updateTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchData(); // Fetch and update the eventlivetime
    });
  }

  @override
  void refresh() async {
    super.refresh();
    roshnFixtures.clear();
    fetchData();
  }

  @override
  void onInit() {
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
