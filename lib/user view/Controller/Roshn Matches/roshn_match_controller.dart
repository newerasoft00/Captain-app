import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import 'package:sportsbet/Core/utils/strings.dart';
import 'package:sportsbet/Model/Roshn%20League/game_weak.dart';

class RoshnMatchController extends GetxController {
  // Define the variables to store the API data
  var roshnFixtures =
      <RoshnMatch>[].obs; // Store the fixtures data as FixtureModel
  final currentDate = DateTime.now().toLocal().toString().split(' ')[0].obs;
  final newDate = DateTime.now().add(const Duration(days: 100));

  // Fetch data from the API
  void fetchData() async {
    final apiURL =
      '$allsportsapi$fixturesEndPoint$allsportsapiKey&from=${currentDate.value}&to=2024-05-27&leagueId=${UserPreference.getSelectedLeaguekeys()}';
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

  @override
  void refresh() async {
    super.refresh();
    roshnFixtures.clear();
    fetchData();
  }

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
}
