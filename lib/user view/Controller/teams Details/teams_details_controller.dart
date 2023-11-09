import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../Model/teams/teams_model.dart';

class TeamsDetailsController extends GetxController {
  var teams = <TeamsDetails>[].obs;

  @override
  void onInit() {
    fetchTeams(); // Fetch data when the controller is initialized
    super.onInit();
  }

  Future<void> fetchTeams() async {
    final response = await http.get(
      Uri.parse('https://apiv2.allsportsapi.com/football/?&met=Teams&APIkey=4abd38c6287c0bc3f1c18342e3e03a57ff8341da2bf330d7de866fba088fc444&leagueId=278'), // Replace with your API endpoint
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['success'] == 1) {
        final resultData = jsonData['result'] as List<dynamic>;

        teams.value = resultData
            .map((teamJson) => TeamsDetails.fromJson(teamJson))
            .toList();
      }
    }
  }
}
