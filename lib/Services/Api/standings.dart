import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Core/utils/strings.dart';
import '../../Model/teams_standing_model.dart';

class StandingsService {
  static const String apiUrl =
      baseurl + standingEndPoint + apiHeaders + apiToken;

  Future<List<Standingsbondis>> getStandings() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<Standingsbondis> standings = [];

        for (var item in data['data']) {
          standings.add(Standingsbondis.fromJson(item));
        }

        return standings;
      } else {
        throw Exception('Failed to load standings');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
