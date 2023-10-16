import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/User%20View/Controller/bet_controller.dart';
import 'package:sportsbet/user%20view/Controller/Roshn%20Matches/roshn_match_controller.dart';
import 'package:sportsbet/user%20view/View/Screens/Roshn%20Matches/widget/roshn_match_card.dart';
import '../../../../Core/themes/dark_light_theme_file.dart';
import '../../../../Core/themes/theme_controller.dart';
import '../../../../Core/utils/text_style.dart';
import '../../../../Model/Roshn League/game_weak.dart';

class RoshnMatchesPage extends StatefulWidget {
  const RoshnMatchesPage({super.key});

  @override
  State<RoshnMatchesPage> createState() => _RoshnMatchesPageState();
}

class _RoshnMatchesPageState extends State<RoshnMatchesPage> {
  final RoshnMatchController controller = Get.put(RoshnMatchController());
  String selectedRound = 'Round 10'; // Variable to hold the selected round
  ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => controller.roshnFixtures.isEmpty
              ? const SizedBox()
              : Row(
                  children: [
                    SizedBox(
                      height: 32,
                      width: 32,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: CachedNetworkImage(
                          imageUrl: controller.roshnFixtures[0].leagueLogo,
                          width: Get.width * 0.170,
                          height: Get.width * 0.170,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    10.pw,
                    Text(
                      controller.roshnFixtures[0].leagueName.toString(),
                      softWrap: true,
                    ),
                  ],
                ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 8, left: 15),
              child: Obx(() => controller.roshnFixtures.isEmpty
                  ? const SizedBox()
                  : DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20),
                      underline: const SizedBox(),
                      icon: const Icon(
                        Icons.arrow_drop_down_rounded,
                      ),
                      value: selectedRound,
                      enableFeedback: true,
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
                          child: Text(value,
                              softWrap: true,
                              style: Get.isDarkMode
                                  ? CustomTextTheme()
                                      .getDarkTextTheme()
                                      .bodyLarge
                                  : CustomTextTheme().getTextTheme().bodyLarge),
                        );
                      }).toList(),
                    ))),
          10.pw,
        ],
      ),
      body: Obx(
        () {
          if (controller.roshnFixtures.isEmpty) {
            return RefreshIndicator(
                onRefresh: () async {
                  controller.roshnFixtures.clear();
                  controller.fetchData();
                },
                child: Center(
                  child: Image.asset(
                    'assets/Image/loading.png',
                  ),
                ));
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
                    child: Card(child: RoshnMatchCard(fixture: fixture)),
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
