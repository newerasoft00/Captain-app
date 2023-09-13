import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Controller/bet_controller.dart';
import 'package:sportsbet/Core/helper/shared_preference/shared_preference.dart';
import '../../../Controller/home_controller.dart';
import 'selected_match.dart';
import 'widget/match_card.dart';
import 'widget/select_match_card.dart';

class CurrentMatches extends StatelessWidget {
  const CurrentMatches({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: controller.scores.length,
        itemBuilder: (context, index) {
          String teamName = controller.teamNames[index];

          String score = controller.scores[index];
          return GestureDetector(
            onTap: () async {
              final BetOptionController betOptionController =
                  Get.put(BetOptionController());
              betOptionController.selectedM.value = teamName;
              /*  betOptionController.userbetted.value = await betOptionController
                  .doesMapContainKey(UserPreference.getUserid(),teamName); */
              /* await betOptionController.doesMapContainKey(
                  UserPreference.getUserid(), teamName); */
              betOptionController.betOptions.clear();
              betOptionController.rxBoolList.clear();
              betOptionController.fetchBetOptions(controller.teamNames[index]);
              betOptionController.generateBool();
              //

              Get.to(() => SelectedMatch(
                      homeTeam: teamName,
                      selectedmatch: SelectedMatchCard(
                          teamname1: teamName,
                          score1: score.split('-')[0],
                          score2: score.split('-')[1],
                          teamname2: teamName)))!
                  .then(
                (value) {
                  return betOptionController.doesMapContainKey(
                      UserPreference.getUserid(), teamName);
                },
              );
            },
            child: MatchCard(
              teamname1: teamName,
              score1: score.split('-')[0],
              score2: score.split('-')[1],
              teamname2: teamName,
            ),
          );
        },
      ),
    );
  }
}
