import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sportsbet/Core/utils/strings.dart';
import '../../../../Model/match Day Models/todays_matches.dart';

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
