import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sportsbet/app/modules/Roshn%20Matches/controller/roshn_standings_controller.dart';
import 'package:sportsbet/app/widgets/custom_text.dart';
import '../../utils/Core/themes/app_text_theme.dart';
import '../../utils/Core/themes/theme_controller.dart';
import 'roshn_topscorer_screen.dart';

class RoshnStandingsPage extends StatelessWidget {
  final RoshnStandingsController sportsController = Get.find();
  final ThemeController themeController = Get.find();

  RoshnStandingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              _buildSliverAppBar(),
            ];
          },
          body: TabBarView(
            children: [
              _buildStandingsTab(),
              RoshnTopScorersPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      title: Text('Roshn League'.tr),
      centerTitle: true,
      pinned: true,
      floating: true,
      snap: true,
      bottom: TabBar(
        tabs: [
          _buildTab('Standings'.tr),
          _buildTab('Top Scorers'.tr),
        ],
      ),
    );
  }

  Widget _buildTab(String title) {
    return Tab(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStandingsTab() {
    return Obx(() {
      if (sportsController.standings.isEmpty) {
        return _buildLoadingIndicator();
      } else {
        return _buildStandingsList();
      }
    });
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  Widget _buildStandingsList() {
    return RefreshIndicator(
      onRefresh: () async {
        sportsController.standings.clear();
        sportsController.fetchData();
      },
      child: ListView(
        children: [
          _buildStandingsHeader(),
          _buildStandingsItems(),
        ],
      ),
    );
  }

  Widget _buildStandingsHeader() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListTile(
        tileColor: Theme.of(Get.context!).colorScheme.primary,
        leading: SizedBox(
          width: Get.width * 0.40,
          child: CustomText(
            title: 'Teams'.tr,
            isBlack: false,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              title: 'G'.tr,
              isBlack: false,
            ),
            CustomText(
              title: 'W'.tr,
              isBlack: false,
            ),
            CustomText(
              title: 'D'.tr,
              isBlack: false,
            ),
            CustomText(
              title: 'L'.tr,
              isBlack: false,
            ),
            CustomText(
              title: 'GF'.tr,
              isBlack: false,
            ),
            CustomText(
              title: 'Pts'.tr,
              isBlack: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandingsItems() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: sportsController.standings.length,
      itemBuilder: (context, index) {
        var standing = sportsController.standings[index];
        return Padding(
          padding: const EdgeInsets.all(3),
          child: ListTile(
            leading: SizedBox(
              width: Get.width * 0.40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomText(
                      title: "${standing.standingPlace}",
                      minFontSize: 14,
                      maxFontSize: 16,
                      style: poppinsMedium.copyWith(
                        color: Theme.of(Get.context!).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Expanded(flex: 3, child: _buildTeamLogo(standing.teamLogo)),
                  Expanded(
                    flex: 5,
                    child: CustomText(
                      title: standing.standingTeam,
                      minFontSize: 14,
                      maxFontSize: 16,
                      style: poppinsMedium.copyWith(
                        color: Theme.of(Get.context!).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: standing.standingP.toString(),
                ),
                CustomText(title: standing.standingW.toString()),
                CustomText(title: standing.standingD.toString()),
                CustomText(title: standing.standingL.toString()),
                CustomText(title: standing.standingGD.toString()),
                CustomText(title: standing.standingPTS.toString()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTeamLogo(String teamLogoUrl) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Theme.of(Get.context!).colorScheme.onPrimary,
        child: CachedNetworkImage(
          width: 24,
          imageUrl: teamLogoUrl,
          placeholder: (context, url) =>
              const CircularProgressIndicator.adaptive(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
