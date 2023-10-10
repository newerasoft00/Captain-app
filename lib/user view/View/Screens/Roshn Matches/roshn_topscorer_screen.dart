import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/user%20view/Controller/Roshn%20Matches/top_scorer_controller.dart';


class RoshnTopScorersPage extends GetView<TopScorerController> {
  final TopScorerController topScorerController =
      Get.put(TopScorerController());

  RoshnTopScorersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Obx(
        () {
          if (controller.topScorers.isEmpty) {
            if (controller.topScorers.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('No data available'));
            }
          } else {
            return ListView.builder(
              itemCount: topScorerController.topScorers.length,
              itemBuilder: (context, index) {
                final topScorer = topScorerController.topScorers[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Text("${topScorer.playerPlace}"),
                    title: Text(topScorer.playerName),
                    subtitle: Text(topScorer.teamName),
                    trailing: Text('Goals: ${topScorer.goals}'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
