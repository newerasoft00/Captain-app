import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Controller/home_controller.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';

class SelectedMatchCard extends StatelessWidget {
  const SelectedMatchCard(
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
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      10.pw,
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(
                          'assets/Image/Al-Ahly.png',
                        ),
                      ),
                      10.ph,
                      Text(teamname1),
                    ],
                  )),
              20.pw,
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      score1,
                      style: const TextStyle(fontSize: 18),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                            width: 35, child: LinearProgressIndicator()),
                        7.ph,
                        SizedBox(
                            width: 40,
                            child: Center(
                                child: Text(
                              '${c.timerValue.value.toInt()}',
                              style: const TextStyle(fontSize: 18),
                            ))),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      score2,
                      style: const TextStyle(fontSize: 18),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      10.pw,
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(
                          'assets/Image/Al-Hilal-Logo.png',
                        ),
                      ),
                      5.ph,
                      Text(teamname2),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
