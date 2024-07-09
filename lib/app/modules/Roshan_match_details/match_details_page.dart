import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/custom_appbar.dart';
import 'controller/bet_controller.dart';
import '../Roshn Matches/model/game_weak.dart';
import '../Roshn Matches/widget/bet_options_widget.dart';
import '../Roshn Matches/widget/roshn_match_card.dart';

class MatchDetailsPage extends StatelessWidget {
  final RoshnMatch fixture;

  const MatchDetailsPage({super.key, required this.fixture});

  @override
  Widget build(BuildContext context) {
    final BetOptionController controller = Get.find();

    return Scaffold(
      appBar: CustomAppBar(
        onTap: () {
          Navigator.pop(context);
          controller.userChoice.value = '';
          controller.userChoicescore1.value = '';
          controller.userChoicescore2.value = '';
          controller.awaybetted.value = false;
          controller.drawbetted.value = false;
          controller.homebetted.value = false;
        },
      ),
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
                      : Center(
                          child: Lottie.asset('assets/Image/closed_bet.json',
                              reverse: true, repeat: true),
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
