import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Model/bet/round_standing_model.dart';

import '../../../../Controller/Round Point/overall_bet_point_controller.dart';
import '../../../../Controller/Round Point/user_round_point.dart';


class RoundStandingWidget extends StatelessWidget {
  const RoundStandingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RoundPintController());
    final controller = Get.put(OverallBetPointController());
    return FutureBuilder<List<RoundStandingsModel>>(
      future: controller.displayUserAppearanceCounts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<RoundStandingsModel>? data = snapshot.data;
          return RefreshIndicator(
            onRefresh: () async {
              controller.onReady();
            },
            child: ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                RoundStandingsModel item = data![index];
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ExpansionTile(
                    title: Text(item.roundId),
                    children: [
                      Obx(
                        () => Column(
                          children: [
                            ListTile(
                              leading: const Text(' '),
                              title: Text('Name'.tr),
                              trailing: Text("Round Point".tr),
                            ),
                            const Divider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: item.userAppearanceCounts.entries
                                  .map((entry) {
                                // Check if userCounts contains the uid
                                final userCount = controller.userCounts
                                    .firstWhere(
                                        (user) => user['uid'] == entry.key,
                                        orElse: () => {});
                                // If userCount is found, use userId, else use entry.key
                                final userName = userCount.isNotEmpty
                                    ? userCount['userId']
                                    : entry.key;

                                return ListTile(
                                  leading: Text('${entry.value}'),
                                  title: Text(userName),
                                  trailing: Text(
                                    "${entry.value}",
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
