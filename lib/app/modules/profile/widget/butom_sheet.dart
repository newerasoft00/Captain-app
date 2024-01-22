import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:captain/app/widgets/custom_text.dart';
import '../../../utils/Core/themes/app_text_theme.dart';
import '../controller/profile_controller.dart';

class CupertinoActionSheetWidget extends StatelessWidget {
  final Map<String, Map<String, dynamic>> leagues;
  final ProfileController controller;

  const CupertinoActionSheetWidget(
      {super.key, required this.leagues, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.5,
      child: CupertinoActionSheet(
        title: Text('Select your favorite League'.tr),
        actions: leagues.keys.map((leagueName) {
          final subMap = leagues[leagueName]!;
          final imageUrl = subMap.keys.first;

          return CupertinoActionSheetAction(
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator.adaptive(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 10),
                Text(leagueName.tr),
              ],
            ),
            onPressed: () async {
              controller.handleLeagueSelection(subMap, leagueName);
            },
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'.tr),
        ),
      ),
    );
  }
}

class MaterialBottomSheetWidget extends StatelessWidget {
  final Map<String, Map<String, dynamic>> leagues;
  final ProfileController controller;

  const MaterialBottomSheetWidget(
      {super.key, required this.leagues, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.5,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Wrap(
            children: leagues.keys.map((leagueName) {
              final subMap = leagues[leagueName]!;
              final imageUrl = subMap.keys.first;

              return ListTile(
                tileColor: Theme.of(context).colorScheme.surface,
                leading: SizedBox(
                  width: 40,
                  height: 40,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator.adaptive(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                title: CustomText(
                  title: leagueName.tr,
                  style: poppinsMedium.copyWith(
                    color: Theme.of(Get.context!).colorScheme.onSurface,
                  ),
                ),
                onTap: () async {
                  controller.handleLeagueSelection(subMap, leagueName);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
