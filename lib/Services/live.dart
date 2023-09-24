import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbet/Core/utils/strings.dart';

import '../Model/live matches/live_match_model.dart';

class LiveMatchService extends GetxService {
  final String apiKey =
      "f4b49ee08d7ad55e3e7dd693a36936f79923f8b6902427fb5a806cc3e4e51cc4";
  final String baseUrl =
      "https://apiv2.allsportsapi.com/football/?met=Livescore";

  Future<List<LiveMatch>> getLiveMatches() async {
    final response = await http
        .get(Uri.parse(allsportsapi + liveMatchEndPoint + allsportsapiKey));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> matches = data['result'];
      return matches.map((match) => LiveMatch.fromJson(match)).toList();
    } else {
      throw Exception('Failed to load live matches');
    }
  }
    Future<List<LiveMatch>> getRoshnLiveMatches() async {
    final response = await http
        .get(Uri.parse('$allsportsapi$liveMatchEndPoint$allsportsapiKey&leagueId=278'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> matches = data['result'];
      return matches.map((match) => LiveMatch.fromJson(match)).toList();
    } else {
      throw Exception('Failed to load live matches');
    }
  }
}
