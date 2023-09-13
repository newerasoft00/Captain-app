import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Controller/home_controller.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';

class MatchCard extends StatelessWidget {
  const MatchCard(
      {super.key,
      required this.teamname1,
      required this.score1,
      required this.score2,
      required this.teamname2});
  final String teamname1;
  final String teamname2;
  final String score1;
  final String score2;

  @override
  Widget build(BuildContext context) {
    final HomeController c = Get.put(HomeController());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        elevation: 2,
        child: SizedBox(
          width: Get.width,
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(),
              Expanded(
                  flex: 1,
                  child: Obx(() => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                              width: 20, child: LinearProgressIndicator()),
                          5.ph,
                          SizedBox(
                              width: 45,
                              child: Center(
                                  child: Row(
                                children: [
                                  const Text(
                                    '2st',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    ' ${c.timerValue.value.toInt()}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ))),
                        ],
                      ))),
              20.pw,
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 35,
                            height: 35,
                            child: Image.asset(
                              'assets/Image/Al-Ahly.png',
                            ),
                          ),
                          5.pw,
                          Text(teamname1),
                          const Spacer(),
                          Text(score1),
                        ],
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 35,
                            height: 35,
                            child: Image.asset(
                              'assets/Image/Al-Hilal-Logo.png',
                            ),
                          ),
                          5.pw,
                          Text(teamname2),
                          const Spacer(),
                          Text(score2),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
