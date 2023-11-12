import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/app/modules/Roshn%20Matches/controller/roshn_standings_controller.dart';
import 'package:sportsbet/app/utils/Core/helper/empty_padding.dart';
import '../../utils/Core/themes/theme_controller.dart';
import 'roshn_topscorer_screen.dart';


class RoshnStandingsPage extends StatelessWidget {
  final RoshnStandingsController sportsController =
      Get.put(RoshnStandingsController());
  final ThemeController themeController = Get.find();

  RoshnStandingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text('Roshn League'.tr),
                centerTitle: true,
                pinned: true,
                floating: true,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        'Standings'.tr,
                        softWrap: true,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Top Scorers'.tr,
                        softWrap: true,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Obx(
                () {
                  if (sportsController.standings.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else {
                    return ListView(
                      primary: true,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              child: ListTile(
                                leading: SizedBox(
                                    width: Get.width * 0.40,
                                    child: Text('Teams'.tr)),
                                title: Padding(
                                  padding: const EdgeInsets.only(right: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'G'.tr,
                                      ),
                                      Text(
                                        'W'.tr,
                                      ),
                                      Text(
                                        'D'.tr,
                                      ),
                                      Text(
                                        'L'.tr,
                                      ),
                                      Text(
                                        'GF'.tr,
                                      ),
                                      /*  Text('GA'),
                                  Text('GD'), */
                                      Text(
                                        'Pts'.tr,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            10.ph,
                            RefreshIndicator(
                              onRefresh: () async {
                                sportsController.standings.clear();
                                sportsController.fetchData();
                              },
                              child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: sportsController.standings.length,
                                itemBuilder: (context, index) {
                                  var standing =
                                      sportsController.standings[index];
                                  return ListTile(
                                    leading: SizedBox(
                                      width: Get.width * 0.40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("${standing.standingPlace}"),
                                          3.pw,
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: CachedNetworkImage(
                                              imageUrl: standing.teamLogo,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                          3.pw,
                                          FittedBox(
                                              child: Text(
                                            standing.standingTeam,
                                          )),
                                        ],
                                      ),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.only(right: 3),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            standing.standingP.toString(),
                                          ),
                                          Text(
                                            standing.standingW.toString(),
                                          ),
                                          Text(
                                            standing.standingD.toString(),
                                          ),
                                          Text(
                                            standing.standingL.toString(),
                                          ),
                                          /*  Text(standing.standingF.toString()),
                                      Text(standing.standingA.toString()), */
                                          Text(
                                            standing.standingGD.toString(),
                                          ),
                                          Text(
                                            standing.standingPTS.toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                },
              ),
              RoshnTopScorersPage(),
            ],
          ),
        ),
      ),
    );
  }
}
