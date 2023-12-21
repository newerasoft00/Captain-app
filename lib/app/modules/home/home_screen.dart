import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/app/modules/Roshn%20Matches/roshn_match.dart';
import 'package:sportsbet/app/modules/Roshn%20Matches/roshn_standings.dart';
import '../Match Day/match_day_screen.dart';
import '../Profile/profile_screen.dart';
import '../bet_league/bet_league.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.changePageIndex(0);
    final bottomBarItem = [
      const RoshnMatchesPage(),
      MatchesScreen(),
      RoshnStandingsPage(),
      const BetLeague(),
      ProfileScreen(),
    ];

    return Scaffold(
        body: Obx(() => IndexedStack(
              index: controller.pageindex.value,
              children: bottomBarItem,
            )),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              currentIndex: controller.pageindex.value,
              onTap: (index) {
                controller.changePageIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  icon: const Icon(CupertinoIcons.house_alt_fill),
                  label: 'Home'.tr,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.timer_fill),
                  label: 'Live'.tr,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.library_books_rounded),
                  label: 'Roshan League'.tr,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.star_rounded),
                  label: 'Bet League'.tr,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.person_fill),
                  label: 'Profile'.tr,
                ),
              ],
            )));
  }
}
