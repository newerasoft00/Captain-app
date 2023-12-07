import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sportsbet/app/modules/Roshn%20Matches/controller/roshn_standings_controller.dart';
import 'package:sportsbet/app/utils/Core/helper/empty_padding.dart';
import 'package:sportsbet/app/widgets/custom_text.dart';
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
    return Column(
      children: [
        ListTile(
          leading: SizedBox(
            width: Get.width * 0.40,
            child: CustomText(
              title: 'Teams'.tr,
              textColor: Theme.of(Get.context!).colorScheme.onSurface,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('G'.tr),
              Text('W'.tr),
              Text('D'.tr),
              Text('L'.tr),
              Text('GF'.tr),
              Text('Pts'.tr),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStandingsItems() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: sportsController.standings.length,
      itemBuilder: (context, index) {
        var standing = sportsController.standings[index];
        return ListTile(
          leading: SizedBox(
            width: Get.width * 0.40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  title: "${standing.standingPlace}",
                  textColor: Theme.of(Get.context!).colorScheme.onSurface,
                  minFontSize: 14,
                  maxFontSize: 16,
                ),
                3.pw,
                _buildTeamLogo(standing.teamLogo),
                3.pw,
                CustomText(
                  title: standing.standingTeam,
                  textColor: Theme.of(Get.context!).colorScheme.onSurface,
                  minFontSize: 14,
                  maxFontSize: 16,
                ),
              ],
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(standing.standingP.toString()),
              Text(standing.standingW.toString()),
              Text(standing.standingD.toString()),
              Text(standing.standingL.toString()),
              Text(standing.standingGD.toString()),
              Text(standing.standingPTS.toString()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTeamLogo(String teamLogoUrl) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CachedNetworkImage(
        imageUrl: teamLogoUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
