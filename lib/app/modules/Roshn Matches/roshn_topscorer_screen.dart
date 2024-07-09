import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:captain/app/modules/Roshn%20Matches/controller/top_scorer_controller.dart';
import 'package:captain/app/utils/Core/helper/empty_padding.dart';
import 'package:captain/app/utils/Core/themes/app_text_theme.dart';
import 'package:captain/app/widgets/custom_text.dart';

class RoshnTopScorersPage extends GetView<TopScorerController> {
  final TopScorerController topScorerController =
      Get.put(TopScorerController());

  RoshnTopScorersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.topScorers.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: topScorerController.topScorers.length,
            itemBuilder: (context, index) {
              final topScorer = topScorerController.topScorers[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  // contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: topScorer.playerPlace < 4
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5),
                    child: Text(
                      "${topScorer.playerPlace}",
                      style: poppinsMedium.copyWith(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  title: CustomText(
                    title: topScorer.playerName,
                  ),
                  subtitle: Text(
                    topScorer.teamName,
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomText(
                        title: 'Goals: ${topScorer.goals}',
                        textColor: Theme.of(context).colorScheme.onSurface,
                      ),
                      5.ph,
                      CustomText(
                        title: 'Assists: ${topScorer.assists}',
                        textColor: Theme.of(context).colorScheme.onSurface,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
