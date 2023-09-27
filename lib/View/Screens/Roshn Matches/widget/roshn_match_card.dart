import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';

import '../../../../Model/Roshn League/game_weak.dart';

class RoshnMatchCard extends StatelessWidget {
  const RoshnMatchCard({super.key, required this.fixture});
  final RoshnMatch fixture;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    fixture.homeTeamLogo == ''
                        ? Image.asset('assets/Image/def_logo.jpg')
                        : Image.network(
                            fixture.homeTeamLogo,
                            width: Get.width * 0.170,
                            height: Get.width * 0.170,
                          ),
                    5.ph,
                    Text(fixture.eventHomeTeam),
                    5.ph,
                    Text(
                      fixture.eventHomeFormation,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        fixture.eventLive == '0'
                            ? SizedBox(
                                child: FittedBox(
                                  child: Text(
                                    fixture.eventDate,
                                  ),
                                ),
                              )
                            : SizedBox(
                                child: FittedBox(
                                  child: Text(
                                    fixture.eventLive,
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: Get.width * 0.1,
                          height: Get.width * 0.1,
                          child: FittedBox(
                            child: Text(
                              fixture.eventFinalResult,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      fixture.awayTeamLogo,
                      width: Get.width * 0.170,
                      height: Get.width * 0.170,
                    ),
                    5.ph,
                    FittedBox(
                      child: Text(fixture.eventAwayTeam),
                    ),
                    5.ph,
                    Text(
                      fixture.eventAwayFormation,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
