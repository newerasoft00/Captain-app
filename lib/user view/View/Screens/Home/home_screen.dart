import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/user%20view/View/Screens/Profile/profile_screen.dart';
import 'package:sportsbet/user%20view/View/Screens/Roshn%20Matches/roshn_match.dart';

import '../../../Controller/home_controller.dart';
import '../Match Day/match_day_screen.dart';
import '../Roshn Matches/roshn_standings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    controller.changePageIndex(0);
    final bottomBarItem = [
      const RoshnMatchesPage(),
      MatchesScreen(),
      //ToDaysMatchesScreen(),
      RoshnStandingsPage(),
      const ProfileScreen(),
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
                  icon: const Icon(CupertinoIcons.person_fill),
                  label: 'Profile'.tr,
                ),
              ],
            )));
  }
}
