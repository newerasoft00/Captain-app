import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../modules/Match Day/model/todays_matches.dart';
import '../../utils/Core/utils/strings.dart';

class ToDaysMatchService {
  String apiUrl = '$allsportsapi$fixturesEndPoint$allsportsapiKey';

  Future<List<ToDaysMatch>> fetchToDaysMatches(String leagueId, String currentDate) async {
    // Append the current date to the apiUrl
    apiUrl += '&from=$currentDate&to=$currentDate&leagueId=$leagueId';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['result']??[];
      return data.map((json) => ToDaysMatch.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load matches');
    }
  }
}
