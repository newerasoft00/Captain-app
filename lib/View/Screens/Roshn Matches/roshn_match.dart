import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/View/Screens/Roshn%20Matches/roshn_topscorer_screen.dart';
import 'package:sportsbet/View/Screens/Roshn%20Matches/widget/roshn_match_card.dart';
import '../../../Controller/Roshn Matches/roshn_match_controller.dart';
import '../../../Controller/bet_controller.dart';
import 'match_details_page.dart';
import 'roshn_standings.dart';

class RoshnMatchesPage extends StatelessWidget {
  RoshnMatchesPage({super.key});
  final RoshnMatchController controller = Get.put(RoshnMatchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton.filled(
              color: Colors.white,
              onPressed: () {
                Get.to(() => RoshnStandingsPage());
              },
              icon: const Icon(Icons.list_rounded)),
          10.pw,
          IconButton.filledTonal(
              color: Colors.white,
              onPressed: () {
                Get.to(() => RoshnTopScorersPage());
              },
              icon: const Icon(Icons.sensor_occupied_rounded)),
        ],
      ),
      body: Obx(
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
      ),
    );
  }
}
