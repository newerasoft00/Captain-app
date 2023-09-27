import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Core/helper/empty_padding.dart';

import '../../../Controller/Roshn Matches/roshn_standings_controller.dart';

class RoshnStandingsPage extends StatelessWidget {
  final RoshnStandingsController sportsController =
      Get.put(RoshnStandingsController());

  RoshnStandingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () {
          if (sportsController.standings.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: ListTile(
                      leading: SizedBox(
                          width: Get.width * 0.37, child: const Text('Teams')),
                      title: const Padding(
                        padding: EdgeInsets.only(right: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('G'),
                            Text('W'),
                            Text('D'),
                            Text('L'),
                            Text('GF'),
                            Text('GA'),
                            Text('GD'),
                            Text('Pts'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  10.ph,
                  SizedBox(
                    height: Get.height - 35,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        sportsController.standings.clear();
                        sportsController.fetchData();
                      },
                      child: ListView.builder(
                        primary: true,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: sportsController.standings.length,
                        itemBuilder: (context, index) {
                          var standing = sportsController.standings[index];
                          return ListTile(
                            leading: SizedBox(
                              width: Get.width * 0.37,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("${standing.standingPlace}"),
                                  3.pw,
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.network(standing.teamLogo),
                                  ),
                                  3.pw,
                                  FittedBox(child: Text(standing.standingTeam)),
                                ],
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(right: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(standing.standingP.toString()),
                                  Text(standing.standingW.toString()),
                                  Text(standing.standingD.toString()),
                                  Text(standing.standingL.toString()),
                                  Text(standing.standingF.toString()),
                                  Text(standing.standingA.toString()),
                                  Text(standing.standingGD.toString()),
                                  Text(standing.standingPTS.toString()),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
