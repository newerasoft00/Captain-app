import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:captain/app/modules/bet_league/controller/overall_bet_point_controller.dart';
import 'package:captain/app/utils/Core/themes/app_text_theme.dart';
import 'package:captain/app/widgets/custom_text.dart';

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
                color: Theme.of(context).appBarTheme.backgroundColor,
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      title: 'Standings'.tr,
                      maxFontSize: 20,
                      minFontSize: 18,
                      style: poppinsMedium.copyWith(
                          color: Theme.of(context).colorScheme.surface),
                    ),
                    CustomText(
                      title: 'Total Point'.tr,
                      maxFontSize: 20,
                      minFontSize: 18,
                      style: poppinsMedium.copyWith(
                          color: Theme.of(context).colorScheme.surface),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: ListView.builder(
                    itemCount: controller.userCounts.length,
                    itemBuilder: (context, index) {
                      final userCount = controller.userCounts[index];
                      return ListTile(
                        tileColor: Colors.transparent,
                        leading: CircleAvatar(
                          backgroundColor: (index <= 2)
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5),
                          child: CustomText(
                            title: '${index + 1}',
                            style: poppinsMedium.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary),
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
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
