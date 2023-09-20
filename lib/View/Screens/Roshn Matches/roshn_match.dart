import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/View/Screens/Roshn%20Matches/widget/roshn_match_card.dart';
import '../../../Controller/Roshn Matches/roshn_match_controller.dart';
import '../../../Controller/bet_controller.dart';
import 'match_details_page.dart';

class RoshnMatchesPage extends StatelessWidget {
  RoshnMatchesPage({super.key});
  final RoshnMatchController controller = Get.put(RoshnMatchController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.roshnFixtures.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              controller.roshnFixtures.clear();
              controller.fetchData();
            },
            child: ListView.builder(
              itemCount: controller.roshnFixtures.length,
              itemBuilder: (context, index) {
                final fixture = controller.roshnFixtures[index];
                return GestureDetector(
                    onTap: () {
                      final BetOptionController betcontroller =
                          Get.put(BetOptionController());
                      betcontroller.betOptions.clear();
                      betcontroller
                          .fetchBetOptions(fixture.hometeamkey.toString());
                      Get.to(MatchDetailsPage(fixture: fixture));
                    },
                    child: RoshnMatchCard(fixture: fixture));
              },
            ),
          );
        }
      },
    );
  }
}
