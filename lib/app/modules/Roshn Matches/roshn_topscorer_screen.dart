import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/app/modules/Roshn%20Matches/controller/top_scorer_controller.dart';
import 'package:sportsbet/app/widgets/custom_text.dart';

class RoshnTopScorersPage extends GetView<TopScorerController> {
  final TopScorerController topScorerController =
      Get.put(TopScorerController());

  RoshnTopScorersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
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
              return Column(
                children: [
                  ListTile(
                    leading: CustomText(
                      title: "${topScorer.playerPlace}",
                      textColor: Theme.of(Get.context!).colorScheme.onSurface,
                    ),
                    title: Text(topScorer.playerName),
                    subtitle: Text(topScorer.teamName),
                    trailing: CustomText(
                      title: 'Goals: ${topScorer.goals}',
                      textColor: Theme.of(Get.context!).colorScheme.onSurface,
                    ),
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                  )
                ],
              );
            },
          );
        }
      },
    );
  }
}
