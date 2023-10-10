import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import '../../../../Core/utils/strings.dart';
import '../../../../Model/live matches/live_match_model.dart';
import '../../../../Model/match Day Models/match_day.dart';

class MatchDayService extends GetxController {
  var matches = <MatchDay>[].obs;
    final livematches = <LiveMatch>[].obs;



  Future<void> fetchLiveMatches() async {
    try {
      final response = await http.get(Uri.parse(allsportsapi+liveMatchEndPoint+allsportsapiKey));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final resultData = jsonData['result'];

        // Parse the result data into FootballMatch objects.
        final parsedMatches = resultData
            .map((matchData) => LiveMatch.fromJson(matchData))
            .toList();

        matches.assignAll(parsedMatches);
      } else {
        throw Exception('Failed to load matches');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  void onInit() {
    fetchLiveMatches();
   // fetchMatches(6); // Fetch matches for match day 1 initially
    super.onInit();
  }

/*   void fetchMatchesDay(int matchDay) {
   // fetchMatches(matchDay);
   fr
  } */
}
