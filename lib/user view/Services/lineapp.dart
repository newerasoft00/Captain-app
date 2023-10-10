import 'package:http/http.dart' as http;

class FootballApiClient {
  static const String _baseUrl = "https://v3.football.api-sports.io";
  static const String _apiKey = "9bf61bf6a9debe57ccc360059786f6ef";

  Future<String> getLineups() async {
    final url = Uri.parse("$_baseUrl/fixtures/lineups?fixture=592872");
    final headers = {
      'x-rapidapi-host': "v3.football.api-sports.io",
      'x-rapidapi-key': _apiKey,
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch lineups');
    }
  }
}
