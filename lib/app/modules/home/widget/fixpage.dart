import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FootballFixturesController extends GetxController {
  var fixtures = [].obs; // Initialize an empty list to store fixtures.

  @override
  void onInit() {
    super.onInit();
    fetchFixtures(); // Fetch fixtures when the controller is initialized.
  }

  Future<void> fetchFixtures() async {
    final response = await http.get(Uri.parse(
        'https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=6e7ced070587451817c2a76b192351fddec0d214158e7ec75da6fd8b3e9506ac&from=2023-08-11&to=2024-05-27&leagueId=278'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      //final Map<String, dynamic> data = json.decode(response.body);

      final List<dynamic> fixturesData = jsonData['data']['fixtures'];
      fixtures.assignAll(fixturesData);
    } else {
      // Handle errors here.
      if (kDebugMode) {
        print('Failed to load fixtures');
      }
    }
  }
}

class FixturesPage extends StatelessWidget {
  final controller = Get.put(FootballFixturesController());

  FixturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Fixtures'),
      ),
      body: Obx(() {
        if (controller.fixtures.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // Sort fixtures by round.
          controller.fixtures
              .sort((a, b) => a['league_round'].compareTo(b['league_round']));

          // Find the initial round that hasn't been played yet.
          for (final fixture in controller.fixtures) {
            if (fixture['event_final_result'] == '-') {
              break;
            }
          }

          // Now you can display the fixtures and initial round.
          return ListView.builder(
            itemCount: controller.fixtures.length,
            itemBuilder: (context, index) {
              final fixture = controller.fixtures[index];
              return ListTile(
                title: Text(
                    '${fixture['event_home_team']} vs ${fixture['event_away_team']}'),
                subtitle: Text('Round: ${fixture['league_round']}'),
              );
            },
          );
        }
      }),
    );
  }
}
