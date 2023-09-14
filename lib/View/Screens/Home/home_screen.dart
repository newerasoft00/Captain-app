import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsbet/Controller/home_controller.dart';
import 'package:sportsbet/View/Screens/Profile/profile_screen.dart';
import 'package:sportsbet/View/Screens/standing/standings.dart';
import '../Match Day/match_day_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    final bottomBarItem = [
      const StandingsScreen(),
      MatchScreen(),
      const ProfileScreen(),
    ];

    // List of team names and scores

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Roshn Bet',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: Obx(() => IndexedStack(
            index: controller.pageindex.value,
            children: bottomBarItem,
          )),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.pageindex.value,
          onTap: (value) {
            controller.changePageIndex(value);
          },
          showSelectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.table_rows_rounded),
              label: 'Standings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_basketball),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
