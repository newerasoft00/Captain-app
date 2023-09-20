import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Controller/home_controller.dart';
import 'package:sportsbet/Core/themes/dark_light_theme_file.dart';
import 'package:sportsbet/Core/utils/color.dart';
import 'package:sportsbet/View/Screens/Match%20Day/todays_matches.dart';
import 'package:sportsbet/View/Screens/Profile/profile_screen.dart';
import 'package:sportsbet/View/Screens/Roshn%20Matches/roshn_match.dart';
import 'package:sportsbet/View/Screens/Roshn%20Matches/roshn_topscorer_screen.dart';
import '../Match Day/match_day_screen.dart';
import '../Roshn Matches/roshn_standings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    final bottomBarItem = [
      RoshnStandingsPage(),
      MatchesScreen(),
      ToDaysMatchesScreen(),
      const ProfileScreen(),
      RoshnTopScorersPage(),
      RoshnMatchesPage(),
    ];

    // List of team names and scores

    return Scaffold(
      body: Obx(() => Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
            child: IndexedStack(
              index: controller.pageindex.value,
              children: bottomBarItem,
            ),
          )),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.pageindex.value,
          onTap: (value) {
            controller.changePageIndex(value);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_list_fill),
                label: 'Standings',
                backgroundColor: darkMaincolor2),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_basketball),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.date_range_rounded),
              label: 'ToDay',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: darkMaincolor2,
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chart_bar_circle_fill),
              label: 'Top Scorer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_rounded),
              label: 'Fixture',
            ),
          ],
        ),
      ),
    );
  }
}
