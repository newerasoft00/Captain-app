import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:captain/app/modules/Animation%20Controller/animation_controller.dart';
import 'package:captain/app/modules/Roshn%20Matches/controller/roshn_match_controller.dart';
import 'package:captain/app/modules/Vote/best_goals_screen.dart';
import 'package:captain/app/modules/Vote/widget/animated_icon_button.dart';
import 'package:captain/app/utils/Core/helper/empty_padding.dart';
import 'package:captain/app/widgets/custom_loader.dart';
import '../../../../app/modules/Vote/widget/banner_widget.dart';
import '../../utils/Core/themes/theme_controller.dart';
import 'controller/bet_controller.dart';
import 'model/game_weak.dart';
import 'widget/roshn_match_card.dart';

class RoshnMatchesPage extends StatefulWidget {
  const RoshnMatchesPage({super.key});

  @override
  State<RoshnMatchesPage> createState() => _RoshnMatchesPageState();
}

class _RoshnMatchesPageState extends State<RoshnMatchesPage> {
  RoshnMatchController controller = Get.find();
  ThemeController themeController = Get.find();
  MyAnimationController ac = Get.find();

  @override
  Widget build(BuildContext context) {
    getUniqueRounds(controller.roshnFixtures);
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
                        Icons.arrow_drop_down_circle,
                        color: Colors.white,
                      ),
                      // value:controller. selectedRound.value,
                      enableFeedback: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          controller.selectedRound.value = newValue!;
                        });
                      },
                      items: getUniqueRounds(controller.roshnFixtures)
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          // Ensure that 'value' matches the selectedRound value
                          child: Text(value,
                              softWrap: true,
                              style: Theme.of(context).textTheme.bodyLarge),
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
                child: const Center(child: CustomLoader()));
          } else {
            List<RoshnMatch> filteredFixtures = controller.roshnFixtures;
            if (controller.selectedRound.value.isNotEmpty) {
              // Filter fixtures based on the selected round
              filteredFixtures = controller.roshnFixtures
                  .where((fixture) =>
                      fixture.leagueRound == controller.selectedRound.value)
                  .toList();
              filteredFixtures.reversed;
            }
            return Column(
              children: [
                SizedBox(
                  width: context.width,
                  height: context.height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const BannerWidget(),
                      CustomCardButton(
                        onTap: () => Get.to(() => const VideoScreen()),
                        width: context.width * 0.3,
                        height: Get.height * 0.06,
                      )
                      //const BannerWidget(),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.roshnFixtures.clear();
                      controller.fetchData();
                    },
                    child: SizedBox(
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
                            child: Card(
                                elevation: 0,
                                child: RoshnMatchCard(fixture: fixture)),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
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
