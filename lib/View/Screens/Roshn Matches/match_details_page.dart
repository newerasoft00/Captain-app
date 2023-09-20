import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';
import 'package:sportsbet/Model/Roshn League/game_weak.dart';
import 'package:sportsbet/View/Screens/Home/home_screen.dart';
import 'package:sportsbet/View/Screens/Roshn%20Matches/widget/roshn_match_card.dart';

import '../../../Controller/bet_controller.dart';
import '../../../Core/helper/shared_preference/shared_preference.dart';

class MatchDetailsPage extends StatelessWidget {
  final RoshnMatch fixture;

  const MatchDetailsPage({super.key, required this.fixture});

  @override
  Widget build(BuildContext context) {
    final BetOptionController controller = Get.put(BetOptionController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Details'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoshnMatchCard(fixture: fixture),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Obx(() {
                // Use Obx to automatically rebuild the UI when data changes
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (controller.betOptions.isEmpty) {
                    return const Center(
                      child: Text('No Bet available.'),
                    );
                  }
                  // Ensure that rxBoolList is generated before accessing it
                  if (controller.rxBoolList.isEmpty) {
                    controller.generateBool();
                  }
                }
                return SizedBox(
                  width: Get.width,
                  child: fixture.eventLive != 'half time'
                      ? controller.betOptions.isEmpty
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RefreshIndicator(
                                    onRefresh: () => controller.resetOptions(),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.betOptions.length,
                                      itemBuilder: (context, index) {
                                        final betOption =
                                            controller.betOptions[index];
                                        return Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Obx(
                                                () => CupertinoCheckbox(
                                                  value: controller
                                                      .rxBoolList[index].value,
                                                  onChanged: (value) async {
                                                    for (int i = 0;
                                                        i <
                                                            controller
                                                                .rxBoolList
                                                                .length;
                                                        i++) {
                                                      if (i != index) {
                                                        controller.rxBoolList[i]
                                                            .value = false;
                                                      }
                                                    }
                                                    controller.rxBoolList[index]
                                                        .value = value!;

                                                    controller
                                                        .addDataToFirestore(
                                                            UserPreference
                                                                .getUserid(),
                                                            betOption,
                                                            fixture
                                                                .eventHomeTeam);
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 4, child: Text(betOption))
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  100.ph,
                                  SizedBox(
                                    width: Get.width,
                                    height: 45,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        onPressed: () async {
                                           Navigator.pop(context);
                                        },
                                        child: const FittedBox(
                                          child: Text(
                                            'Save Bet',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            )
                      : const Center(
                          child: Text('Your Bet has been submitted'),
                        ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
