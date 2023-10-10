import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/user%20view/View/Screens/Match%20Day/todays_matches.dart';
import 'package:sportsbet/user%20view/View/Screens/Profile/profile_screen.dart';
import 'package:sportsbet/user%20view/View/Screens/Roshn%20Matches/roshn_match.dart';
import '../../../Controller/home_controller.dart';
import '../Match Day/match_day_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
        //extendBody: true,
        body: Obx(() => Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: IndexedStack(
                index: controller.pageindex.value,
                children: bottomBarItem,
              ),
            )),
        bottomNavigationBar: Obx(
          () => Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 5,
                      offset: Offset(-1, 1),
                      color: Color.fromARGB(68, 177, 177, 177))
                ],
                color: const Color(0xffBBC7DB),
                borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(11),
              child: GNav(
                // tab animation duration
                gap: 8,
                color: const Color(0xff61677A), // unselected icon color
                activeColor: Colors.white, // selected icon and text color
                backgroundColor: const Color(0xffBBC7DB),
                tabBackgroundColor: const Color.fromARGB(
                    255, 0, 80, 141), // selected tab background color
                padding: const EdgeInsets.all(16),
                tabs: const [
                  GButton(
                    icon: CupertinoIcons.calendar_today,
                    text: 'Fixture',
                  ),
                  GButton(
                    icon: CupertinoIcons.gamecontroller_alt_fill,
                    text: 'Home',
                  ),
                  GButton(
                    icon: CupertinoIcons.text_badge_star,
                    text: 'Standing',
                  ),
                  GButton(
                    icon: CupertinoIcons.person_solid,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: controller.pageindex.value,
                onTabChange: (index) {
                  controller.changePageIndex(index);
                },
              ),
            ),
          ),
        ));
  }
}
