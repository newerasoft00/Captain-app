import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/app/modules/bet_league/controller/overall_bet_point_controller.dart';
import 'package:sportsbet/app/utils/Core/themes/app_text_theme.dart';
import 'package:sportsbet/app/widgets/custom_text.dart';

class UserAppearanceCountsPage extends GetView<OverallBetPointController> {
  const UserAppearanceCountsPage({super.key});
  @override
  Widget build(BuildContext context) {
    OverallBetPointController controller = Get.find();
    return Obx(() => RefreshIndicator(
          onRefresh: () async {
            controller.onReady();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.secondary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      title: 'Standings'.tr,
                      maxFontSize: 20,
                      minFontSize: 18,
                    ),
                    CustomText(
                      title: 'Total Point'.tr,
                    ),
                  ],
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
                          thickness: 0.2,
                          height: 0.3,
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: (index == 0 ||
                                    index == 1 ||
                                    index == 2)
                                ? Theme.of(context).colorScheme.primaryContainer
                                : Theme.of(context).cardColor.withOpacity(0.3),
                            child: CustomText(
                              title: '${index + 1}',
                            ),
                          ),
                          title: CustomText(
                            title: '${userCount['userId']}',
                            style: poppinsMedium.copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
                          trailing: CustomText(
                            title: '${userCount['appearanceCount']}',
                            style: poppinsMedium.copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
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
