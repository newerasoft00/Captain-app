import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../modules/Match Day/model/live_match_model.dart';
import '../../utils/Core/utils/strings.dart';

class LiveMatchService extends GetxService {
  final String apiKey = allsportsapiKey;
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
    final response = await http.get(Uri.parse(
        '$allsportsapi$liveMatchEndPoint$allsportsapiKey&leagueId=278'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> matches = data['result'];
      return matches.map((match) => LiveMatch.fromJson(match)).toList();
    } else {
      throw Exception('Failed to load live matches');
    }
  }
}
