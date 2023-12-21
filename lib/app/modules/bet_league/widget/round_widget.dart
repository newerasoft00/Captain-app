import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/Core/themes/app_text_theme.dart';
import '../../../widgets/custom_text.dart';
import '../controller/overall_bet_point_controller.dart';
import '../model/round_standing_model.dart';

class RoundStandingWidget extends GetView<OverallBetPointController> {
  const RoundStandingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RoundStandingsModel>>(
      future: controller.displayUserAppearanceCounts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
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
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        'Round ${item.roundId}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      children: [
                        Column(
                          children: [
                            ListTile(
                              leading: const SizedBox.shrink(),
                              title: Text('Name'.tr,
                                  style: poppinsMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer)),
                              trailing: Text('Round Point'.tr,
                                  style: poppinsMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: item.userAppearanceCounts.entries
                                  .map((entry) {
                                final userCount =
                                    controller.userCounts.firstWhere(
                                  (user) => user['uid'] == entry.key,
                                  orElse: () => {},
                                );
                                final userName = userCount.isNotEmpty
                                    ? userCount['userId']
                                    : entry.key;
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    child: CustomText(
                                      title: '${index + 1}',
                                      style: poppinsMedium.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer),
                                    ),
                                  ),
                                  title: CustomText(
                                    title: '$userName',
                                    style: poppinsMedium.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                                  ),
                                  trailing: CustomText(
                                    title: '${userCount['appearanceCount']}',
                                    style: poppinsMedium.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
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
