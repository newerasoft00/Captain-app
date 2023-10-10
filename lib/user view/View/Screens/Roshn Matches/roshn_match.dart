import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/User%20View/Controller/bet_controller.dart';
import 'package:sportsbet/user%20view/Controller/Roshn%20Matches/roshn_match_controller.dart';
import 'package:sportsbet/user%20view/View/Screens/Roshn%20Matches/widget/roshn_match_card.dart';
import '../../../../Model/Roshn League/game_weak.dart';

class RoshnMatchesPage extends StatefulWidget {
  const RoshnMatchesPage({super.key});

  @override
  State<RoshnMatchesPage> createState() => _RoshnMatchesPageState();
}

class _RoshnMatchesPageState extends State<RoshnMatchesPage> {
  final RoshnMatchController controller = Get.put(RoshnMatchController());
  String selectedRound = 'Round 10'; // Variable to hold the selected round

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: context.height * 0.07,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          Card(
            child: Padding(
                padding: const EdgeInsets.only(right: 8, left: 15),
                child: Obx(() => DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20),
                      underline: const SizedBox(),
                      value: selectedRound,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRound = newValue ?? 'Round 10';
                        });
                      },
                      items: getUniqueRounds(controller.roshnFixtures)
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value:
                              value, // Ensure that 'value' matches the selectedRound value
                          child: Text(value),
                        );
                      }).toList(),
                    ))),
          ),
          10.pw,
        ],
      ),
      body: Obx(
        () {
          if (controller.roshnFixtures.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<RoshnMatch> filteredFixtures = controller.roshnFixtures;
            if (selectedRound.isNotEmpty) {
              // Filter fixtures based on the selected round
              filteredFixtures = controller.roshnFixtures
                  .where((fixture) => fixture.leagueRound == selectedRound)
                  .toList();
              filteredFixtures.reversed;
            }

            return RefreshIndicator(
              onRefresh: () async {
                controller.roshnFixtures.clear();
                controller.fetchData();
              },
              child: ListView.builder(
                itemCount: filteredFixtures.length,
                itemBuilder: (context, index) {
                  final fixture = filteredFixtures[index];
                  return GestureDetector(
                    onTap: () async {
                      final BetOptionController betcontroller =
                          Get.put(BetOptionController());
                      betcontroller.selectMatch(fixture);
                    },
                    child: RoshnMatchCard(fixture: fixture),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  // Helper function to get unique rounds from fixtures
  List<String> getUniqueRounds(List<RoshnMatch> fixtures) {
    Set<String> uniqueRounds = <String>{};
    for (final fixture in fixtures) {
      uniqueRounds.add(fixture.leagueRound);
    }

    List<String> sortedRounds = uniqueRounds.toList();
    sortedRounds.sort((a, b) {
      int aIndex = int.tryParse(a.split("Round ")[1]) ?? 0;
      int bIndex = int.tryParse(b.split("Round ")[1]) ?? 0;
      return aIndex.compareTo(bIndex);
    });
    return sortedRounds;
  }
}
