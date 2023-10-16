import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/User%20View/Controller/bet_controller.dart';
import 'package:sportsbet/user%20view/View/Screens/Roshn%20Matches/widget/roshn_match_card.dart';

import '../../../../Model/Roshn League/game_weak.dart';
import 'widget/bet_options_widget.dart';

class MatchDetailsPage extends StatelessWidget {
  final RoshnMatch fixture;

  const MatchDetailsPage({super.key, required this.fixture});

  @override
  Widget build(BuildContext context) {
    final BetOptionController controller = Get.put(BetOptionController());

    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
                controller.userChoice.value = '';
                controller.userChoicescore1.value = '';
                controller.userChoicescore2.value = '';
                controller.awaybetted.value = false;
                controller.drawbetted.value = false;
                controller.homebetted.value = false;
              })),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoshnMatchCard(fixture: fixture),
            Divider(color: Colors.grey.shade300),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Obx(() {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SizedBox(
                  width: double.infinity,
                  child: (fixture.eventLive == '0' && fixture.eventStatus == '')
                      ? Column(
                          children: [
                            controller.betOptions.isEmpty
                                ? BetOptionsWidget(fixture: fixture)
                                : const SizedBox(),
                          ],
                        )
                      : const Center(
                          child: Text('Bet closed for this match'),
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
