import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Model/Roshn League/game_weak.dart';
import '../../Model/teams/h2h_model.dart';

class MatchDetailsController extends GetxController {
  RxString homeTeamName = RxString('');
  RxString awayTeamName = RxString('');
  RxString eventDate = RxString('');
  RxString eventTime = RxString('');
  RxString homeTeamLogoUrl = RxString('');
  RxString awayTeamLogoUrl = RxString('');
  final matches = <Head2Head>[].obs;

  var roshnFixtures =
      <RoshnMatch>[].obs; // Store the fixtures data as FixtureModel
  final currentDate = DateTime.now().toLocal().toString().split(' ')[0].obs;
  final newDate = DateTime.now().add(const Duration(days: 7));

  // Fetch data from the API
  fetchEventData(String matchID) async {
    final response = await http.get(Uri.parse(
        'https://apiv2.allsportsapi.com/football/?met=Fixtures&matchId=$matchID&APIkey=4abd38c6287c0bc3f1c18342e3e03a57ff8341da2bf330d7de866fba088fc444'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Extract the 'result' data and convert it to a list of FixtureModel
      final resultData = jsonData['result'] as List<dynamic>;
      roshnFixtures.value = resultData
          .map((fixtureJson) => RoshnMatch.fromJson(fixtureJson))
          .toList();
      homeTeamName.value = roshnFixtures[0].eventHomeTeam;
      awayTeamName.value = roshnFixtures[0].eventAwayTeam;
      eventDate.value = roshnFixtures[0].eventDate;
      eventTime.value = roshnFixtures[0].eventKey.toString();
      homeTeamLogoUrl.value = roshnFixtures[0].homeTeamLogo;
      awayTeamLogoUrl.value = roshnFixtures[0].awayTeamLogo;
      print('Away Team Name: ${awayTeamName.value}');
      print('Home Team Name: ${homeTeamName.value}');
      print('Event Date: ${eventDate.value}');
      print('Event Time: ${eventTime.value}');
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  Future<void> fetchH2H() async {
    const url =
        'https://apiv2.allsportsapi.com/football/?met=H2H&APIkey=4abd38c6287c0bc3f1c18342e3e03a57ff8341da2bf330d7de866fba088fc444&firstTeamId=366&secondTeamId=18903'; // Replace with your API endpoint
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final matchesData = jsonData['result']['H2H'] as List;

      final matchesList = matchesData.map((match) {
        return Head2Head.fromJson(match);
      }).toList();

      matches.assignAll(matchesList);
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchH2H();
  }
}
