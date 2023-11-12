import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/app/modules/bet_league/controller/overall_bet_point_controller.dart';

class UserAppearanceCountsPage extends GetView<OverallBetPointController> {
  const UserAppearanceCountsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OverallBetPointController());
    return Obx(() => RefreshIndicator(
          onRefresh: () async {
            controller.onReady();
          },
          child: Column(
            children: [
              SizedBox(
                height: context.height * 0.035,
                child: ListTile(
                  leading: const Text(' '),
                  title: Text('Standings'.tr),
                  trailing: Text('Total Point'.tr),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.userCounts.length,
                  itemBuilder: (context, index) {
                    final userCount = controller.userCounts[index];
                    return Column(
                      children: [
                        const Divider(
                          indent: 20,
                          endIndent: 20,
                          thickness: 0.5,
                          height: 0.3,
                        ),
                        ListTile(
                          leading: Text('${index + 1}'),
                          title: Text('${userCount['userId']}'),
                          trailing: Text('${userCount['appearanceCount']}'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
