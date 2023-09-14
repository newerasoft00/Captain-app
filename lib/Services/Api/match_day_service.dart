import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import '../../Model/match Day Models/match_day.dart';

class MatchDayService extends GetxController {
  var matches = <MatchDay>[].obs;

  Future<void> fetchMatches(int matchDay) async {
  const url = 'https://api.openligadb.de/getmatchdata/bl1/2023/2';
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<MatchDay> loadedMatches = data
          .map((json) => MatchDay.fromJson(json))
          .where((match) => match.matchResults != []) // Filter matches with matchResults
          .toList();
      matches.value = loadedMatches;
    } else {
      throw Exception('Failed to load match data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to connect to the API');
  }
}



  @override
  void onInit() {
    fetchMatches(6); // Fetch matches for match day 1 initially
    super.onInit();
  }

  void fetchMatchesDay(int matchDay) {
    fetchMatches(matchDay);
  }
}
